package hanibal.ibs.controller;

import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import hanibal.ibs.dao.IbsAppDAO;

public class IbsAppController {
	Logger log = Logger.getLogger(this.getClass());
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

	@RequestMapping("/api/app")
	public String appMain() {
		return "/ibsAppViews/main.ibs";
	}
}
