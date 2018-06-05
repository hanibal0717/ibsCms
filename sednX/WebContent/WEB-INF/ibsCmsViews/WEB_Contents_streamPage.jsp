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
			<div class="img_box imgPopup" id="${list.idx}" style="background: url('${pageContext.request.contextPath}/img/live.jpg') no-repeat center; background-size: cover;">
				<input class="pull-left m-l-5 streamCheck" type="radio"  name="redioVal" value="${list.idx}" title="${list.live_path}"/>
				<input class="pull-left m-l-5 selectCheck" type="checkBox"  name="redioVal" value="${list.idx}" title="${list.live_path}" style="display:none;"/>
				 <p class="text-center" style="margin-top: 110px; font-size:12px;">${list.live_title}<br/><span style="font-size:11px;">[${list.live_path}]</span></p>
			</div>
		</c:forEach>
	</c:otherwise>
</c:choose>
<script>
if($('#repoOrder').val()==undefined){
	$('.streamCheck').css('display','none');
	$('.imgPopup').click(function(){
		$('#vodViewModal').modal();
	});
}else{
	$('.streamCheck').click(function(){
		$('#live_ch_idx').val($(this).val());
		$('#live_stream_url').val($(this).attr('title'));
		$('#source_type').val('LIVE');
	});
}
</script>

                                  