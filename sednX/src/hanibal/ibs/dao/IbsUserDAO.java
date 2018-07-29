package hanibal.ibs.dao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import com.ibatis.sqlmap.client.SqlMapClient;

import hanibal.ibs.library.HanibalWebDev;
import hanibal.ibs.model.cms.BoardDTO;
import hanibal.ibs.model.webapi.LayoutDTO;
public class IbsUserDAO {
	Logger log = Logger.getLogger(this.getClass());
	public void setSqlMapper(SqlMapClient sqlMapper) {
	}
	public void setSqlFactory(SqlSessionFactory sqlFactory) {
	}
	private static SqlSessionTemplate sqlTemplate;	
	public void setSqlTemplate(SqlSessionTemplate sqlTemplate) {
		this.sqlTemplate = sqlTemplate;
	}
	SqlMapClientTemplate sqlMapTemplate;
	public void setSqlMapTemplate(SqlMapClientTemplate sqlMapTemplate) {
		this.sqlMapTemplate = sqlMapTemplate;
	}
	

	public int getBoardTotalRecordCount(String searchWord, String childIdx) {
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="";
		if(childIdx.length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray(childIdx);
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		if(searchWord== null||searchWord.length()==0) searchWord="";
		map.put("searchWord", searchWord);
		map.put("eachFlag",eachFlag);
		int totalCount=sqlTemplate.selectOne("getBoardTotalRecordCount",map);
		return totalCount;
		
	}
	public List<BoardDTO> boardList(String searchWord, String childIdx, int start, int end) {
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="";
		if(childIdx.length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray(childIdx);
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		map.put("searchWord",searchWord);
		map.put("start", start);
		map.put("end", end);
		map.put("eachFlag",eachFlag);
		List<BoardDTO> lists=sqlTemplate.selectList("BoardList", map);
		return lists;
	}
	public List<LayoutDTO> getLayoutList(int idx) {
		List<LayoutDTO> lists=sqlTemplate.selectList("getLayoutList",idx);
		return lists;
	}
	public List<BoardDTO> layoutList(String searchWord, String wl_categorys, String wl_attribute, String wl_sort, int start,int end) {
		Map<String,Object> map= new HashMap<String,Object>();
		String eachFlag="";
		if(wl_categorys.length()!=0) {
			int childIdxArr[]=HanibalWebDev.StringToIntArray(wl_categorys);
			eachFlag="Y";
			map.put("childIdxArr", childIdxArr);
		}
		map.put("searchWord",searchWord);
		map.put("start", start);
		map.put("end", end);
		map.put("eachFlag",eachFlag);
		map.put("wl_attribute", wl_attribute);
		map.put("wl_sort",wl_sort);
		List<BoardDTO> lists=sqlTemplate.selectList("userLayoutList", map);
		return lists;
	}

	
}
