<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsCmsJs/functionInc.js"></script>
 <div class="photo-gallery clearfix">
     <div class="photo photoForm">
         <div class="form_div col-md-12">
              <c:choose>
				<c:when test="${empty lists }">
					<div style="height: 100px;">데이타가 없습니다.</div>
				</c:when>
				<c:otherwise>
					<c:forEach items="${lists}" var="list" varStatus="loop">
			             <div class="img_box vodChange" style="background: url(${list.vod_repo}) no-repeat center; background-size: cover;">
			                 <label class="checkbox-inline m-10 pull-left checkMode" style="display:none;">
			                     <span class="checkableBox">
			                         <input type="checkbox" id="inlineCheckbox1"> 
			                     </span>
			                 </label>
			             </div>
             		</c:forEach>
				</c:otherwise>
			</c:choose>
         </div>
     </div>
 </div>
 <div class="tile col-md-12 p-5">
     <div class="col-md-6">
     	 <button class="btn btn-alt col-md-2 m-b-5 defaultBtns" id="changeMode">편집</button>
         <button class="btn btn-alt col-md-2 m-r-10 m-b-5 editBtns" style="display:none;">전체선택</button>
         <button class="btn btn-alt col-md-2 m-r-10 m-b-5 editBtns" style="display:none;">삭제</button>
         <button class="btn btn-alt col-md-2 m-b-5 editBtns" style="display:none;">이동</button>                                        
     </div>
     <div class="col-md-6">
     	<button class="btn btn-alt col-md-2 m-b-5 pull-right defaultBtns">추가</button>
        <button class="btn btn-alt col-md-2 m-b-5 pull-right editBtns" style="display:none;" id="editComplete">완료</button>
     </div>
 </div>
 <script>
 	$('#changeMode').click(function(){
 		arange.changeMode();
 	});
 	$('#editComplete').click(function(){
 		arange.returnMode();
 	});
 </script>