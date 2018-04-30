package hanibal.ibs.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.ibatis.sqlmap.client.SqlMapClient;

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
	public int checkMemberInfo(String account, String password) {
		Map<String, Object> memberInfoMap = new HashMap<String, Object>();
		memberInfoMap.put("account", account);
		memberInfoMap.put("password", password);
		int returnFlag = sqlTemplate.selectOne("checkMemberInfo", memberInfoMap);
		return returnFlag;
	}
	public String getMemberToken(String account) {
		String returnText = sqlTemplate.selectOne("getMemberToken", account);
		return returnText;
	}
}