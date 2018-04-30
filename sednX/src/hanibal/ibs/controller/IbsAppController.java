package hanibal.ibs.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import hanibal.ibs.dao.IbsAppDAO;
import hanibal.ibs.model.webapi.MemberDTO;

@Controller
public class IbsAppController {
	Logger log = Logger.getLogger(this.getClass());
	ObjectMapper mapper = new ObjectMapper();
	IbsAppDAO ibsAppDAO;
	
	public Logger getLog() {
		return log;
	}

	public void setLog(Logger log) {
		this.log = log;
	}

	public IbsAppDAO getIbsAppDAO() {
		return ibsAppDAO;
	}

	public void setIbsAppDAO(IbsAppDAO ibsAppDAO) {
		this.ibsAppDAO = ibsAppDAO;
	}
	
	@RequestMapping("/api/app/Login")
	public void appLogin(@ModelAttribute MemberDTO dto, HttpServletResponse res) {
		String account = dto.getAuth_id();
		String password = dto.getAuth_pass();
		
		Map<String, Object> returnJsonMap = new HashMap<String, Object>();
		Map<String, Object> retMap = new HashMap<String, Object>();
		
		int checkFlag = ibsAppDAO.checkMemberInfo(account, password);
		if(checkFlag == 1) {
			String token = ibsAppDAO.getMemberToken(account);
			log.info(token);
			retMap.put("auth_token", token);
			
			returnJsonMap.put("code", "200");
			returnJsonMap.put("msg", "");
			returnJsonMap.put("type", "0");
			returnJsonMap.put("ret", retMap);
			
			try {
				res.setCharacterEncoding("euckr");
		        res.getWriter().print(mapper.writeValueAsString(returnJsonMap));
		    } catch (IOException e) {
		        e.printStackTrace();
		    }   
		}
		else {
			retMap.put("auth_token", "");
			
			returnJsonMap.put("code", "400");
			returnJsonMap.put("msg", "");
			returnJsonMap.put("type", "0");
			returnJsonMap.put("ret", retMap);
			
			try {
				res.setCharacterEncoding("euckr");
		        res.getWriter().print(mapper.writeValueAsString(returnJsonMap));
		    } catch (IOException e) {
		        e.printStackTrace();
		    }   
		}
	}
	
	@RequestMapping("/api/app/Vod/BannerList")
	public void appVodBannerList(@RequestParam String token, HttpServletResponse res) {
		Map<String, Object> returnJsonMap = new HashMap<String, Object>();
		Map<String, Object> retMap = new HashMap<String, Object>();
	}
}