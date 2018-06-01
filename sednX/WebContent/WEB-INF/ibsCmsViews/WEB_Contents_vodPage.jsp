<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsCmsJs/functionInc.js"></script>
<c:choose>
	<c:when test="${empty lists }">
		<div style="height: 100px;"><h1>데이터가 없습니다.</h1></div>
	</c:when>
	<c:otherwise>
		<c:forEach items="${lists}" var="list" varStatus="loop">
			<div class="img_box imgPopup" id="${list.idx}" style="background: url('${pageContext.request.contextPath}${list.main_thumbnail}') no-repeat center; background-size: cover;">
			</div>
		</c:forEach>
	</c:otherwise>
</c:choose>
<script>
	$('.imgPopup').click(function(){
		$('#vodViewModal').modal();
	});
</script>
                                  