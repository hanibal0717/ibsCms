<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<style>
	.text-center tr th, .text-center tr td, .text-center {text-align: center;}
	.orange {background-color: #f0ad4e;}
	.ygreen {background-color: #5cb85c;}
	.blue {background-color: #428bca;}
	.sky {background-color: #5bc0de;}
	.yellow {background-color: #c59b5c;}
	.pink {background-color: #ce6fb4;}
	.puple {background-color: #806fdc;}
	.green {background-color: #3f8441;}
	.checked_from .title { border-bottom: 1px solid rgba(255, 255, 255, 0.31); border-left: 1px solid rgba(255, 255, 255, 0.31); height: 30px; line-height: 27px;}
	.checked_from .title span {
		border-top: 1px solid rgba(255, 255, 255, 0.31); border-right: 1px solid rgba(255, 255, 255, 0.31); padding: 0px 20px 0 10px; display: inline-block;
	}
	.checked_from .info {
		padding: 10px;
	}
</style>
<style>
.jstree-rename-input {
	color: #26120C;
}
</style>
<!-- Content -->
<section id="content" class="container">
	<!-- Main Widgets -->
   	<div class="block-area">
   		<div class="row">
   			<div class="tile-dark col-md-3">
   				<div class="text-right" style="position:absolute;right:10px;top:10px;">
                    <img src="${pageContext.request.contextPath}/ibsImg/menu_add.png" id="createMenu" alt="메뉴" style="cursor:pointer;">
                </div>
	   			<!-- TREE START-->
				<div id="menuTree" style="margin:10px;"></div>
				<!-- TREE END-->
			</div>
			<div class="col-md-9">
			<!--TITLE START-->
				<div class="tile">
					<div class="tile-title tile-dark">
	                   <h5 class="pull-left">
	                       <i class="fa fa-bars m-r-10"></i><span id="navibar">메인 페이지</span>
	                   </h5>
	                   <div class="pull-right">
	                   		<a id="setting" style="cursor:pointer;"><span class="icon" >&#61886;</span> 설정</a>
	                   </div>	
	                 </div>
	                 <div id="pageView"></div>
	                 
                 </div>
                 
			<!--TITLE END-->
			
			<!-- CONTENTS END -->	
			</div>
	    </div>
   	</div>
</section>
<script>
var option='${hn:getBoardSelect()}';
$('#optionText').val(option);
var menuJs = (function() {
	var makeJsTree = function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/api/advenceTree/"
					+ $("#sort").val(),
			async : true,
			success : function(data) {
				$("#menuTree").empty();
				$("#menuTree").html(data);
			},
			error : exception.ajaxException
		});
	};
	var makeSelJstree = function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/api/checkJstree/"
					+ $("#sort").val(),
			async : true,
			success : function(data) {
				$("#scheduleInsertModel").empty();
				$("#scheduleInsertModel").html(data);
			},
			error : exception.ajaxException
		});
	};
	var editSelJstree = function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/api/checkJstreeEdit/"
					+ $("#sort").val()+"?groupArr="+$("#groupArr").val(),
			async : true,
			success : function(data) {
				$("#scheduleInsertModel").empty();
				$("#scheduleInsertModel").html(data);
			},
			error : exception.ajaxException
		});
	};
	var vodScheduleJstree = function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/api/vodSchedule/vod",
			async : true,
			success : function(data) {
				$("#video").empty();
				$("#video").html(data);
			},
			error : exception.ajaxException
		});
	};
	return {
		makeJsTree : makeJsTree,
		makeSelJstree : makeSelJstree,
		editSelJstree :editSelJstree,
		vodScheduleJstree :vodScheduleJstree
	};
}());
var arange=(function(){
	var naviBar=function(){
		$("#sort").val(arguments[0]);
		$("#treeIdx").val(arguments[1]);
		$("#navibar").html(arguments[2]);
	};
	var list=function(idx,property){
		contentsView(idx);
	};
	var contentsView=function(idx){
		$("#pageView").empty();
		$.ajax({
			url : "${pageContext.request.contextPath}/cms/list/"
				+ $("#sort").val() + "?childIdx="+idx,
			success : function(data){
				$('#pageView').html(data);
			},
			error : exception.ajaxException
		});
	};
	return {
		naviBar : naviBar,
		list : list,
		contentsView : contentsView
	}
}());
</script>
<script>
	//loaded reset
	menuJs.makeJsTree();
	console.log($("#categoryIdx").val()+"/"+$("#categoryName").val());
	$('#cmsPageTitle').html('라이브 관리');
	arange.list($("#categoryIdx").val());
	arange.naviBar('live', $("#categoryIdx").val(), $("#categoryName").val());
</script>
