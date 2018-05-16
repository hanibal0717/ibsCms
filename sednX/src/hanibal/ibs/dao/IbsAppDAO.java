package hanibal.ibs.dao;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.nimbusds.jose.JOSEException;
import com.nimbusds.jose.JWSAlgorithm;
import com.nimbusds.jose.JWSHeader;
import com.nimbusds.jose.JWSSigner;
import com.nimbusds.jose.crypto.MACSigner;
import com.nimbusds.jwt.JWT;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;

import hanibal.ibs.library.HanibalWebDev;
import hanibal.ibs.model.app.VodListAppDTO;

public class IbsAppDAO {
	Logger log = Logger.getLogger(this.getClass());
	public void setSqlMapper(SqlMapClient sqlMapper) {
	}
	public void setSqlFactory(SqlSessionFactory sqlFactory) {
	}
	
	private SqlSessionTemplate sqlTemplate;	
	public void setSqlTemplate(SqlSessionTemplate sqlTemplate) {
		this.sqlTemplate = sqlTemplate;
	}
	SqlMapClientTemplate sqlMapTemplate;
	public void setSqlMapTemplate(SqlMapClientTemplate sqlMapTemplate) {
		this.sqlMapTemplate = sqlMapTemplate;
	}

	public String checkLogin(Map<String, Object> commandMap) throws Exception {
		String result="";
		//아이디 체크
		String auth_id=java.net.URLDecoder.decode((String) commandMap.get("auth_id"),"UFT-8");
		commandMap.put("auth_pass",java.net.URLDecoder.decode((String)commandMap.get("auth_pass"),"UFT-8"));
		log.info(auth_id+"/"+commandMap.get("auth_pass"));
		int idCount=sqlTemplate.selectOne("checkId",auth_id);
		if(idCount==0) {
			result="missId";
		}else{
			//비밀번호 체크
			String auth_token=sqlTemplate.selectOne("auth_token",commandMap);
			if(auth_token==null) {
				result="missPass";
			}else {
				result="success";

			}
		}
		
		return result;
	}
	public String getToken(Map<String, Object> commandMap) throws JOSEException, Throwable {
		SecureRandom random = new SecureRandom();
		byte[] sharedSecret = new byte[32];
		random.nextBytes(sharedSecret);
		JWSSigner signer=new MACSigner(sharedSecret);
		JWTClaimsSet claimsSet = new JWTClaimsSet.Builder()
                .claim("member_id",commandMap.get("auth_id"))
                .claim("mamber_pass",commandMap.get("auth_pass"))
                .build();
		SignedJWT signedJWT = new SignedJWT(new JWSHeader(JWSAlgorithm.HS256), claimsSet);
		try {
			signedJWT.sign(signer);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String jwtString = signedJWT.serialize();
		sqlTemplate.insert("insertToken",jwtString);
		/*JWT signeJWTReturn = (SignedJWT)SignedJWT.parse(jwtString);
		log.info(signeJWTReturn.getJWTClaimsSet().getClaim("id"));*/
		
		return jwtString;
	}
	public int checkToken(String token) {
		int affectCount=sqlTemplate.selectOne("checkToken",token);
		return affectCount;
	}
	public List<VodListAppDTO> getBannerList(String category, String mediaIp) {
		HashMap<String,Object> resultMap=sqlTemplate.selectOne("getLayOutCategorys",Integer.parseInt(category));
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="";
		if(((String)resultMap.get("wl_categorys")).length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray((String)resultMap.get("wl_categorys"));
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		log.info((String)resultMap.get("wl_sort"));
		map.put("wl_sort",(String)resultMap.get("wl_sort"));
		map.put("eachFlag",eachFlag);
		List<VodListAppDTO> lists=sqlTemplate.selectList("bannerlist",map);
		for(int i=0;i<lists.size();i++) {
			lists.get(i).setMain_thumbnail("/REPOSITORY/THUMBNAIL"+HanibalWebDev.getDataPath(lists.get(i).getMain_thumbnail())+lists.get(i).getMain_thumbnail());
			lists.get(i).setVod_path("http://"+mediaIp+"/VOD"+HanibalWebDev.getDataPath(lists.get(i).getVod_path())+lists.get(i).getVod_path()+"/index.m3u8");
		}
		return lists;
	}


	public List<VodListAppDTO> getMainList(String mediaIp) throws Exception {
		int category=1;
		List<Integer> layoutLists=sqlTemplate.selectList("getChildIdx",category);
		List<VodListAppDTO> lists=new ArrayList<VodListAppDTO>(); 
		for(int i=0;i<layoutLists.size();i++) {
			Map<String,Object> map= new HashMap<String,Object>();
			String eachFlag="";
			int childIdxArr[]=HanibalWebDev.StringToIntArray(HanibalWebDev.getChildIdx(layoutLists.get(i)));
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
			map.put("wl_sort","R");
			map.put("eachFlag",eachFlag);
			List<VodListAppDTO> addlists=sqlTemplate.selectList("mainLayoutlist",map);
			lists.addAll(addlists);
		}
		for(int i=0;i<lists.size();i++) {
			lists.get(i).setMain_thumbnail("/REPOSITORY/THUMBNAIL"+HanibalWebDev.getDataPath(lists.get(i).getMain_thumbnail())+lists.get(i).getMain_thumbnail());
			lists.get(i).setVod_path("http://"+mediaIp+"/VOD"+HanibalWebDev.getDataPath(lists.get(i).getVod_path())+lists.get(i).getVod_path()+"/index.m3u8");
		}
		return lists;
	}
	public List<VodListAppDTO> getSubist(Map<String, Object> commandMap, String mediaIp) throws Exception {
		int start=0;
		int end=start+10;
		if(Integer.parseInt((String) commandMap.get("start_num"))>-1) {
			start=Integer.parseInt((String) commandMap.get("start_num"));
		}
		int category=Math.abs(Integer.parseInt((String) commandMap.get("board_cate_idx")));
		List<Integer> layoutLists=sqlTemplate.selectList("getChildIdx",category);
		List<VodListAppDTO> lists=new ArrayList<VodListAppDTO>(); 
		if(layoutLists.size()==0) {
			layoutLists.add(category);
		}
		for(int i=0;i<layoutLists.size();i++) {
			Map<String,Object> map= new HashMap<String,Object>();
			String eachFlag="";
			eachFlag="Y";
			int [] childIdxArr;
			if(category==1) {
				childIdxArr=HanibalWebDev.StringToIntArray(HanibalWebDev.getChildIdx(layoutLists.get(i)));
			}else{
				childIdxArr=HanibalWebDev.StringToIntArray(String.valueOf(layoutLists.get(i)));
			}
			map.put("childIdxArr",childIdxArr);
			map.put("wl_sort","R");
			map.put("start",start);
			map.put("end",end);
			map.put("eachFlag",eachFlag);
			log.info("map :"+String.valueOf(map.get("childIdxArr")));
			List<VodListAppDTO> addlists=sqlTemplate.selectList("subLayoutlist",map);
			lists.addAll(addlists);
		}
		for(int i=0;i<lists.size();i++) {
			lists.get(i).setMain_thumbnail("/REPOSITORY/THUMBNAIL"+HanibalWebDev.getDataPath(lists.get(i).getMain_thumbnail())+lists.get(i).getMain_thumbnail());
			lists.get(i).setVod_path("http://"+mediaIp+"/VOD"+HanibalWebDev.getDataPath(lists.get(i).getVod_path())+lists.get(i).getVod_path()+"/index.m3u8");
		}
		return lists;
	}
	public List<HashMap<String, Object>> getParentList(int category) {
		List<HashMap<String, Object>> lists=sqlTemplate.selectList("getParentList",category);
		return lists;
	}
	public List<HashMap<String, Object>> getSibling(int category) throws IOException {
		category=Math.abs(category);
		List<HashMap<String, Object>> lists=new ArrayList<HashMap<String, Object>>(); 
		if(category==1) {
			lists=sqlTemplate.selectList("getParentList",category);
		}else {
			category=HanibalWebDev.getParent("tb_board_category",String.valueOf(category));
			lists=sqlTemplate.selectList("getParentList",category);
		}
		return lists;
	}
	public Map<String, Object> getDetailView(Map<String, Object> commandMap) throws ParseException {
		JWT signeJWTReturn = (SignedJWT)SignedJWT.parse((String) commandMap.get("token"));
		commandMap.put("member_id",signeJWTReturn.getJWTClaimsSet().getClaim("member_id"));
		Map<String, Object> map=sqlTemplate.selectOne("getDetailView",commandMap);
		String fileName=(String)map.get("vod_path");
		map.put("vod_down_path","/api/app/download/vod/mp4/"+fileName.replace(".mp4",""));
		map.put("main_thumbnail","/REPOSITORY/THUMBNAIL"+HanibalWebDev.getDataPath((String)map.get("main_thumbnail"))+(String)map.get("main_thumbnail"));
		map.put("vod_path","http://"+commandMap.get("mediaIp")+"/VOD"+HanibalWebDev.getDataPath((String)map.get("vod_path"))+(String)map.get("vod_path")+"/index.m3u8");
		if(Integer.parseInt(String.valueOf(map.get("favorite_yn")))==0) {
			map.put("favorite_yn","N");
		}else {
			map.put("favorite_yn","Y");
		}
		map.put("vod_volume", Long.parseLong((String)map.get("vod_volume")));
		return map;
	}
	
	public int insertFavorite(Map<String, Object> commandMap) throws ParseException {
		JWT signeJWTReturn = (SignedJWT)SignedJWT.parse((String) commandMap.get("token"));
		commandMap.put("member_id",signeJWTReturn.getJWTClaimsSet().getClaim("member_id"));
		int count=sqlTemplate.selectOne("favorite_count", commandMap);
		int affectCount=0;
		if(count==0) {
			affectCount=sqlTemplate.insert("insertFavorite", commandMap);
		}
		return affectCount;
	}
	public void deleteFavorite(Map<String, Object> commandMap) throws ParseException {
		JWT signeJWTReturn = (SignedJWT)SignedJWT.parse((String) commandMap.get("token"));
		commandMap.put("member_id",signeJWTReturn.getJWTClaimsSet().getClaim("member_id"));
		sqlTemplate.update("deleteFavorite",commandMap);
	}

	public void fileDownLoad(String path, HttpServletResponse res, HttpServletRequest req) throws Exception {
		File f= new File(path);
		res.setContentType("application/x-msdownload");
		res.setContentLength((int)f.length());
		boolean flag=req.getHeader("user-agent").toUpperCase().indexOf("MSIE")!=-1;
		if(flag) res.setHeader("Content-Disposition","attachment;filename="+URLEncoder.encode(f.getName(),"utf-8"));
		else res.setHeader("Content-Disposition","attachment;filename="+new String(f.getName().getBytes("UTF-8"),"8859_1"));
		BufferedInputStream bis=new BufferedInputStream(new FileInputStream(f));
		BufferedOutputStream bos=new BufferedOutputStream(res.getOutputStream());
		int data=0;
		byte[] buffer=new byte[1024];
		while((data=bis.read(buffer,0,1024))!=-1){
			bos.write(buffer,0,data);
			bos.flush();
		}
		bos.close();
		bis.close();
	}
}