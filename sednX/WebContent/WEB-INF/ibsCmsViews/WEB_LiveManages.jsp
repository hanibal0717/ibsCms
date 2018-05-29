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
	                   		<a id="addLiveTarget" style="cursor:pointer;"><span class="icon" >&#61886;</span> 설정</a>
	                   </div>	
	                 </div>
	                 <div id="pageView"></div>
	                 
                 </div>
                 
			<!--TITLE END-->
			<input type="hidden" id="categoryIdx" value="" />
			<input type="hidden" id="categoryName" value="" />
			<input id="sort" type="hidden" value="live">
			<input id="treeIdx" type="hidden">
			<input id="optionText" type="hidden" value="">
			<!-- CONTENTS END -->	
			</div>
	    </div>
   	</div>
</section>
<script>
$('#categoryIdx').val('${hn:getDefaultLiveIdx()}');
$('#categoryName').val('${hn:getDefaultLiveName()}');
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
			url : "${pageContext.request.contextPath}/api/checkJstree/stb-schedule",
			async : true,
			success : function(data) {
				var retString=data;
				$("#stbGroupCheck").empty();
				$("#stbGroupCheck").html(retString);
			},
			error : exception.ajaxException
		});
	};
	var editSelJstree = function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/api/checkJstreeEdit/stb-schedule"
					+"?groupArr="+$("#groupArr").val(),
			async : true,
			success : function(data) {
				var retString=data;
				$("#stbGroupCheck").empty();
				$("#stbGroupCheck").html(retString);
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
	var targetView=function(idx){
		$.ajax({
			url : "${pageContext.request.contextPath}/cms/liveTarget/"+idx,
			success : function(responseData){
				var data=JSON.parse(responseData);
				$('#channelName').text(data.categoryName);
				var retHtml='';
				var idxList=[];
				for(var i=0;i<data.ret.targetList.length;i++){
					retHtml+='<button class="btn btn-sm targetBtn" id="target_'+data.ret.targetList[i].group_idx+'">'+data.ret.targetList[i].target_name+' <span class="del" style="margin-left: 5px; font-size: 18px;line-height: 0;top: 4px;position: relative;font-weight: 500;" onClick="checkJs.targetCheck('+data.ret.targetList[i].group_idx+')">×</span></button>';
					idxList.push(data.ret.targetList[i].group_idx);
				}
				$('#groupArr').val(idxList.join(','));
				menuJs.editSelJstree();
				$('#modelTargetList').html(retHtml);
			},
			error : exception.ajaxException
		});
	};
	var targetPreview=function(idxArr){
		if(idxArr.length==0){
			$('#modelTargetList').html('방송 타겟이 없습니다.');
		}else{
			$.ajax({
				url : "${pageContext.request.contextPath}/api/categoryNames/stb-schedule"
					+ "?idxArr="+idxArr,
				cache : false,
				type : 'post',
				data : {"idxArr":idxArr},
				async : false,
				success : function(responseData){
					var data=JSON.parse(responseData);
					var retHtml='';
					for(var i=0;i<data.categoryList.length;i++){
						retHtml+='<button class="btn btn-sm targetBtn" id="target_'+data.categoryList[i].idx+'">'+data.categoryList[i].category_name+' <span class="del" style="margin-left: 5px; font-size: 18px;line-height: 0;top: 4px;position: relative;font-weight: 500;" onClick="checkJs.targetCheck('+data.categoryList[i].idx+')">×</span></button>';
					}
					$('#modelTargetList').empty();
					$('#modelTargetList').html(retHtml);
				},
				error : exception.ajaxException
			});
		}
	};
	return {
		naviBar : naviBar,
		list : list,
		contentsView : contentsView,
		targetView : targetView,
		targetPreview : targetPreview 
	}
}());
</script>
<script>
	//loaded reset
	menuJs.makeJsTree();
	$('#cmsPageTitle').html('라이브 관리');
	arange.list($("#categoryIdx").val());
	arange.naviBar('live', $("#categoryIdx").val(), $("#categoryName").val());
	$('#addLiveTarget').click(function(){
		arange.targetView($('#treeIdx').val());
		$('#liveTargetAdd').modal();
	});
	$('#targetInsert').click(function(){
		$.ajax({
			url : "${pageContext.request.contextPath}/cms/target/insert",
			cache : false,
			type : 'post',
			data : {"groupArr":$('#groupArr').val(),"categoryIdx":$('#categoryIdx').val()},
			async : false,
			success : function(data){
				arange.list($("#categoryIdx").val());
				$('#liveTargetAdd').modal('hide');
			},
			error : exception.ajaxException
		});
	});
</script>