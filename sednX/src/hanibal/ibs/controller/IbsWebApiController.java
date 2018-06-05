package hanibal.ibs.controller;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.ArrayUtils;
import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import hanibal.ibs.dao.IbsWebApiDAO;
import hanibal.ibs.library.HanibalWebDev;
import hanibal.ibs.model.cms.FileDTO;
import hanibal.ibs.model.cms.LiveDTO;
import hanibal.ibs.model.cms.PhotoDTO;
import hanibal.ibs.model.cms.ScheduleDTO;
import hanibal.ibs.model.cms.VodDTO;
import hanibal.ibs.model.webapi.AdvenceTree;
import hanibal.ibs.model.webapi.Carousel;
import hanibal.ibs.model.webapi.MainContents;
import hanibal.ibs.model.webapi.TreeMenu;
import hanibal.ibs.model.webapi.UploadFile;

@Controller
public class IbsWebApiController {
	Logger log = Logger.getLogger(this.getClass());
	ObjectMapper mapper = new ObjectMapper();
	IbsWebApiDAO webApiDao;
	String repositoryPath;
	String sednIp;
	String mediaIp;
	String dbProperties;
	
	public void setLog(Logger log) {
		this.log = log;
	}
	public void setWebApiDao(IbsWebApiDAO webApiDao) {
		this.webApiDao = webApiDao;
	}
	public void setRepositoryPath(String repositoryPath) {
		this.repositoryPath = repositoryPath;
	}
	
	public void setSednIp(String sednIp) {
		this.sednIp = sednIp;
	}
	public void setMediaIp(String mediaIp) {
		this.mediaIp = mediaIp;
	}
	
	public String getDbProperties() {
		return dbProperties;
	}
	public void setDbProperties(String dbProperties) {
		this.dbProperties = dbProperties;
	}
	@RequestMapping("/api/web/{order}")
	@ResponseBody
	public void apiWeb(
			@PathVariable String order,
			@RequestParam(required=false) String member_email,
			@RequestParam(required=false) String member_pass,
			ModelMap mav,
			HttpServletResponse res
			) throws JsonGenerationException, JsonMappingException, IOException{
		Map<String, Object> msg=new HashMap<String, Object>();
		res.setCharacterEncoding("utf8");
		if(order.equals("checkMemberEmail")) {
			int affectcount=webApiDao.checkEmail(member_email);
			if(affectcount>0) {
				msg.put("msg","EXIST" );
			}else {
				msg.put("msg","NOT_EXIST");
			}
			res.getWriter().print(mapper.writeValueAsString(msg));
		}else if(order.equals("checkMemberPass")) {
			int affectcount=webApiDao.checkPass(member_email,member_pass);
			if(affectcount>0) {
				msg.put("msg","EXIST" );
			}else {
				msg.put("msg","NOT_EXIST");
			}
			res.getWriter().print(mapper.writeValueAsString(msg));
		}
	}
	@RequestMapping(value="/SEQ/UPLOAD/{order}",method=RequestMethod.POST)
	@ResponseBody
	public void uploadfile(@PathVariable String order,@ModelAttribute UploadFile dto,HttpServletResponse res) throws IOException {
		Map<String, Object> msg=new HashMap<String, Object>();
		res.setCharacterEncoding("utf8");
		Date nowDate=new Date();
		String targetPath="";
		if(order.equals("PROFILE")) {
			targetPath=repositoryPath+order;
		}else if(order.equals("FILE")){
			SimpleDateFormat folderPath=new SimpleDateFormat("/yyyy/MM/dd/");
			targetPath=repositoryPath+order+folderPath.format(nowDate);
		}else if(order.equals("PHOTO")){
			SimpleDateFormat folderPath=new SimpleDateFormat("/yyyy/MM/dd/");
			targetPath=repositoryPath+order+folderPath.format(nowDate);
		}else if(order.equals("VOD")){
			SimpleDateFormat folderPath=new SimpleDateFormat("/yyyy/MM/dd/");
			targetPath=repositoryPath+order+folderPath.format(nowDate);
		}else if(order.equals("CAROUSEL")){
			targetPath=repositoryPath+order;
		}else if(order.equals("SCHIMG")) {
			targetPath=repositoryPath+order;
		}
		String fileExe=dto.getUploadFile().getOriginalFilename().substring(dto.getUploadFile().getOriginalFilename().lastIndexOf(".")+1,dto.getUploadFile().getOriginalFilename().length());
		SimpleDateFormat todayDate=new SimpleDateFormat("yyyyMMddHHmmss");
		String formatDate=todayDate.format(nowDate);
		String newFileName=formatDate+"."+fileExe.toLowerCase();
		File destFile = new File(targetPath+File.separator+newFileName);
		if(!destFile.exists()){
			destFile.mkdirs();
		}
		dto.getUploadFile().transferTo(destFile);
		msg.put("fileName",newFileName);
		res.getWriter().print(mapper.writeValueAsString(msg));
	}
	@RequestMapping("/api/web/mediaEncodingRate")
	@ResponseBody
	public void getEncodingRate(@RequestParam(required=false) String file,HttpServletResponse res) throws JsonGenerationException, JsonMappingException, IOException, InterruptedException {
		int totalRate=0;
		//최초 박스데이터 조회
		int recodCount=webApiDao.vodBoxExist(file);
		String fileName=file.substring(0,file.lastIndexOf("."));
		String datePath=HanibalWebDev.getDataPath(file);
		String main_thumbnail="";
		Map<String, Object> map=new HashMap<String, Object>();
		//인코딩 
		String encodingPath=repositoryPath+"VOD"+datePath;
		String thumbnailPath=repositoryPath+"THUMBNAIL"+datePath;
		File destFile = new File(thumbnailPath);
		String ext=file.substring(file.lastIndexOf(".")+1,file.length());
		if(!destFile.exists()){
			destFile.mkdirs();
		}
		if(recodCount==0) {
			webApiDao.vodBoxInsert(file);
			if(ext.equals("mp4")) {
				totalRate=100;
			}else {
				HanibalWebDev.mediaEncoding(repositoryPath+"SH/ffmpeg_transcode.sh",encodingPath+file,encodingPath+fileName+".mp4",encodingPath+fileName+"_log.log" ,encodingPath+fileName+"_process.log");
				Thread.sleep(2000);
				HanibalWebDev.getRateProcess(repositoryPath+"SH/ffmpeg_progress.sh",encodingPath+file,encodingPath+fileName+"_process.log",encodingPath+fileName+"_rate.log");
				Thread.sleep(1000);
			}
		}else {
			totalRate=webApiDao.getEncodingRate(encodingPath+fileName+"_rate.log");
		}
		if(totalRate==100) {
			String runtime=HanibalWebDev.getMediaRuntime(repositoryPath+"SH/get_duration.sh",encodingPath+file);
			String[] hhmmss=HanibalWebDev.getSliceTimeArr(runtime);
			
			for(int i=0;i<hhmmss.length;i++) {
				HanibalWebDev.getThumbnail(repositoryPath+"SH/get_thumbnail.sh",encodingPath+fileName+".mp4",hhmmss[i],thumbnailPath+fileName+"_"+i+".jpg");
				if(i==0) {
					main_thumbnail=fileName+"_"+i+".jpg";
				}
			}
			String file_size=HanibalWebDev.getFileSize(encodingPath+file);
			webApiDao.updateRate(file,fileName+".mp4",100);
			if(!ext.equals("mp4")) {
				HanibalWebDev.fileDelete(repositoryPath,file, "VOD/"+datePath);
			}
			map.put("url","http://"+mediaIp+"/VOD"+datePath+fileName+".mp4"+"/index.m3u8");
			map.put("vod_play_time", runtime);
			map.put("main_thumbnail",main_thumbnail);
			map.put("main_thumbnail_url",thumbnailPath+main_thumbnail);
			map.put("file_size",file_size);
			map.put("datePath",datePath);
			map.put("file",fileName+".mp4");
		}else {
			map.put("file",file);
		}
		//rate 읽어오기 
		map.put("rate",totalRate);
		
		res.getWriter().print(mapper.writeValueAsString(map));
	}
	
	@RequestMapping("/api/web/emailConfirm")
	public String emailConfirm(@RequestParam String key) {
		String returnUrl="";
		int count=webApiDao.emailConfirm(key);
		if(count>0) {
			HashMap<String,Object> hashmap=webApiDao.getIdxByKey(key);
			//update member_code_yn && image update
			String confirmImage=HanibalWebDev.fileRenameTo(repositoryPath,String.valueOf(hashmap.get("member_profile")),repositoryPath,String.valueOf(hashmap.get("member_email")),"PROFILE/");
			webApiDao.confirmUpdate((int)hashmap.get("idx"),confirmImage);
			//delete noConfirm
			List<HashMap<String,String>> deleteProfileList=webApiDao.deleteProfileList(String.valueOf(hashmap.get("member_email")));
			if(deleteProfileList.size()!=0) {
				for(int i=0;i<deleteProfileList.size();i++) {
					HanibalWebDev.fileDelete(repositoryPath,deleteProfileList.get(i).get("member_profile"),"PROFILE/");
					webApiDao.deleteProfile(deleteProfileList.get(i).get("member_profile"));
				}
			}
			returnUrl="/ibsCmsViews/emailConfirm.inc";
		}else {
			returnUrl="redirect:/error/404";
		}
		return returnUrl;
	}
	@RequestMapping("/api/web/profileUpdate")
	@ResponseBody
	public void profileUpdate(HttpSession session,@RequestParam(required=false) String member_email,@RequestParam(required=false) String member_idx,@RequestParam(required=false) String member_profile,HttpServletResponse res) throws JsonGenerationException, JsonMappingException, IOException {
		HanibalWebDev.fileDelete(repositoryPath,member_email, "PROFILE/");
		String confirmImage=HanibalWebDev.fileRenameTo(repositoryPath,member_profile,repositoryPath,member_email,"PROFILE/");
		webApiDao.confirmUpdate(Integer.parseInt(member_idx),confirmImage);
		session.setAttribute("member_profile",confirmImage);
		session.setMaxInactiveInterval(60*60*60);
		Map<String, Object> msg=new HashMap<String, Object>();
		msg.put("fileName",confirmImage);
		res.setCharacterEncoding("utf8");
		res.getWriter().print(mapper.writeValueAsString(msg));
	}
	@RequestMapping("/api/seqKeyList")
	public void seqKeyList(HttpServletResponse res) throws JsonGenerationException, JsonMappingException, IOException {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("dbProperties",dbProperties);
		map.put("repositoryPath",repositoryPath);
		map.put("mediaIp",mediaIp);
		res.getWriter().print(mapper.writeValueAsString(map));
	}
	@RequestMapping("/api/jstree/{order}")
	public String jstree(@PathVariable String order,
			HttpServletRequest req,
			Model model) throws JsonGenerationException, JsonMappingException, IOException {
		String treeMenu="";
		List<TreeMenu> lists=null;
		lists=webApiDao.getMenuTree(order);
		Cookie[] cookies = req.getCookies();
		
		String selected_node_id = "1";
		
		
		if(cookies!=null){
			for(int i=0; i<cookies.length; i++){
				if(cookies[i].getName().equals("selected_node")){
					selected_node_id = cookies[i].getValue();
    			}
			}
		}
		lists.get(0).setParent("#");
		for(int i=0;i<lists.size();i++) {
			treeMenu+="{\"id\":\""+lists.get(i).getId()+"\",\"parent\":\""+lists.get(i).getParent()+"\",\"text\":\""+lists.get(i).getText()+" ["+lists.get(i).getNum()+"]\","
					+ "\"name\":\""+lists.get(i).getName()+"\",\"num\":\""+lists.get(i).getNum()+"\""
					+ ",\"state\":{\"opened\":true";
					if(lists.get(i).getId().equals(selected_node_id)) {
					treeMenu+=",\"selected\":true";	
					}
					treeMenu+="}},";
		}
		model.addAttribute("treeMenu", treeMenu);
		model.addAttribute("sort", order);
		return "/ibsInclude/jsTree.inc";
	}
	@RequestMapping("/api/advenceTree/{order}")
	public String advenceTree(@PathVariable String order,Model model,HttpServletRequest req) throws Exception {
		String selected_node_id = "1";
		
		String treeMenu="";
		List<AdvenceTree> lists=webApiDao.getAdvenceTree(order);
		if(order.equals("live")) {
			selected_node_id=lists.get(1).getId();
		}else if(order.equals("board")){
			selected_node_id="1";
		}else {
			selected_node_id=HanibalWebDev.getDefaultContentsIdx();
		}
		log.info("-------"+order+"--------->"+selected_node_id);
		lists.get(0).setParent("#");
		for(int i=0;i<lists.size();i++) {
			treeMenu+="{\"id\":\""+lists.get(i).getId()+"\",\"parent\":\""+lists.get(i).getParent()+"\",\"text\":\""+lists.get(i).getText();
			if(lists.get(i).getProperty().equals("1")) {
				treeMenu+=" ["+lists.get(i).getNum()+"]";
			}
			treeMenu+="\",";
			treeMenu+= "\"name\":\""+lists.get(i).getName()+"\",\"num\":\""+lists.get(i).getNum()+"\",\"property\":\""+lists.get(i).getProperty()+"\",";
			if(i==0) {
				treeMenu+="\"icon\":\""+req.getContextPath()+"/ibsImg/root.png\"";
			}else if(lists.get(i).getProperty().equals("0")) {
				treeMenu+="\"icon\":\""+req.getContextPath()+"/ibsImg/menu.png\"";
			}else{
				treeMenu+="\"icon\":\""+req.getContextPath()+"/ibsImg/list.png\"";
			}		
			treeMenu+= ",\"state\":{\"opened\":true";
			if(lists.get(i).getId().equals(selected_node_id)) {
					treeMenu+=",\"selected\":true";	
			}
			treeMenu+="}},";
		}
		model.addAttribute("treeMenu", treeMenu);
		model.addAttribute("sort", order);
		return "/ibsInclude/advenceTree.inc";
	}
	@RequestMapping("/api/selJstree/{order}")
	public String selJstree(@PathVariable String order,
			HttpServletRequest req,
			Model model) throws JsonGenerationException, JsonMappingException, IOException {
		String treeMenu="";
		List<TreeMenu> lists=null;
		lists=webApiDao.getMenuTree(order);
		Cookie[] cookies = req.getCookies();
		String selected_node_id = "1";
		if(cookies!=null){
			for(int i=0; i<cookies.length; i++){
				if(cookies[i].getName().equals("selected_node")){
					selected_node_id = cookies[i].getValue();
    			}
			}
		}
		lists.get(0).setParent("#");
		for(int i=0;i<lists.size();i++) {
			treeMenu+="{\"id\":\""+lists.get(i).getId()+"\",\"parent\":\""+lists.get(i).getParent()+"\",\"text\":\""+lists.get(i).getText()+" ["+lists.get(i).getNum()+"]\","
					+ "\"name\":\""+lists.get(i).getName()+"\",\"num\":\""+lists.get(i).getNum()+"\""
					+ ",\"state\":{\"opened\":false";
					if(lists.get(i).getId().equals(selected_node_id)) {
					treeMenu+=",\"selected\":true";	
					}
					treeMenu+="}},";
		}
		model.addAttribute("treeMenu", treeMenu);
		model.addAttribute("sort", order);
		return "/ibsInclude/selJstree.inc";
	}
	@RequestMapping("/api/checkJstree/{order}")
	public String checklJstree(@PathVariable String order,
			HttpServletRequest req,
			Model model) throws JsonGenerationException, JsonMappingException, IOException {
		String treeMenu="";
		List<TreeMenu> lists=null;
		lists=webApiDao.getMenuTree(order);
		Cookie[] cookies = req.getCookies();
		String selected_node_id = "1";
		if(cookies!=null){
			for(int i=0; i<cookies.length; i++){
				if(cookies[i].getName().equals("selected_node")){
					selected_node_id = cookies[i].getValue();
    			}
			}
		}
		lists.get(0).setParent("#");
		for(int i=0;i<lists.size();i++) {
			treeMenu+="{\"id\":\""+lists.get(i).getId()+"\",\"parent\":\""+lists.get(i).getParent()+"\",\"text\":\""+lists.get(i).getText()+" ["+lists.get(i).getNum()+"]\","
					+ "\"name\":\""+lists.get(i).getName()+"\",\"num\":\""+lists.get(i).getNum()+"\""
					+ ",\"state\":{\"opened\":false";
					if(lists.get(i).getId().equals(selected_node_id)) {
					treeMenu+=",\"selected\":false";	
					}
					treeMenu+="}},";
		}
		model.addAttribute("treeMenu", treeMenu);
		model.addAttribute("sort", order);
		return "/ibsInclude/checkJstree.inc";
	}
	@RequestMapping("/api/checkJstreeEdit/{order}")
	public String checkJstreeEdit(@PathVariable String order,@RequestParam String groupArr,
			HttpServletRequest req,
			Model model) throws JsonGenerationException, JsonMappingException, IOException {
		int [] compareArr=HanibalWebDev.StringToIntArray(groupArr);
		String treeMenu="";
		if(order.equals("stb-schedule")) {
			boolean interFlag=false;
			for(int i=0;i<compareArr.length;i++) {
				if(compareArr[i]==0) interFlag=true; 
			}
			treeMenu+="{\"id\":\"0\",\"parent\":\"#\",\"text\":\"인터넷 방송\","
					+ "\"name\":\"인터넷방송\",\"num\":\"0\""
					+ ",\"state\":{\"opened\":false";
					treeMenu+=",\"selected\":"+interFlag;	
					treeMenu+="}},";
		}
		List<TreeMenu> lists=null;
		lists=webApiDao.getMenuTree(order);
		
		
		lists.get(0).setParent("#");
		for(int i=0;i<lists.size();i++) {
			boolean flag=false;
			if ( ArrayUtils.contains(compareArr, Integer.parseInt(lists.get(i).getId()) ) ) {
			   flag=true;
			}
			treeMenu+="{\"id\":\""+lists.get(i).getId()+"\",\"parent\":\""+lists.get(i).getParent()+"\",\"text\":\""+lists.get(i).getText()+" ["+lists.get(i).getNum()+"]\","
					+ "\"name\":\""+lists.get(i).getName()+"\",\"num\":\""+lists.get(i).getNum()+"\""
					+ ",\"state\":{\"opened\":"+flag;
					treeMenu+=",\"selected\":"+flag;	
					treeMenu+="}},";
		}
		model.addAttribute("treeMenu", treeMenu);
		model.addAttribute("sort", order);
		return "/ibsInclude/checkJstree.inc";
	}
	@RequestMapping("/api/vodSchedule/{order}")
	public String vodSchedule(@PathVariable String order,
			HttpServletRequest req,
			Model model) throws Exception {
		String selected_node_id = "1";
		
		String treeMenu="";
		List<AdvenceTree> lists=webApiDao.getAdvenceTree(order);
		if(order.equals("live")) {
			selected_node_id=lists.get(1).getId();
		}else if(order.equals("board")){
			selected_node_id="1";
		}else {
			selected_node_id=HanibalWebDev.getDefaultContentsIdx();
		}
		log.info("-------"+order+"--------->"+selected_node_id);
		lists.get(0).setParent("#");
		for(int i=0;i<lists.size();i++) {
			treeMenu+="{\"id\":\""+lists.get(i).getId()+"\",\"parent\":\""+lists.get(i).getParent()+"\",\"text\":\""+lists.get(i).getText();
			if(lists.get(i).getProperty().equals("1")) {
				treeMenu+=" ["+lists.get(i).getNum()+"]";
			}
			treeMenu+="\",";
			treeMenu+= "\"name\":\""+lists.get(i).getName()+"\",\"num\":\""+lists.get(i).getNum()+"\",\"property\":\""+lists.get(i).getProperty()+"\",";
			if(i==0) {
				treeMenu+="\"icon\":\""+req.getContextPath()+"/ibsImg/root.png\"";
			}else if(lists.get(i).getProperty().equals("0")) {
				treeMenu+="\"icon\":\""+req.getContextPath()+"/ibsImg/menu.png\"";
			}else{
				treeMenu+="\"icon\":\""+req.getContextPath()+"/ibsImg/list.png\"";
			}		
			treeMenu+= ",\"state\":{\"opened\":true";
			if(lists.get(i).getId().equals(selected_node_id)) {
					treeMenu+=",\"selected\":true";	
			}
			treeMenu+="}},";
		}
		model.addAttribute("treeMenu", treeMenu);
		model.addAttribute("sort", order);
		return "/ibsInclude/vodSchedulAdvence.inc";
	}
	@RequestMapping("/api/jstree/addGroup")
	public void addGroup(@RequestParam Map<String, Object> commandMap, ModelMap mav,HttpServletResponse res) throws JsonGenerationException, JsonMappingException, IOException {
		if(commandMap.get("property")==null) {
			commandMap.put("property",0);
		}
		String newNodeId=webApiDao.createGroup(commandMap);
		mav.put("newNodeId",newNodeId);
    	mav.put("msg", "success");
    	res.getWriter().print(mapper.writeValueAsString(mav));
	}
	@RequestMapping("/api/jstree/renameGroup")
	public void renameGroup(@RequestParam Map<String, Object> commandMap, ModelMap mav,HttpServletResponse res) throws JsonGenerationException, JsonMappingException, IOException {
		int affectcount=webApiDao.renameGroup(commandMap);
		if(affectcount!=0) {
			mav.put("msg", "success");
		}
    	res.getWriter().print(mapper.writeValueAsString(mav));
	}
	@RequestMapping("/api/jstree/deleteGroup")
	public void deleteGroup(@RequestParam Map<String, Object> commandMap, ModelMap mav,HttpServletResponse res) throws JsonGenerationException, JsonMappingException, IOException {
		int affectcount=webApiDao.deleteGroup(commandMap);
		if(affectcount!=0) {
			mav.put("msg", "success");
		}
    	res.getWriter().print(mapper.writeValueAsString(mav));
	}
	@RequestMapping("/api/jstree/moveCategory")
	public void moveCategory(@RequestParam Map<String, Object> commandMap, ModelMap mav,HttpServletResponse res) throws JsonGenerationException, JsonMappingException, IOException {
		int affectcount=webApiDao.moveCategory(commandMap);
		if(affectcount!=0) {
			mav.put("msg","success");
		}
		res.getWriter().print(mapper.writeValueAsString(mav));
	}
	@RequestMapping("/api/smList/{contents}")
	public void smList(@PathVariable String contents,@RequestParam Map<String, Object> commandMap,ModelMap mav,HttpServletResponse res) throws JsonGenerationException, JsonMappingException, IOException {
		mav.put("contents",contents);
		res.setCharacterEncoding("utf8");
		if(contents.equals("live")) {
			List<LiveDTO> lists=webApiDao.getLiveSmList(commandMap);
			mav.put("lists",lists);
		}
		if(contents.equals("file")) {
			List<FileDTO> lists=webApiDao.getFileSmList(commandMap);
			mav.put("lists",lists);
		}
		if(contents.equals("photo")) {
			List<PhotoDTO> lists=webApiDao.getPhotoSmList(commandMap);
			for(int i=0;i<lists.size();i++) {
				lists.get(i).setPhoto_path("/REPOSITORY/"+contents.toUpperCase()+HanibalWebDev.getDataPath(lists.get(i).getPhoto_path())+lists.get(i).getPhoto_path());
			}
			mav.put("lists",lists);
		}
		if(contents.equals("vod")) {
			List<VodDTO> lists=webApiDao.getVodSmList(commandMap);
			for(int i=0;i<lists.size();i++) {
				lists.get(i).setMain_thumbnail("/REPOSITORY/THUMBNAIL"+HanibalWebDev.getDataPath(lists.get(i).getMain_thumbnail())+lists.get(i).getMain_thumbnail());
			}
			for(int i=0;i<lists.size();i++) {
				lists.get(i).setVod_path("http://"+mediaIp+"/"+contents.toUpperCase()+HanibalWebDev.getDataPath(lists.get(i).getVod_path())+lists.get(i).getVod_path()+"/index.m3u8");
			}
			mav.put("lists",lists);
		}
		if(contents.equals("vodIdxArr")) {
			List<VodDTO> lists=webApiDao.getVodByIdxArrList(commandMap);
			for(int i=0;i<lists.size();i++) {
				lists.get(i).setMain_thumbnail("/REPOSITORY/THUMBNAIL"+HanibalWebDev.getDataPath(lists.get(i).getMain_thumbnail())+lists.get(i).getMain_thumbnail());
			}
			for(int i=0;i<lists.size();i++) {
				lists.get(i).setVod_path("http://"+mediaIp+"/"+contents.toUpperCase()+HanibalWebDev.getDataPath(lists.get(i).getVod_path())+lists.get(i).getVod_path()+"/index.m3u8");
			}
			mav.put("lists",lists);
		}
		res.getWriter().print(mapper.writeValueAsString(mav));
	}
	@RequestMapping("/api/public/carousel")
	public void carouselList(ModelMap mav,HttpServletResponse res) throws IOException{
		List<Carousel> lists=webApiDao.getCatouselList();
		mav.put("lists",lists);
		res.getWriter().print(mapper.writeValueAsString(mav));
	}
	@RequestMapping("/api/public/mainContents")
	public void mainContents(ModelMap mav,HttpServletResponse res) throws IOException{
		res.setCharacterEncoding("utf8");
		List<MainContents> lists=webApiDao.getMainContents();
		mav.put("lists",lists);
		res.getWriter().print(mapper.writeValueAsString(mav));
	}
	@RequestMapping("/api/web/sendCommandToSTB")
	public  void voidsendCommantToSTB(HttpServletResponse res,@RequestParam Map<String, Object> commandMap) throws JsonGenerationException, JsonMappingException, IOException, InterruptedException {
		String command = (String)commandMap.get("command");
		String stbMAC = (String)commandMap.get("stbList");
		String[] macArr=stbMAC.split(",");
		for(int i=0;i<macArr.length;i++) {
			macArr[i] = macArr[i].replaceAll(":", "");
			HanibalWebDev.sendCommandToSTB(command,macArr[i]);
			Thread.sleep(1000);
		}
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("result", "success");
		res.getWriter().print(mapper.writeValueAsString(map));
	}
	@RequestMapping("/api/web/stb-schedule/update/{idx}")
	public void schduleElem(@PathVariable String idx,Model model,HttpServletResponse res) throws JsonGenerationException, JsonMappingException, IOException {
		//기본정보
		HashMap<String,Object>  basicInfo=webApiDao.getScheduleBasic(idx);
		
		//group 가져오기
		List<Integer> lists=webApiDao.getScheduleGroup(idx);
		int[] groupArr=new int[lists.size()];
		for(int i=0;i<groupArr.length;i++) {
			groupArr[i]=lists.get(i).intValue();
		}
		basicInfo.put("groupArr",groupArr);
		//vod일 경우 리스트를 맵에 따로 담는다.
		List<Integer> vodlists=webApiDao.getScheduleVod(idx);
		int[] vodArr=new int[vodlists.size()];
		for(int i=0;i<vodArr.length;i++) {
			vodArr[i]=vodlists.get(i).intValue();
		}
		basicInfo.put("vodArr",vodArr);
		res.setCharacterEncoding("utf8");
		res.getWriter().print(mapper.writeValueAsString(basicInfo));
		
	}
	@RequestMapping("/api/web/scheduleJson")
	@ResponseBody
	public String scheduleJson(@RequestParam(required=false) String childIdx) throws JsonGenerationException, JsonMappingException, IOException {
		List<ScheduleDTO> eventLists=webApiDao.eventList(childIdx);
		String comma=",";
		String events="";
		for(int i=0;i<eventLists.size();i++) {
			if(i==eventLists.size()-1) comma="";
			events+="{title:'"+eventLists.get(i).getName()+"',"
					+ "url:'javascript:calClick.viewEvent("+eventLists.get(i).getIdx()+");',"
					+ "start:'"+eventLists.get(i).getStart()+"',"
					+ "end:'"+eventLists.get(i).getEnd()+"',"
					+ "allDay:false,"
					+ "idx :'"+eventLists.get(i).getIdx()+"' }"+comma+"";
		}
		return events;
	}
	@RequestMapping("/api/categoryNames/{sort}")
	public void categoryNames(@PathVariable String sort,@RequestParam(required=false) Map<String, Object> commandMap,HttpServletResponse res) throws JsonGenerationException, JsonMappingException, IOException{
		String table=HanibalWebDev.targetTable(sort);
		commandMap.put("table",table);
		String eachFlag="";
		if(String.valueOf(commandMap.get("idxArr")).length()!=0) {
			eachFlag="Y";
		}
		commandMap.put("eachFlag",eachFlag);
		commandMap.put("idxArr", HanibalWebDev.StringToIntArray(String.valueOf(commandMap.get("idxArr"))));
		List<HashMap<String,Object>> categoryList=webApiDao.getCategoryNames(commandMap);
		Map<String,Object> mainData =new HashMap<String,Object>();
		mainData.put("categoryList",categoryList);
		res.setCharacterEncoding("utf8");
		res.getWriter().print(mapper.writeValueAsString(mainData));
		
	}
	
	@RequestMapping("/api/imageNames")
	public void imageNames(@RequestParam(required=false) Map<String, Object> commandMap,HttpServletResponse res) throws JsonGenerationException, JsonMappingException, IOException {
		String eachFlag="";
		if(String.valueOf(commandMap.get("idxArr")).length()!=0) {
			eachFlag="Y";
			commandMap.put("eachFlag",eachFlag);
			commandMap.put("imgArr", HanibalWebDev.StringToIntArray(String.valueOf(commandMap.get("imgArr"))));
			List<HashMap<String,Object>> imgList=webApiDao.getImgNames(commandMap);
			Map<String,Object> mainData =new HashMap<String,Object>();
			mainData.put("imgList",imgList);
			res.setCharacterEncoding("utf8");
			res.getWriter().print(mapper.writeValueAsString(mainData));
		}
	}
	
 }


