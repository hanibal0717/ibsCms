<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsCmsJs/functionInc.js"></script>
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
	    		<div class="tile" id="listView">
                      <div class="tile-title">
                          <h5 class="pull-left"><i class="fa fa-bars m-r-10"></i><span id="navibar">메인 페이지</span></h5>
                          <div class="col-md-6 pull-right">
                              <div class="col-md-4 p-r-20 m-t-5">
                                   <select name="" id="" class="form-control input-sm">
                                       <option value="media_vod.html">VOD</option>
                                       <option value="media_live.html">LIVE</option>
                                       <option value="">PHOTO</option>
                                       <option value="">FILE</option>
                                   </select>
                               </div>
                               <div class="col-md-8 p-0">                                        
                                   <input type="text" class="main-search" style="border-bottom: 1px solid #fff; width: 100%;" placeholder="검색어를 입력하세요." />                               
                               </div>
                           </div>
                      </div>
                      <div class="photo-gallery clearfix">
                          <div class="photo">
                              <div class="form_div col-md-12" id="contentView">
                                  
                              </div>
                          </div>
                      </div>

                      <div class="tile col-md-12 p-5">
                          <div class="col-md-6">
                              <button class="btn btn-alt col-md-2 m-r-10 m-b-5" onclick="location.href='pages_sub_02.html'">편집</button>                            
                          </div>
                          <div class="col-md-6">
                              <button class="btn btn-alt col-md-2 m-b-5 pull-right">추가</button>
                          </div>
                      </div>

                  </div>
	    		
	    	</div>
	    </div>
	</div>
</section>
<input id="sort" type="hidden" value="vod">
<input type="hidden" id="categoryIdx" value="" />
<input type="hidden" id="categoryName" value="" />
<input id="treeIdx" type="hidden">
<script>
$('#categoryIdx').val('${hn:getDefaultContentsIdx()}');
$('#categoryName').val('${hn:getDefaultContentsName()}');
var menuJs={
		makeJsTree:function(){
			$.ajax({
				url : "${pageContext.request.contextPath}/api/advenceTree/"
						+ $("#sort").val(),
				async : false,
				success : function(data) {
					$("#menuTree").empty();
					$("#menuTree").html(data);
				},
				error : exception.ajaxException
			});
		}
};
var arange={
		naviBar:function(){
			$("#sort").val(arguments[0]);
			$("#navibar").html(arguments[2]);
		},
		list:function(idx,property){
			arange.contentsView(idx);
		},
		contentsView:function(idx){
			$("#contentView").empty();
			$.ajax({
				url : "${pageContext.request.contextPath}/cms/list/"
					+ $("#sort").val() + "?childIdx="+idx,
				success : function(data){
					$('#contentView').html(data);
				},
				error : exception.ajaxException
			});
		}
};
</script>
<script>
$('#cmsPageTitle').html('미디어 관리');
menuJs.makeJsTree();
arange.naviBar('vod', $("#categoryIdx").val(), $("#categoryName").val());
arange.list($('#treeIdx').val());
</script>
