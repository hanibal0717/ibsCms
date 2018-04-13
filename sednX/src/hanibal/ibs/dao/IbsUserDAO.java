package hanibal.ibs.dao;


import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import com.ibatis.sqlmap.client.SqlMapClient;

import hanibal.ibs.model.webapi.MainContents;

public class IbsUserDAO {
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

	//LOGIN INSERT 
	public void SednLogInsert(Map<String, Object> param) {
		sqlTemplate.selectList("SednLogInsert",param);
	}
	
	//LayoutImage가져오기	
	public List<Map<String,Object>> layoutImage() {
		return sqlTemplate.selectList("layoutImage");
	}
	
	//메뉴바가져오기
	public List<Map<String,Object>> ShowViewMenuBar(Map<String,Object> commandMap) {
		List<Map<String,Object>> lists=sqlTemplate.selectList("ShowViewMenuBar",commandMap);
		return lists;
	}
	
	//LayoutMenuList
	public List<Map<String,Object>> LayoutMenuList(Map<String,Object> commandMap) {
		List<Map<String,Object>> lists=sqlTemplate.selectList("LayoutMenuList",commandMap);
		return lists;
	}
	
	//LayoutMenu에 등록 되어있는 vod List 가져오기
	public List<Map<String,Object>> MainLaoutVodList(Map<String, Object> commandMap) {
		List<Map<String,Object>> lists=sqlTemplate.selectList("MainLaoutVodList",commandMap);
		return lists;
	}
	
	//VOD SEARCH, VIEW등 데이터 가져오기
	public List<Map<String,Object>> MainVodAllList(Map<String,Object> commandMap) {
		List<Map<String,Object>> lists=sqlTemplate.selectList("MainVodAllList",commandMap);
		return lists;
	}
	
	//해당 show view의 게시판 이미지 가져오기   
	public List<Map<String,Object>> ModelImageList(Map<String,Object> commandMap) {
		List<Map<String,Object>> lists=sqlTemplate.selectList("ModelImageList",commandMap);
		return lists;
	}
	//Model에 들어갈 File가져오기
	public List<Map<String,Object>> ModelFileViewList(Map<String,Object> commandMap) {
		List<Map<String,Object>> lists=sqlTemplate.selectList("ModelFileViewList",commandMap);
		return lists;
	}
	
	//좋아요 1씩 증가
	public void VodFavoriteCount(Map<String, Object> param) {
		sqlTemplate.selectList("VodFavoriteCount",param);
	}
	
	//플레이어 1씩 증가
	public void VodViewCountInsert(Map<String, Object> param) {
		sqlTemplate.selectList("VodViewCountInsert",param);
	}
	
	//자식 MenuBar 클릭 시 Title 가져오기 (BOARD > INFO 용산)
	public List<Map<String,Object>> MenuChildTitle(Map<String,Object> commandMap) {
		List<Map<String,Object>> lists=sqlTemplate.selectList("MenuChildTitle",commandMap);
		return lists;
	}
	//Search시 keyword가져오기
	public List<Map<String,Object>> MainVodKeyWord(Map<String, Object> commandMap) {
		List<Map<String,Object>> lists=sqlTemplate.selectList("MainVodKeyWord",commandMap);
		return lists;
	}
	
	//ChannelData가져오기
	public List<Map<String,Object>> ChannelData(Map<String, Object> commandMap) {
		List<Map<String,Object>> lists=sqlTemplate.selectList("ChannelData",commandMap);
		return lists;
	}
	
	//Channel가져오기
	public List<Map<String,Object>> Channel(Map<String, Object> commandMap) {
		List<Map<String,Object>> lists=sqlTemplate.selectList("Channel",commandMap);
		return lists;
	}
	
	//	CalendarDate가져오기
	public List<Map<String,Object>> CalendarDate(Map<String, Object> commandMap) {
		List<Map<String,Object>> lists=sqlTemplate.selectList("CalendarDate",commandMap);
		return lists;
	}
	//	방송 여부
	public List<Map<String,Object>> BroadcastingTime(Map<String, Object> commandMap) {
		List<Map<String,Object>> lists=sqlTemplate.selectList("BroadcastingTime",commandMap);
		return lists;
	}
	
	//	방송 여부
	public List<Map<String,Object>> RePlayClok(Map<String, Object> commandMap) {
		List<Map<String,Object>> lists=sqlTemplate.selectList("RePlayClok",commandMap);
		return lists;
	}
	
	
	
	
	//	Live Vod가져오기
	public List<Map<String,Object>> VodChannel(Map<String, Object> commandMap) {
		List<Map<String,Object>> lists=sqlTemplate.selectList("VodChannel",commandMap);
		return lists;
	}	
	
	//다운로드
	public void fileDownLoad(String path, HttpServletResponse response, HttpServletRequest request) throws Exception {
   	 
		  
		 File file = new File(path);

		  String userAgent = request.getHeader("User-Agent");
		  boolean ie = userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("rv:11") > -1;
		  String fileName = null;
		   
		  if (ie) {
		   fileName = URLEncoder.encode(file.getName(), "utf-8");
		  } else {
		   fileName = new String(file.getName().getBytes("utf-8"),"iso-8859-1");
		  }
		  
		  response.setContentType("application/octet-stream");
		  response.setHeader("Content-Disposition","attachment;filename=\"" +fileName+"\";");
		  
		  FileInputStream fis=new FileInputStream(file);
		  BufferedInputStream bis=new BufferedInputStream(fis);
		  ServletOutputStream so=response.getOutputStream();
		  BufferedOutputStream bos=new BufferedOutputStream(so);
		  
		  byte[] data=new byte[2048];
		  int input=0;
		  while((input=bis.read(data))!=-1){
		   bos.write(data,0,input);
		   bos.flush();
		  }
		  
		  if(bos!=null) bos.close();
		  if(bis!=null) bis.close();
		  if(so!=null) so.close();
		  if(fis!=null) fis.close();
		 
		}
	
}
