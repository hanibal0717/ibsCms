<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<div class="form_div setUI" style="max-height: 820px; overflow-y: auto; width:100%;">

</div>
<c:set var="totalCount" value="${fn:length(lists)-1}" /> 
<div class="tile col-md-12 p-5">
   <div class="col-md-6">
       <button class="btn btn-alt col-md-2 m-b-5" id="settingAdd">추가</button>
   </div>
   <div class="col-md-6">
       <button class="btn btn-alt col-md-2 m-b-5 pull-right">적용</button>
   </div>
</div>
<c:choose>
	<c:when test="${empty lists}">
		<script>
		$.ajax({
			url : "${pageContext.request.contextPath}/cms/makepage/addForm",
			success : function(data){
				$('.setUI').html(data);
			},
			error : exception.ajaxException
		});
		</script>
	</c:when>
	<c:otherwise>
	<c:set var="totalCount" value="${fn:length(lists)-1}" /> 
		<c:forEach items="${lists}" var="list" varStatus="loop">
  				<script>
  				$.ajax({
  					url : "${pageContext.request.contextPath}/cms/makepage/addForm",
  					success : function(data){
  						$('.setUI').append(data);
  					},
  					error : exception.ajaxException
  				});
  				</script>
		</c:forEach>
	</c:otherwise>
</c:choose>

  
