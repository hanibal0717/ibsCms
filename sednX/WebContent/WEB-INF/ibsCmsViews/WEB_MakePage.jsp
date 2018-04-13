<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	<!--메뉴경로... -->
	<ol class="breadcrumb hidden-xs">
	    <li><a href="#">Home</a></li>
	    <li class="active">CATEGORY MANAGER</li>
	</ol>
	<!-- 대메뉴-->
	<h4 class="page-title">DASHBOARD</h4>
	<!-- Main Widgets -->
   	<div class="block-area">
   		<div class="row">
   			<div class="tile-dark col-md-3">
	   			<!-- TREE START-->
				<div id="menuTree" style="margin:10px;"></div>
				<!-- TREE END-->
			</div>
			<div class="col-md-9">
				<!--TITLE START-->
			<h3 class="block-title" id="navibar"></h3>
			<div style="float: right;">
				<input type="hidden" id="categoryIdx" value="1" />
				<input id="sort" type="hidden">
				<input id="treeIdx" type="hidden">
				<input type="text" class="main-search" id="mainSearch" style="border-bottom: 1px solid #FFFFFF;" placeholder="태그,제목,내용">
			</div>
			<!--TITLE END-->
			<!-- CONTENTS START -->
			<div id="listView" class="tile">list</div>
			<!-- CONTENTS END -->	
			</div>
	    </div>
   	</div>
</section>
<script>
var mkPage=(function(){
	var makeTree =function(){
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
	return {
		makeTree : makeTree
	};
}());
var arange=(function(){
	var naviBar=function(){
		$("#sort").val(arguments[0]);
		$("#treeIdx").val(arguments[1]);
		$("#navibar").html(arguments[2]);
	};
	return {
		naviBar : naviBar
	}
}());
</script>
<script>
	//loaded reset
	arange.naviBar('makePage', '', 'CATEGORY');
	mkPage.makeTree();
</script>
