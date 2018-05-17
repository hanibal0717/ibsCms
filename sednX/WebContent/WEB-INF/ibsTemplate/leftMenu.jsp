<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld" %>
<style>
.colorpicker { z-index: 9999; } 
#confirmModal { z-index: 9999; } 
</style>
<!-- Sidebar -->
<aside id="sidebar">
	<!-- Sidbar Widgets -->
	<div class="side-widgets overflow">
		<!-- Profile Menu -->
		<div class="text-center s-widget m-b-25 dropdown" id="profile-menu">
			<a href="" data-toggle="dropdown"> <img
				class="profile-pic animated" id="imageFile_view"
				src="${pageContext.request.contextPath}/REPOSITORY/PROFILE/${sessionScope.member_profile}"
				alt="${sessionScope.member_name }"
				onerror="this.src = '${pageContext.request.contextPath}/REPOSITORY/PROFILE/noimage.png';"
				style="cursor: pointer;">
			</a>
			<ul class="dropdown-menu profile-menu">
				<li><div class="fileupload fileupload-new"
						data-provides="fileupload">
						<span class="btn btn-file btn-sm btn-alt"> <span
							class="fileupload-new">이미지 변경</span> <input type="file"
							id="imageFile" onchange="uploadFile.image(this,'imageFile');" />
						</span>
					</div></li>
				<li><a data-toggle="modal" href="#memberEdit">비밀번호 변경</a> <i
					class="icon left">&#61903;</i><i class="icon right">&#61815;</i></li>
				<li><a href="${pageContext.request.contextPath}/cms/logout">로그
						아웃</a> <i class="icon left">&#61903;</i><i class="icon right">&#61815;</i></li>
			</ul>
			<h4 class="m-0">${sessionScope.member_name }</h4>

		</div>
		<!-- Calendar -->
		<div class="s-widget m-b-25">
			<div id="sidebar-calendar"></div>
		</div>
		<!-- Feeds -->
		<div class="s-widget m-b-25">
			<h2 class="tile-title">Notice</h2>
			<div class="s-widget-body">
				<div id="news-feed">
					<i class="icon">&#61710;</i> 펌웨어 가 업데이트 되었습니다.
				</div>
				<div id="news-feed">
					<i class="icon">&#61710;</i> 새 영상이 있습니다.
				</div>
				<div id="news-feed">
					<i class="icon">&#61710;</i> 라이브방송이 편성 되었습니다.
				</div>
			</div>
		</div>
		<!-- Server  Info -->
		<div class="s-widget m-b-25">
			<h2 class="tile-title">SERVER INFO</h2>

			<div class="s-widget-body">
				<div class="side-border">
					<small>HARD DISK</small>
					<div class="progress progress-small">
						<a href="#" data-toggle="tooltip" title=""
							class="progress-bar tooltips progress-bar-danger"
							style="width: 0%;" data-original-title="0%" id="diskSpace"> <span
							class="sr-only" >60% Complete</span>
						</a>
					</div>
				</div>
				<div class="side-border">
					<small>MEMORY</small>
					<div class="progress progress-small">
						<a href="#" data-toggle="tooltip" title=""
							class="tooltips progress-bar progress-bar-info"
							style="width: 0%;" data-original-title="0%" id="memorySpace"> <span
							class="sr-only">43% Complete</span>
						</a>
					</div>
				</div>
				<div class="side-border">
					<small>STB CONNECTION</small>
					<div class="progress progress-small">
						<a href="#" data-toggle="tooltip" title=""
							class="tooltips progress-bar progress-bar-warning"
							style="width: 0%;" data-original-title="0%" id="stbConnection"> <span
							class="sr-only">81% Complete</span>
						</a>
					</div>
				</div>
				<!--  <div class="side-border">
                    <small>VB.Net Software Package</small>
                    <div class="progress progress-small">
                         <a href="#" data-toggle="tooltip" title="" class="tooltips progress-bar progress-bar-success" style="width: 10%;" data-original-title="10%">
                              <span class="sr-only">10% Complete</span>
                         </a>
                    </div>
                </div>
                <div class="side-border">
                    <small>Chrome Extension</small>
                    <div class="progress progress-small">
                         <a href="#" data-toggle="tooltip" title="" class="tooltips progress-bar progress-bar-success" style="width: 95%;" data-original-title="95%">
                              <span class="sr-only">95% Complete</span>
                         </a>
                    </div>
                </div> -->
			</div>
		</div>
	</div>

	<!-- Side Menu -->
	<ul class="list-unstyled side-menu">
		<li class="active"><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/dashboard"> <span
				class="icon">&#61753;</span> <span class="menu-item">DASH BOARD</span>
		</a></li>
		<li><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/contents"> <span
				class="icon">&#61696;</span> <span class="menu-item">CONTENTS ARCHIVE</span>
		</a></li>
		<li><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/communicate"> <span
				class="icon">&#61875;</span> <span class="menu-item">CATEGORY MANAGER</span>
		</a></li>
		<li><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/makepage"> <span
				class="icon">&#61770;</span> <span class="menu-item">WORK SPACE</span>
		</a></li>
		<li><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/liveManages"> <span
				class="icon">&#61824;</span> <span class="menu-item">LIVE</span>
		</a></li>
		<li><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/layout"> <span
				class="icon">&#61717;</span> <span class="menu-item">MAIN PAGE EDITOR</span>
		</a></li>
		
		<!-- <li class="dropdown"><a class="sa-side" href=""> <span
				class="icon">&#61931;</span> <span class="menu-item">셋탑박스 관리</span>
		</a>
			<ul class="list-unstyled menu-item">
				<li><a
					href="${pageContext.request.contextPath}/sedn/stb/controle">셋탑박스
						제어</a></li>
				<li><a
					href="${pageContext.request.contextPath}/sedn/stb/schedule">셋탑박스
						스케쥴</a></li>
				<li><a href="${pageContext.request.contextPath}/sedn/stb/log">셋탑박스
						로그</a></li>
				<li><a href="${pageContext.request.contextPath}/sedn/stb/ui">셋탑박스
						설정</a></li>
			</ul></li>-->
		<li><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/managerAccount">
				<span class="icon">&#61887;</span> <span class="menu-item">ACCOUNT MANAGEMENT</span>
		</a></li>
		<li><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/statistics"> <span
				class="icon">&#61721;</span> <span class="menu-item">CONTENTS ANALIZER</span>
		</a></li>
		<li><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/stb/controle"> <span
				class="icon">&#61931;</span> <span class="menu-item">OTT MANAGEMENT</span>
		</a></li>
		<li><a class="sa-side"
			href="#"> <span
				class="icon">&#61902;</span> <span class="menu-item">UCC MANAGEMENT</span>
		</a></li>
		<li><a class="sa-side"
			href="#"> <span
				class="icon">&#61782;</span> <span class="menu-item">CONFLUENCE MANAGEMENT</span>
		</a></li>
	</ul>

</aside>
<!--######## WARN Modal ######-->
<div class="modal fade" id="msgModal" tabindex="-1" role="dialog"
	aria-hidden="true">
	<div class="alert alert-danger alert-icon alert-dismissable fade in">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<span id="warnText"></span> <i class="icon">&#61730;</i>
	</div>
</div>
<!--######## WARN  Modal ######-->
<!--######## SUCCESS Modal ######-->
<div class="modal fade" id="sucessModal" tabindex="-1" role="dialog"
	aria-hidden="true">
	<div class="alert alert-success alert-icon alert-dismissable fade in">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<span id="successText"></span> <i class="icon">&#61845;</i>
	</div>
</div>
<!--######## SUCCESS  Modal ######-->
<!--######## CONFIRM Modal ######-->
<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog"
	aria-hidden="true">
	<div class="alert alert-info alert-icon alert-dismissable fade in">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<span id="confirmText"></span> <span class="label label-primary"
			id="confirm-done"
			style="margin-left: 20px; padding: 10px; cursor: pointer;"> 확
			인 </span> <span class="label label-primary" id="confirm-cancel"
			style="margin-left: 20px; padding: 10px; cursor: pointer;"> 취
			소 </span> <i class="icon">&#61770;</i>
	</div>
</div>
<!--######## CONFIRM  Modal ######-->
<!--######## PLAYER MODAL ######-->
<div class="modal fade" id="playerModel" tabindex="-1" role="dialog"
	aria-hidden="true">
	<div
		style="position: fixed; background: rgba(0, 0, 0, 0.5); top: 0; left: 0; right: 0; bottom: 0;"
		id="bgModal" data-dismiss="modal"></div>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true" onClick="modalLayer.playerClean();">&times;</button>
				<h4 class="modal-title" id="playerTitle"></h4>
			</div>
			<div class="modal-body" id="playerBody" style="height: 300px;">

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-sm" aria-hidden="true"
					data-dismiss="modal" onClick="modalLayer.playerClean();">Close</button>
				<input type="hidden" id="playerId" />
			</div>
		</div>
	</div>
</div>
<!--######## PLAYER  MODAL ######-->
<!--######## CHANGE CATEGORY  MODAL ######-->
<div class="modal fade" id="changeCateModel" tabindex="-1" role="dialog"
	aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="playerTitle">카테고리 변경</h4>
			</div>
			<div class="modal-body">
				<div id="modalTree"></div>
			</div>
			<div class="modal-footer">
				
				<button type="button" class="btn btn-sm" id="cateChangeSubmit">
					변 경</button>
				<button type="button" class="btn btn-sm" data-dismiss="modal">
					닫 기</button>
			</div>
		</div>
	</div>
</div>
<!--######## CHANGE CATEGORY  MODAL ######-->
<!--######## ADD CONTENTS MODAL ######-->
<div class="modal fade" id="contentsAddModel" tabindex="-1"
	role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="addTitle"></h4>
			</div>
			<div class="modal-body">
				<div id="insertForm"></div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-sm" id="contentsAddSubmit">
					확 인</button>
				<button type="button" class="btn btn-sm" data-dismiss="modal">
					닫 기</button>
			</div>
		</div>
	</div>
</div>
<!--######## ADD CONTENTS   MODAL ######-->
<!--######## MEMBEREIDT MODAL######## -->
<div class="modal fade" id="memberEdit" tabindex="-1" role="dialog"
	aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title">관리자 정보 수정</h4>
			</div>
			<form class="box animated tile form-validation-1" id="member-edit"
				method="post"
				action="${pageContext.request.contextPath}/cms/memberEdit">
				<div class="modal-body">
					<input type="text" name="member_name" id="joinName"
						class="form-control m-b-10 validate[required,maxSize[20],custom[onlyLetterSp]]"
						value="${sessionScope.member_name }" placeholder="이름(소속)">
					<input type="text" id="memberPass"
						class="form-control m-b-10 validate[required,funcCall[loginCheck.checkMemberPass]]"
						placeholder="기존비밀번호"> <input type="password"
						name="member_pass" id="joinPass"
						class="form-control m-b-10 validate[required,maxSize[15],minSize[8],custom[onlyLetterNumber]]"
						placeholder="새 비밀번호"> <input type="password"
						class="form-control m-b-20 validate[required,equals[joinPass]]"
						placeholder="새 비밀번호 확인"> <input type="hidden"
						name="member_email" id="memberEmail"
						value="${sessionScope.member_email}"> <input type="hidden"
						name="idx" id="memberIdx" value="${sessionScope.member_idx}">
				</div>
				<div class="modal-footer">
					<input type="submit" class="btn btn-sm" value="정보변경">
					<button type="button" class="btn btn-sm" data-dismiss="modal">Close</button>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- ##########ADD SCHEDULE##################### -->
<!-- Schedule Time Resize alert -->
 <div class="modal fade" id="addNew-event">
      <div class="modal-dialog">
           <div class="modal-content">
                <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                     <h4 class="modal-title">Add Schedule</h4>
                </div>
                <div class="modal-body">
                    <form class="form-validation" role="form" id="liveAddForm">
                        <div class="form-group col-lg-12">
                             <label for="eventName">방송 제목</label>
                             <input type="text" class="input-sm m-b-10  form-control validate[required]" id="eventName" placeholder="방송 제목">
                        </div>
                        <div class="form-group col-lg-6 m-b-10 ">
                        	<label for="getStart">방송 시작</label>
                         	<input type="text" class="input-sm form-control validate[required]" id="getStart" placeholder="예)2018-01-01 23:12:06:49"/>  
          				</div>
                        <div class="form-group col-lg-6 p-b-10">
                         	<label for="getStart">방송 종료</label>
                          	<input type="text" class="input-sm form-control validate[required,funcCall[uploadFile.checkSchedule]]" id="getEnd" placeholder="예)2018-01-01 23:12:06:49"/>
                        </div>
                        
                        <!-- 대상  -->
                        <div class="form-group col-lg-12">
                        <label>대상 그룹</label>
                        	<div id="scheduleInsertModel"  style="border:1px solid rgba(255,255,255,0.3);"></div>
                        	<input type="text" id="groupArr" class="input-sm form-control validate[required]" style="width:1px;height:1px;opacity: 0;"/>
                        </div>
                        <!-- 소스  -->
                        <div class="form-group col-lg-12">
                        	<label>영상 소스</label>
                        	<div class="tab-container tile">
                        		<ul class="nav tab nav-tabs">
                        			<li class="sourceTab active" value="LIVE" id="liveTab"><a href="#live">STREAM URL</a></li>
                            		<li class="sourceTab" value="VOD" id="vodTab"><a href="#video">VIDEO</a></li>
                        		</ul>
                        		<div class="tab-content" style="padding:5px;">
                        			<div class="tab-pane active" id="live">
                        				${hn:getLiveSource()}
                        			</div>
                        			<div class="tab-pane" id="video" >
                        				
                        			</div>
                        		</div>
                        	</div>
                        	<input type="hidden" id="live_stream_url"/>
                        </div> 
                        <!-- 자막폼 -->
                        <div class="form-group col-lg-12">
                        	<button class="btn btn-xs btn-alt m-r-5" id="captionView">자 막 설 정 열 기</button>
                        </div>
                       	<div class="clearfix"></div>
                        <div id="captionForm" style="border:1px solid rgba(255,255,255,0.3);display:none;">
                        	<!-- 자막  -->
	                        <div class="col-lg-12 p-b-10">
	                        	<div></div>
	                       		<div class="form-group col-lg-3">
	                       			<label for="caption_size" class="control-label">글자 크기</label>
	                       			<div>
	                       				<select id="caption_size" class="form-control input-sm">
	                       					<option value="1">작게</option>
	                       					<option value="2">보통</option>
	                       					<option value="3">크게</option>
	                       				</select>
	                       			</div>
	                       		</div>
	                       		<div class="form-group col-lg-3">
	                       			<label for="caption_text_color" class="control-label">자막 색상</label>
	                       			<div class="color-pick input-icon">
	                       				<input id="caption_text_color" class="form-control color-picker input-sm" type="text">
	                       				<span class="color-preview"></span>
	                                	<span class="add-on">
	                                    <i class="sa-plus"></i>
	                                	</span>
	                       			</div>
	                       		</div>
	                       		<div class="form-group col-lg-3">
	                       			<label for="caption_bg_color" class="control-label">자막 색상</label>
	                       			<div class="color-pick input-icon">
	                       				<input id="caption_bg_color" class="form-control color-picker input-sm" type="text">
	                       				<span class="color-preview"></span>
	                                	<span class="add-on">
	                                    <i class="sa-plus"></i>
	                                	</span>
	                       			</div>
	                       		</div>
	                       		<div class="form-group col-lg-3">
	                       			<label for="caption_speed" class="control-label">자막 동작</label>
	                       			<div>
	                       				<select id="caption_speed" class="form-control input-sm">
	                       					<option value="1">고정</option>
	                       					<option value="2">보통</option>
	                       					<option value="3">빠르게</option>
	                       					<option value="4">천천히</option>
	                       				</select>
	                       			</div>
	                       		</div>
	                       		<div class="form-group col-lg-12">
	                       			<textarea class="form-control overflow" id="caption" tabindex="5001" style="overflow: hidden; outline: none;" placeholder="자막 내용"></textarea>
	                       			<span>자막설정은 최대 255자, 3줄까지만 가능합니다.</span><span style="float:right;"><small id="nowLetter">0</small>/<small>255</small></span>
	                       		</div>
	                       	</div> 
	                       <!-- 자막폼 -->
	                        <div class="clearfix"></div>
                        </div>
                         <!-- 편성 색상  -->
	                        <div class="form-group col-lg-12 p-b-10">
	                        	<div class="form-group col-lg-3">
	                       			<label for="caption_bg_color">편성 색상</label>
	                       			<div class="color-pick input-icon">
	                       				<input id="color" class="form-control color-picker input-sm validate[required]">
	                       				<span class="color-preview"></span>
	                                	<span class="add-on">
	                                    <i class="sa-plus"></i>
	                                	</span>
	                       			</div>
	                       		</div>
	                        </div> 
                        <!-- 대표이미지  -->
	                        <div class="form-group col-lg-12 p-b-10">
	                        	<label for="caption_bg_color">편성 이미지</label>
	                        	<div class="fileupload fileupload-new p-5" data-provides="fileupload">
		       						<div class="fileupload-preview thumbnail form-control" id="imgName_view">편성 이미지를 업로드하세요</div>
		        					<div class="pull-right">
		            					<span class="btn btn-file btn-alt btn-sm">
		                					<span class="fileupload-new">이미지 선택</span>
		                					<span class="fileupload-exists">이미지 바꾸기</span>
		                					<input type="file" id="imgName" onchange="uploadFile.scheduleImg(this,'imgName');" />
		                					
		                				</span>
		            				</div>
		    					</div> 
		    					<input type="text" id="image_path" class="validate[required]" style="opacity: 0;width:1px;height:1px;"> 
	                        </div>
                        <!-- 내용 -->
                        <div class="form-group col-lg-12 p-b-10">
                        	<label for="desc_text">생방송 내용</label>
                        	<textarea class="form-control overflow" id="desc_text" tabindex="5001" style="overflow: hidden; outline: none;"></textarea>
                        </div>
                        <input type="hidden" id="idx"/>
                        <input type="hidden" id="source_type"  value="LIVE"/>
                    	<input type="hidden" id="live_ch_idx" class="form-control"/>
                        <input type="hidden" id="captionYn" value="N">
                        <input type="hidden" id="order">
                     </form>
                </div>
                
                <div class="modal-footer">
                     <input type="button" class="btn btn-info btn-sm" id="addEvent" value="생방송 추가">
                     <button type="button" class="btn btn-info btn-sm" data-dismiss="modal">닫기</button>
                     <button type="button" class="btn btn-info btn-sm" id="deleteEvent" onClick="calClick.deleteEvent();" style="display:none;float:right;">삭 제</button>
                </div>
           </div>
      </div>
 </div>
 <!-- ##########ALL MODAL END SCHEDULE##################### -->   
 <!-- ################# ADD LIVE TARGET MODAL START################### -->
<div class="modal fade in" id="liveTargetAdd" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog" style="top: 30%;">
        <div class="modal-content">
            <div class="modal-body" style="padding: 30px; overflow: hidden;">
                <div class="col-md-12">
                    <div class="m-b-15 col-md-2" style="top: 5px;">
                        <label class="checkbox-inline">
                            채널이름 :
                        </label>
                    </div>
                    <div class="col-md-10">
                        <input type="text" class="form-control input-sm" value="공용채널 #1" />
                    </div>
                </div>

                <div class="col-md-12 m-t-20 m-b-15 p-20" style="border: 1px solid rgba(255, 255, 255, 0.5); width: calc(100% - 29px); left: 15px;">
                    <p style="position: absolute; top: -11px; background: #2c3a45; padding: 0 10px;">방송 대상 선택</p>                            
                    <div class="col-md-4 m-b-15">
                        <div class="btn-group bootstrap-select select">
                            <button type="button" class="btn btn-sm form-control dropdown-toggle" data-toggle="dropdown">
                                <div class="pull-left"><i class="fa fa-desktop m-r-10"></i>인터넷 방송</div>
                            </button>
                            <div class="dropdown-menu open" style="max-height: 654px; overflow: hidden; min-height: 83px; padding: 0;">
                                <ul class="dropdown-menu inner" role="menu" style="max-height: 644px; overflow-y: auto; height: 83px;">
                                    <li><a href="#"><i class="fa fa-desktop m-r-10"></i><span class="text">인터넷 방송</span></a></li>
                                    <li><a href="#"><i class="fa fa-desktop m-r-10"></i>전체 셋탑박스</a></li>
                                    <li class="p-l-10"><a href="#"><i class="fa fa-desktop m-r-10"></i>플래너 본부</a></li>
                                    <li class="p-l-20"><a href="#"><i class="fa fa-desktop m-r-10"></i>1본부</a></li>
                                    <li class="p-l-20"><a href="#"><i class="fa fa-desktop m-r-10"></i>2본부</a></li>
                                    <li  class="p-l-20"><a href="#"><i class="fa fa-desktop m-r-10"></i>3본부</a></li>
                                    <li class="p-l-20"><a href="#"><i class="fa fa-desktop m-r-10"></i>4본부</a></li>
                                    <li class="p-l-10"><a href="#"><i class="fa fa-desktop m-r-10"></i>PCC 지사</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 m-b-15">
                        <button class="btn btn-sm">방송타겟추가 </button>
                    </div>
                	<div class="col-md-12">
                    	<!-- 20180419 메뉴삭제 -->
                    	<div class="col-md-3 m-b-15">
                        	<button class="btn btn-sm">인터넷 방송 <span class="del" style="margin-left: 5px; font-size: 18px;line-height: 0;top: 4px;position: relative;font-weight: 500;">×</span></button>
                    	</div><!-- //20180419 메뉴삭제 -->
                    	
                    </div>
                </div>
            </div>
               
            <div class="modal-footer">
                <button class="btn btn-sm cancel">취소</button>
                <button class="btn btn-sm pull-right" data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>
 <!-- ################# ADD LIVE TARGET MODAL START################### -->                          
<script>
$(function(){
	system.nowInfo();
	String.prototype.lines = function() { return this.split(/\r*\n/); }
	String.prototype.lineCount = function() { return this.lines().length; }
	$('#caption').keyup(function(){
		if($('#caption').val().length>255||$('#caption').val().lineCount()>3){
			jQuery('#caption').validationEngine('showPrompt', '자막은 255자 이하 3줄이하 입니다.', 'pass')
			return false;
		}else{
			jQuery('#vodSource').validationEngine('hideAll');
			$('#nowLetter').text($('#caption').val().length);
		}
	});
	$('#captionView').click(function(ev){
		if($("#captionForm").css('display')=='block'){
			$("#caption").val('');
			$("#caption_size").val('');
			$("#caption_text_color").val('');
			$("#captionForm").css('display','none');
			$('#captionYn').val('N');
			$(this).html('자 막 설 정 열 기');
		}else{
			$("#captionForm").css('display','block');
			$(this).html('자 막 설 정 닫 기');
			$('#captionYn').val('Y');
		}
		ev.preventDefault();
	});
});

	/**Login Check JS**/
	var loginCheck = (function() {
		var catText = "EXIST";
		var catPass = "EXIST";
		var catExist = "NOT_EXIST";
		var checkMemberEmail = function(field, rules, i, options) {
			$
					.ajax({
						url : "${pageContext.request.contextPath}/api/web/checkMemberEmail?member_email="
								+ $("#memberEmail").val(),
						success : function(responseData) {
							var data = JSON.parse(responseData);
							catText = data.msg;
						},
						error : exception.ajaxException
					});
			if (catText != "EXIST") {
				return options.allrules.validate2fields.alertEmail;
			}
		};
		var checkLostEmail = function(field, rules, i, options) {
			$
					.ajax({
						url : "${pageContext.request.contextPath}/api/web/checkMemberEmail?member_email="
								+ $("#lostEmail").val(),
						success : function(responseData) {
							var data = JSON.parse(responseData);
							catText = data.msg;
						},
						error : exception.ajaxException
					});
			if (catText != "EXIST") {
				return options.allrules.validate2fields.alertEmail;
			}
		};
		var checkMemberPass = function(field, rules, i, options) {
			$
					.ajax({
						url : "${pageContext.request.contextPath}/api/web/checkMemberPass?member_email="
								+ $("#memberEmail").val()
								+ "&member_pass="
								+ $("#memberPass").val(),
						success : function(responseData) {
							var data = JSON.parse(responseData);
							catPass = data.msg;
						},
						error : exception.ajaxException
					});
			if (catPass != "EXIST") {
				return options.allrules.validate2fields.alertPass;
			}
		};
		var checkEmailExist = function(field, rules, i, options) {
			$
					.ajax({
						url : "${pageContext.request.contextPath}/api/web/checkMemberEmail?member_email="
								+ $("#joinEmail").val(),
						success : function(responseData) {
							var data = JSON.parse(responseData);
							catExist = data.msg;
						},
						error : exception.ajaxException
					});
			if (catExist != "NOT_EXIST") {
				return options.allrules.validate2fields.alertExist;
			}
		};
		var checkImageExist = function(field, rules, i, options) {
			if ($("#imageFile").val().length == 0) {
				return options.allrules.validate2fields.alertImage;
			}
		};
		return {
			checkMemberEmail : checkMemberEmail,
			checkMemberPass : checkMemberPass,
			checkEmailExist : checkEmailExist,
			checkImageExist : checkImageExist,
			checkLostEmail : checkLostEmail
		};
	}());
	
	/***Exception JS****/
	var exception = (function() {
		var ajaxException = function(data) {
			$("#warnText").text("AJAX EXCEPTION:" + data);
			$("#msgModal").modal();
		};
		var loginException = function() {
			$("#warnText").text("LOGIN ERROR:로그인에 오류가 있습니니다.");
			$("#msgModal").modal();
		};
		var imageFileSizeException = function() {
			$("#warnText").text("2MB 이하 이미지만 업로드 가능합니다. ");
			$("#msgModal").modal();
		};
		var etcFileSizeException = function() {
			$("#warnText").text("30MB 이하 파일만 업로드 가능합니다. ");
			$("#msgModal").modal();
		};
		var imageFileExtException = function() {
			$("#warnText").text("jpg,jpeg,gif,png 파일만 업로드 가능합니다.");
			$("#msgModal").modal();
		};
		var etcFileExtException = function() {
			$("#warnText").text("zip,rar,hwp,doc,ppt,xlx,ai,pdf,pds,mp3 파일만 업로드 가능합니다.");
			$("#msgModal").modal();
		};
		var imageFileUpdateException = function() {
			$("#warnText").text("이미지 업데이트에 실패했습니다.");
			$("#msgModal").modal();
		};
		var fileUpdateException = function() {
			$("#warnText").text("이미지 업로드에 실패했습니다.");
			$("#msgModal").modal();
		};
		var searchException = function() {
			$("#warnText").text("검색어를 입력해 주세요.");
			$("#msgModal").modal();
		};
		var checkboxException = function() {
			$("#warnText").text("체크박스를 한개 이상 체크 해 주세요.");
			$("#msgModal").modal();
		};
		var liveException = function(){
			$("#warnText").text("방송중인 스케쥴은 수정할수 없습니다.");
			$("#msgModal").modal();
		};
		var delConfirm = function(callback) {
			$("#confirm-done").on("click", function() {
				callback(true);
				$("#confirmModal").modal('hide');
			});
			$("#confirm-cancel").on("click", function() {
				callback(false);
				$("#confirmModal").modal('hide');
			});
		};
		var scheduleDelConfirm = function(callback) {
			$("#confirm-done").on("click", function() {
				callback(true);
				$("#confirmModal").modal('hide');
				$('#addNew-event').modal('hide');
			});
			$("#confirm-cancel").on("click", function() {
				callback(false);
				$("#confirmModal").modal('hide');
				$('#addNew-event').modal('hide');
			});
		};
		var addGroupException = function() {
			$("#warnText").text("그룹 추가에 실패하였습니다.");
			$("#msgModal").modal();
		};
		var rootException = function() {
			$("#warnText").text("루트 그룹은 변경이 불가합니다.");
			$("#msgModal").modal();
		};
		var renameException = function() {
			$("#warnText").text("그룹이름 변경에 실패했습니다.");
			$("#msgModal").modal();
		};
		var moveException = function() {
			$("#warnText").text("그룹 이동에 실패했습니다.");
			$("#msgModal").modal();
		};
		var delGroupException = function() {
			$("#warnText").text("그룹 삭제에 실패했습니다.");
			$("#msgModal").modal();
		};
		var keywordException = function() {
			$("#warnText").text("키워드를 입력해주세요.");
			$("#msgModal").modal();
		};
		var menuMakeException = function() {
			$("#warnText").text("게시판 메뉴에서는 하위메뉴를 만들 수 없습니다.");
			$("#msgModal").modal();
		};
		return {
			ajaxException : ajaxException,
			loginException : loginException,
			imageFileSizeException : imageFileSizeException,
			etcFileSizeException : etcFileSizeException,
			imageFileExtException : imageFileExtException,
			etcFileExtException : etcFileExtException,
			imageFileUpdateException : imageFileUpdateException,
			searchException : searchException,
			checkboxException : checkboxException,
			delConfirm : delConfirm,
			scheduleDelConfirm :scheduleDelConfirm,
			addGroupException : addGroupException,
			rootException : rootException,
			renameException : renameException,
			moveException : moveException,
			delGroupException : delGroupException,
			keywordException : keywordException,
			fileUpdateException :fileUpdateException,
			liveException : liveException,
			menuMakeException :menuMakeException
		};
	}());
	/***file upload JS***/
	var uploadFile = (function() {
		var image = function(f, section) {
			var file = f.files;
			if (file[0].size > 2048 * 1024) {
				exception.imageFileSizeException();
				return;
			}
			var localPath = $("#" + section).val();
			var ext = localPath.split('.').pop().toLowerCase();
			if ($.inArray(ext, [ 'jpg', 'jpeg', 'gif', 'png' ]) == -1) {
				exception.imageFileExtException();
				return false;
			}
			var reader = new FileReader();
			reader.onload = function(rst) { // 파일을 다 읽었을 때 실행되는 부분
				$("#" + section + "_view").attr("src", rst.target.result);
			}
			reader.readAsDataURL(file[0]); // 파일을 읽는다
			var formData = new FormData();
			formData.append("uploadFile", f.files[0]);
			formData.append("member_idx", "${sessionScope.member_idx }");
			$
					.ajax({
						url : '${pageContext.request.contextPath}/SEQ/UPLOAD/PROFILE',
						processData : false,
						contentType : false,
						data : formData,
						type : 'POST',
						success : function(responseData) {
							var data = JSON.parse(responseData);
							$
									.ajax({
										url : "${pageContext.request.contextPath}/api/web/profileUpdate?member_idx=${sessionScope.member_idx }&member_email=${sessionScope.member_email }&member_profile="
												+ data.fileName,
										success : function(data) {
											console.log("success");
										},
										error : exception.imageFileUpdateException
									});
						}
					});
		};
		var mainImage = function(f, section) {
			var file = f.files;
			if (file[0].size > 4048 * 1024) {
				exception.imageFileSizeException();
				return;
			}
			var localPath = $("#" + section).val();
			var ext = localPath.split('.').pop().toLowerCase();
			if ($.inArray(ext, [ 'jpg', 'jpeg', 'gif', 'png' ]) == -1) {
				exception.imageFileExtException();
				return false;
			}
			var reader = new FileReader();
			reader.onload = function(rst) { // 파일을 다 읽었을 때 실행되는 부분
				$("#" + section + "_view").attr("src", rst.target.result);
			}
			reader.readAsDataURL(file[0]); // 파일을 읽는다
			var formData = new FormData();
			formData.append("uploadFile", f.files[0]);
			$
					.ajax({
						url : '${pageContext.request.contextPath}/SEQ/UPLOAD/CAROUSEL',
						processData : false,
						contentType : false,
						data : formData,
						type : 'POST',
						success : function(responseData) {
							var data = JSON.parse(responseData);
							$("#img_name").val(data.fileName);
						}
					});
		};
		var scheduleImg=function(f,section){
			var file = f.files;
			if (file[0].size > 4048 * 1024) {
				exception.imageFileSizeException();
				return;
			}
			var localPath = $("#" + section).val();
			var ext = localPath.split('.').pop().toLowerCase();
			if ($.inArray(ext, [ 'jpg', 'jpeg', 'gif', 'png' ]) == -1) {
				exception.imageFileExtException();
				return false;
			}
			var reader = new FileReader();
			reader.onload = function(rst) { // 파일을 다 읽었을 때 실행되는 부분
				$("#" + section + "_view").attr("src", rst.target.result);
			}
			reader.readAsDataURL(file[0]); // 파일을 읽는다
			var formData = new FormData();
			formData.append("uploadFile", f.files[0]);
			$
			.ajax({
				url : '${pageContext.request.contextPath}/SEQ/UPLOAD/SCHIMG',
				processData : false,
				contentType : false,
				data : formData,
				type : 'POST',
				success : function(responseData) {
					var data = JSON.parse(responseData);
					$("#image_path").val(data.fileName);
				}
			});
		};
		var checkFileExist = function(field, rules, i, options) {
			if ($("#file_path").val().length == 0) {
				return options.allrules.validate2fields.alertFile;
			}
		};
		var checkPhotoExist = function(field, rules, i, options) {
			if ($("#photo_path").val().length == 0) {
				return options.allrules.validate2fields.alertFile;
			}
		};
		var checkMainImgExist = function(field, rules, i, options) {
			if ($("#img_name").val().length == 0) {
				return options.allrules.validate2fields.alertFile;
			}
		};
		var checkVodExist = function(field, rules, i, options) {
			if ($("#vod_path").val().length == 0) {
				return options.allrules.validate2fields.alertFile;
			}
		};
		var checkSchedule=function(field, rules, i, options){
			var start=new Date(Date.parse($("#getStart").val()));
			var end=new Date(Date.parse($("#getEnd").val()));
			if(start>=end){
				return options.allrules.validate2fields.alertSchedule;
			}
		};
		var mediaEncoding=function(file){
			$.ajax({
				url : "${pageContext.request.contextPath}/api/web/mediaEncodingRate?file="
						+ file,
				success : function(responseData) {
					var data = JSON.parse(responseData);
					trans_rate =data.rate;
					if(trans_rate<100){
						console.log(trans_rate);
						$("#encodingBar").css('width',trans_rate+'%');
						if(trans_rate>0){
							$("#encodginText").text(trans_rate+'% 완료');
						}
						mediaEncoding(data.file);
					}else{
						$("#encodingBarLayout").css('display','none');
						$("#vod_path").val(data.file);
						//runtime&thubnail
						$("#vod_play_time").val(data.vod_play_time);
						$("#main_thumbnail").val(data.main_thumbnail);
						$("#file_size").val(data.file_size);
						//올린 영상 보여주기.
						modalLayer.vodPlayer(data.url);
						//썸네일 보여주기
						var fileHead=data.file.split('.');
						$("#thumbnailList").empty();
						var imgDiv="";
						for(var i=0;i<10;i++){
							imgDiv+='<div class="col-xs-3 thumb"><img src="${pageContext.request.contextPath}/REPOSITORY/THUMBNAIL'+data.datePath+fileHead[0]+'_'+i+'.jpg" ></div>'
							if(i==0){
								$("#main_thumbnail").val(fileHead[0]+'_'+i+'.jpg');
								$(".thumb").addClass('boxLine');
							}
							
						}
						setTimeout(function(){
							$("#thumbnailList").html(imgDiv);
						},5000);
						
					}
				},
				error : exception.ajaxException
			});
		};
		return {
			image : image,
			checkFileExist:checkFileExist,
			checkPhotoExist:checkPhotoExist,
			checkMainImgExist:checkMainImgExist,
			checkVodExist:checkVodExist,
			mediaEncoding:mediaEncoding,
			mainImage:mainImage,
			checkSchedule:checkSchedule,
			scheduleImg:scheduleImg
		};
	}());

	var modalLayer = (function() {
		var livePlayer = function(idx, group, name, url) {
			if (videojs.getPlayers()['my-player_' + idx]) {
				delete videojs.getPlayers()['my-player_' + idx];
			}
			$("#playerBody").html('');
			$("#playerTitle").html(group + "/" + name)
			var html = '<video id="my-player_'
					+ idx
					+ '" class="video-js"  controls preload="auto"  poster="${pageContext.request.contextPath}/img/live.jpg"  data-setup="{}" style="width: 100% !important; height: 100% !important;">';
			html += '<source  src="'+url+'"  type="application/x-mpegURL"></source>';
			html += '</video>';
			$("#playerId").val('my-player_' + idx);
			$("#playerBody").html(html);
			$("#playerModel").modal();
			var options = {};
			var player = videojs('my-player_' + idx, options,
					function onPlayerReady() {
						this.play();
						this.on('ended', function() {
							videojs.log(' so soon?!');
						});
					});
		};
		var playerClean = function() {
			var playerCash = $("#playerId").val();
			var myPlayer = videojs(playerCash);
			if (videojs.getPlayers()[eval("'" + playerCash + "'")]) {
				myPlayer.dispose();
				delete videojs.getPlayers()[eval("'" + playerCash + "'")];
			}
		};
		var vodPlayer=function(url,thumbnail){
			if (videojs.getPlayers()['my-player_modal']) {
				delete videojs.getPlayers()['my-player_modal'];
			}
			var html = '<video id="my-player_modal" class="video-js"  controls preload="auto"  poster="${pageContext.request.contextPath}'+thumbnail+'"  data-setup="{}" style="width: 100% !important; height: 100% !important;">';
			html += '<source  src="'+url+'"  type="application/x-mpegURL"></source>';
			html += '</video>';
			$("#preview").html(html);
			var options = {};
			var player = videojs('my-player_modal', options,
				function onPlayerReady() {
					//this.play();
					this.on('ended', function() {
						videojs.log('vod end');
					});
				});
		};
		return {
			livePlayer : livePlayer,
			playerClean : playerClean,
			vodPlayer:vodPlayer
		};
	}());
	$(function() {
		$("#cateChangeSubmit").click(function() {
			$.ajax({
				url : '/cms/update/elemCategory',
				type : 'post',
				data : {
					"updateIdx" : $("#categoryIdx").val(),
					"selectedIdx" : $("#selectedIdx").val(),
					"sort" : $("#sort").val()
				},
				async : false,
				success : function(result) {
					contents.selectArrange($("#categoryIdx").val());
					$("#changeCateModel").modal('hide');
				},
				error : exception.ajaxException
			});
		});

		$("#cateChangeBtn").click(function() {
			var checkValArr = $("#selectedIdx").val();
			if (checkValArr.length == 0) {
				exception.checkboxException();
			} else {
				menuJs.makeSelJstree();
			}
		});
		$("#bgModal").click(function() {
			modalLayer.playerClean();
		});
		var frm = $("#member-edit");
		frm
				.submit(function(ev) {
					if ($("#joinName").val().length != 0
							&& $("#joinPass").val().length != 0) {
						$
								.ajax({
									type : frm.attr("method"),
									url : frm.attr("action"),
									data : frm.serialize(),
									success : function(data) {
										$("#memberEdit").modal('hide');
										if (data == "success") {
											$(location)
													.attr('href',
															'${pageContext.request.contextPath}/sednmanager');
										}
									}
								});
					}
					ev.preventDefault();
				});
		
	});
	var keyword=(function(){
		var removeWord=function(obj){
			keywordArr.splice($.inArray($(obj).attr("title"),keywordArr),1);
			$(obj).fadeOut('fast');	
			$("#keyword").val(keywordArr);
		}
		return{
			removeWord:removeWord
		};
	}());
	var thumbnail=(function(){
		var changeMain=function(obj){
			$("#main_thumbnail").val($(obj).attr("id"));
			$(".thumb").removeClass('boxLine');
			$(obj).addClass('boxLine');
		};
		return{
			changeMain:changeMain
		};
	}());
	var system=(function(){
		var nowInfo=function(){
			$.ajax({
				url : "${pageContext.request.contextPath}/cms/system/current",
				success : function(responseData) {
					var data = JSON.parse(responseData);
					$("#diskSpace").css("width",data.diskPercent+'%');
					$("#diskSpace").attr("data-original-title",data.diskPercent+'%');
					$("#diskSpace").children().text(data.diskPercent);
					$("#memorySpace").css("width",data.memoryPercent+'%');
					$("#memorySpace").attr("data-original-title",data.memoryPercent+'%');
					$("#memorySpace").children().text(data.memoryPercent);
					$("#stbConnection").css("width",data.stbPercent+'%');
					$("#stbConnection").attr("data-original-title",data.stbPercent+'%');
					$("#stbConnection").children().text(data.stbPercent);
				},
				error : exception.ajaxException
			});
		};
		return{
			nowInfo:nowInfo
		};
	}());
	var common=(function(){
		var formatZeroDate=function(n, digits){
			 var zero = '';
			    n = n.toString();
			    if (digits > n.length) {
			        for (var i = 0; digits - n.length > i; i++) {
			            zero += '0';
			        }
			    }
			    return zero + n;
		};
		var isNotEmpty=function(value){
			return value!="";
		};
		var runtimeToSecond=function(runtime){
			var ts = runtime.split(':');
		    return Date.UTC(1970, 0, 1, ts[0], ts[1], ts[2]) / 1000;
		};
		var setDate=function(intData){
			var StringDate=new Date(intData);
            var hh = formatZeroDate(StringDate.getHours(),2);
            var mm = formatZeroDate(StringDate.getMinutes(),2);
            return $.datepicker.formatDate('yy-mm-dd '+hh+':'+mm,StringDate);
		}
		return{
			formatZeroDate:formatZeroDate,
			isNotEmpty:isNotEmpty,
			runtimeToSecond:runtimeToSecond,
			setDate:setDate
		};
	}());
	$(function(){
		$(".sourceTab").click(function(){
			$('#source_type').val($(this).attr('value'));
		});
		$("#selectLive").change(function(){
			$("#live_stream_url").val($(this).val());
			$("#live_ch_idx").val($('#selectLive > option:eq('+this.selectedIndex+')').attr('title'));
		});
	});
	String.prototype.toHHMMSS = function () {
	    var myNum = parseInt(this, 10);
	    var hours   = Math.floor(myNum / 3600);
	    var minutes = Math.floor((myNum - (hours * 3600)) / 60);
	    var seconds = myNum - (hours * 3600) - (minutes * 60);

	    if (hours   < 10) {hours   = "0"+hours;}
	    if (minutes < 10) {minutes = "0"+minutes;}
	    if (seconds < 10) {seconds = "0"+seconds;}
	    return hours+':'+minutes+':'+seconds;
	}
</script>

