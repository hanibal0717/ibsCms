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
	<!-- Main Widgets -->
   	<div class="block-area">
   		<div class="row">
   			<div class="tile-dark col-md-3">
   				<div class="text-right" style="position:absolute;right:10px;top:10px;">
                    <img src="${pageContext.request.contextPath}/ibsImg/menu_add.png" id="createMenu" alt="메뉴" style="cursor:pointer;">
                    <img src="${pageContext.request.contextPath}/ibsImg/list_add.png" id="createBoard" alt="리스트" style="cursor:pointer;">
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
	                   		<input type="text" class="main-search" id="search" style="border-bottom: 1px solid #fff; width: 100%;display:none;" placeholder="검색어를 입력하세요.">
	                   		<a id="setting" style="cursor:pointer;"><span class="icon" >&#61886;</span> 설정</a>
	                   		<a id="preview" style="display:none;cursor:pointer;"><span class="icon m-r-10">&#61723;</span>미리보기</a>
	                   </div>	
	                 </div>
	                 <div id="pageView" style="width:100%;">
						
	                 </div>
                 </div>
			<!--TITLE END-->
			<!-- CONTENTS START -->
			<input type="hidden" id="categoryIdx" value="1" />
			<input id="sort" type="hidden">
			<input id="treeIdx" type="hidden">
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
	var list=function(idx,property){
		if(property=="1"){
			contentsView(idx);
		}else{
			makePage(idx);
		}
	};
	var contentsView=function(idx){
		$("#setting").css('display','none');
		$("#search").css('display','block');
		$('#preview').css('display','none');
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
	var makePage=function(idx){
		$("#setting").css('display','block');
		$("#search").css('display','none');
		$('#preview').css('display','none');
		movePreview($('#categoryIdx').val());
	};
	var moveSetting=function(idx){
		$("#setting").css('display','none');
		$('#preview').css('display','block');
		$("#pageView").empty();
		$.ajax({
			url : "${pageContext.request.contextPath}/cms/makepage/setting/"+idx,
			success : function(data){
				$('#pageView').html(data);
			},
			error : exception.ajaxException
		});
	};
	var movePreview=function(idx){
		$('#preview').css('display','none');
		$('#setting').css('display','block');
		$("#pageView").empty();
		$("#pageView").html("<h1> 미리보기 :"+idx+"</h1>");
	};
	var changeMode=function(){
		$('.editBtns').css('display','block');
		$('.defualtBtns').css('display','none');
		$('.checkMode').css('display','block');
	};
	var returnMode=function(){
		$('.editBtns').css('display','none');
		$('.defualtBtns').css('display','block');
		$('.checkMode').css('display','none');
	};
	return {
		naviBar : naviBar,
		list : list,
		makePage : makePage,
		moveSetting : moveSetting,
		movePreview : movePreview,
		changeMode : changeMode,
		returnMode : returnMode
	}
}());
</script>
<script>
	//loaded reset
	$('#cmsPageTitle').html('페이지 관리');
	arange.naviBar('board', '', '메인페이지');
	arange.list('1','0');
	mkPage.makeTree();
	$("#setting").click(function(){
		arange.moveSetting($('#categoryIdx').val());
	});
	$("#preview").click(function(){
		arange.movePreview($('#categoryIdx').val());
	});
</script>
 