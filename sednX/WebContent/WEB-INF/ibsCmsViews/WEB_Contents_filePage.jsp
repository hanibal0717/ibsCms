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
			<div class="img_box imgPopup" style="background: url(${pageContext.request.contextPath}/ibsImg/doc_icon2_${list.resolution}.png) no-repeat 50% 40%; cursor: pointer;">
                 <input class="pull-left m-l-5 fileCheck" type="checkbox" value="${list.idx}"/>
                 <p class="text-center" style="margin-top: 110px; font-size:12px;">${list.file_title}<br/>[${list.file_path}]</p>
             </div>
		</c:forEach>
	</c:otherwise>
</c:choose>
<script>
if($('#repoOrder').val()==undefined){
	$('.fileCheck').css('display','none');
	$('.imgPopup').click(function(){
		$('#vodViewModal').modal();
	});
}else{
	var arr=[];
	$('.vodCheck').click(function(){
		if ($(this).is(":checked") == true) {
			arr.push($(this).val());
		} else {
			arr.splice($.inArray($(this).val(), arr), 1);
		}
		$('#tempVodList').val(arr);
	});
}
</script>
<input type="hidden" id="tempVodList" />
                                  