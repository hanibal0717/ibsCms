<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld" %>
<style>
.colorpicker { z-index: 9999; } 
#confirmModal { z-index: 9999; }
.dropdown-menu a.jstree-anchor{color:#fff; background:none;}
.dropdown-menu a:hover, .dropdown-menu a:focus{color:#fff;}
.bell {font-size: 15px; font-weight: normal;}
.modal .thumnail a.close {position: absolute; right: 2px; top: 2px; opacity: 1; background: rgba(0,0,0,0.5); width: 16px; height: 16px; border-radius: 8px !important; }
.modal .thumnail a.close img {margin-top: -1px;}
.form_div.sm {height: 350px;}
.form_div.sm .img_box {width: calc(50% - 10px); height: 105px;}
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
		<!-- <div class="s-widget m-b-25">
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
		</div> -->
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
		<!-- <li class="active"><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/dashboard"> <span
				class="icon">&#61753;</span> <span class="menu-item">DASH BOARD</span>
		</a></li> -->
		<li><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/media"> <span
				class="icon">&#61696;</span> <span class="menu-item">CONTENTS</span>
		</a></li>
		<!-- <li><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/contents"> <span
				class="icon">&#61696;</span> <span class="menu-item">CONTENTS ARCHIVE</span>
		</a></li> -->
		<!-- <li><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/communicate"> <span
				class="icon">&#61875;</span> <span class="menu-item">CATEGORY</span>
		</a></li> -->
		<li><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/makepage"> <span
				class="icon">&#61875;</span> <span class="menu-item">MAKE PAGE</span>
		</a></li>
		<li><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/liveManages"> <span
				class="icon">&#61824;</span> <span class="menu-item">LIVE</span>
		</a></li>
		<!-- <li><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/layout"> <span
				class="icon">&#61717;</span> <span class="menu-item">MAIN PAGE EDITOR</span>
		</a></li> -->
		
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
		<!-- <li><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/web/statistics"> <span
				class="icon">&#61721;</span> <span class="menu-item">CONTENTS ANALIZER</span>
		</a></li> -->
		<li><a class="sa-side"
			href="${pageContext.request.contextPath}/sedn/stb/controle"> <span
				class="icon">&#61931;</span> <span class="menu-item">OTT MANAGEMENT</span>
		</a></li>
		<!-- <li><a class="sa-side"
			href="#"> <span
				class="icon">&#61902;</span> <span class="menu-item">UCC MANAGEMENT</span>
		</a></li> -->
		<!-- <li><a class="sa-side"
			href="#"> <span
				class="icon">&#61782;</span> <span class="menu-item">CONFLUENCE MANAGEMENT</span>
		</a></li> -->
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

 <!-- ################# ADD LIVE TARGET MODAL START################### -->
<div class="modal fade in" id="liveTargetAdd" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog" style="top: 30%;">
        <div class="modal-content">
            <div class="modal-body" style="padding: 30px; overflow: hidden;">
                <div class="col-md-12">
                    <div class="m-b-15 col-md-10" style="top: 5px;">
                        <label class="checkbox-inline">
                            채널이름 : <span id="channelName"></span>
                        </label>
                    </div>
                </div>
				<script>
				$(function(){
					$("button.dropdown-toggle").click(function(){
						if($(".dropdown-menu.open").css("display") == "none"){
							$(".dropdown-menu.open").css("display","block");
							$(this).parent().parent().after(
								'<div class="col-md-3 m-b-15">'+
									'<button class="btn btn-sm" id="asd">닫기</button>'+
								'</div>'
							);
						};
						$("#asd").on('click', function(){
							$(".dropdown-menu.open").css("display","none");
							$("#asd").parent("div").remove();
						});
					});
				});
				</script>
                <div class="col-md-12 m-t-20 m-b-15 p-20" style="border: 1px solid rgba(255, 255, 255, 0.5); width: calc(100% - 29px); left: 15px;">
                    <p style="position: absolute; top: -11px; background: #2c3a45; padding: 0 10px;">방송 대상 선택</p>                            
                    <div class="col-md-7 m-b-15">
                        <div class="btn-group bootstrap-select select">
                            <button type="button" class="btn btn-sm form-control dropdown-toggle">
                                <span class="pull-left">타겟 선택</span>
                            </button>
                            <div class="dropdown-menu open" style="max-height: 654px; overflow: hidden; min-height: 83px; padding: 0; background:rgb(25, 27, 31);">
                                <div class="dropdown-menu inner" role="menu" style="max-height: 644px; overflow-y: auto; height: 83px;" id="stbGroupCheck">
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                    <input type="hidden"/>
                	<div class="col-md-12" id="modelTargetList">
                    	<!-- 20180419 메뉴삭제 -->
                    	
                    </div>
                </div>
            </div>
               
            <div class="modal-footer">
                <button class="btn btn-sm cancel" data-dismiss="modal">취소</button>
                <button class="btn btn-sm pull-right" id="targetInsert">확인</button>
            </div>
        </div>
    </div>
</div>
 <!-- ################# ADD LIVE TARGET MODAL START################### -->   
 <!-- ###############영상 보기 모달 시작 ######################### -->
 <div class="modal fade in" id="vodViewModal" tabindex="-1" role="dialog" aria-hidden="false"> 
	<div class="modal-dialog">
          <div class="modal-content mainImgPopup">
              <div class="media-form">
                  <div class="video"><img src="${pageContext.request.contextPath}/ibsImg/img_video.png" alt="샘플"></div>
                  <a class="play" href="#"><img src="${pageContext.request.contextPath}/ibsImg/img_play.png" alt="재생"></a>
                  <a class="info" href="#"><img src="${pageContext.request.contextPath}/ibsImg/img_info.png" alt="정보"></a>
                  <div class="infoForm" style="display: none;">
                      <ul>
                          <li>해상도 : 1808 x 920</li>
                          <li>재생시간 : 01:00:24</li>
                          <li>용량 : 3.7GB</li>
                      </ul>
                  </div>
              </div>
              <div class="contents">
                  <p class="title">레디 플레이어 원</p>
                  <div class="data">
                      <p>등록일 : 2018.04.10</p>
                      <a class="down" href="#"><img src="${pageContext.request.contextPath}/ibsImg/btn_download.png" alt="다운로드"></a>
                      <div class="downForm">
                          <div class="triangle"></div>
                          <a href="#"><img src="${pageContext.request.contextPath}/ibsImg/img_close_sm.png" alt="닫기"></a>
                          <ul>
                              <li>· <a href="#">Sednmanager.ppt (2MB)</a></li>
                          </ul>
                      </div>
                      <p class="hits">580</p>
                  </div>
                  <p class="text">
                      2045년, 암울한 현실과 달리 가상현실 오아시스(OASIS)에서는  누구든 원하는 캐릭터로 어디든지 갈 수 있고, 뭐든지 할 수 있고 상상하는 모든 게 가능하다.<br>웨이드 와츠(타이 쉐리던) 역시 유일한 낙은 대부분의 사람들이 하루를 보내는 오아시스에 접속하는 것이다. 어느 날 오아시스의 창시자인 괴짜 천재 제임스 할리데이(마크 라이런스)는 자신이 가상현실 속에 숨겨둔 3개의 미션에서 우승하는 사람에게 오아시스의 소유권과 막대한 유산을 상속한다는 유언을 남기고, 그가 사랑했던 80년대 대중문화 속에 힌트가 있음을 알린다.<br>제임스 할리데이를 선망했던 소년 ‘웨이드 와츠’가 첫 번째 수수께끼를 푸는 데 성공하자 이를 저지하기 위해 현실에서 살인도 마다하지 않는 ‘IOI’라는 거대 기업이 뛰어든다. 
                  </p>
              </div>
              <div class="modal-footer">
                  <button class="btn btn-sm cancel">취소</button>
                  <button class="btn btn-sm">삭제</button>
                  <button class="btn btn-sm pull-right" id="popupSub">편집</button>
              </div>
          </div>
          <!-- 수정  -->
         <!--  <div class="modal-content">
                <div class="modal-header" style="overflow: hidden;">
                    <h4 class="pull-left">VOD 수정</h4>
                    <button class="btn btn-sm pull-right m-t-10">불러오기</button>
                </div>
                <div class="modal-body">
                    <div class="media-form">
                        <div class="video"><img src="${pageContext.request.contextPath}/ibsImg/img_video.png" alt="샘플"></div>
                        <a class="play" href="#"><img src="${pageContext.request.contextPath}/ibsImg/img_play.png" alt="재생"></a>
                        <a class="info" href="#"><img src="${pageContext.request.contextPath}/ibsImg/img_info.png" alt="정보"></a>
                    </div>
                    <div class="bx-wrapper" style="max-width: 530px;"><div class="bx-viewport" aria-live="polite" style="width: 100%; overflow: hidden; position: relative; height: 100px;"><div class="thumnail" style="width: 6215%; position: relative; transition-duration: 0s; transform: translate3d(-810px, 0px, 0px);"><div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" class="bx-clone" aria-hidden="true"></div><div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" class="bx-clone" aria-hidden="true"></div><div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" class="bx-clone" aria-hidden="true"></div><div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" class="bx-clone" aria-hidden="true"><a class="add" href="#"><img src="img/img_add.png" alt="추가"></a></div>
                        <div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" aria-hidden="true"></div>
                        <div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" aria-hidden="true"></div>
                        <div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" aria-hidden="false"></div>
                        <div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" aria-hidden="false"></div>
                        <div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" aria-hidden="false"></div>
                        <div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" aria-hidden="false"><a class="add" href="#"><img src="${pageContext.request.contextPath}/ibsImg/img_add.png" alt="추가"></a></div>
                    <div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" class="bx-clone" aria-hidden="true"></div><div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" class="bx-clone" aria-hidden="true"></div><div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" class="bx-clone" aria-hidden="true"></div><div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" class="bx-clone" aria-hidden="true"></div></div></div><div class="bx-controls bx-has-controls-direction"><div></div><div class="bx-controls-direction"><div></div><a class="bx-prev" href="">Prev</a><a class="bx-next" href="">Next</a></div></div></div>
                    <input type="text" class="form-control m-b-10" placeholder="제목">
                    <textarea class="form-control m-b-10" placeholder="내용"></textarea>
                    <input type="text" class="form-control m-b-10" placeholder="키워드 및 태그">
                </div>
                <div class="modal-footer">
                    <button class="btn btn-sm cancel">취소</button>
                    <button class="btn btn-sm">확인</button>
                </div>
            </div> -->
                        
      </div>
 </div>                  
 <!-- ###############영상 보기 모달  끝 ######################### --> 
 <!-- ###############영상 추가 모달 시작 ######################### -->
 <div class="modal fade in" id="vodEditModal" tabindex="-1" role="dialog" aria-hidden="false"> 
 	<div class="modal-content">
        <div class="modal-header" style="overflow: hidden;">
            <h4 class="pull-left">VOD 수정</h4>
            <button class="btn btn-sm pull-right m-t-10">불러오기</button>
        </div>
        <div class="modal-body">
            <div class="media-form">
                <div class="video"><img src="${pageContext.request.contextPath}/ibsImg/img_video.png" alt="샘플"></div>
                <a class="play" href="#"><img src="${pageContext.request.contextPath}/ibsImg/img_play.png" alt="재생"></a>
                <a class="info" href="#"><img src="${pageContext.request.contextPath}/ibsImg/img_info.png" alt="정보"></a>
            </div>
            <div class="bx-wrapper" style="max-width: 530px;"><div class="bx-viewport" aria-live="polite" style="width: 100%; overflow: hidden; position: relative; height: 100px;"><div class="thumnail" style="width: 6215%; position: relative; transition-duration: 0s; transform: translate3d(-810px, 0px, 0px);"><div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" class="bx-clone" aria-hidden="true"></div><div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" class="bx-clone" aria-hidden="true"></div><div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" class="bx-clone" aria-hidden="true"></div><div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" class="bx-clone" aria-hidden="true"><a class="add" href="#"><img src="img/img_add.png" alt="추가"></a></div>
                <div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" aria-hidden="true"></div>
                <div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" aria-hidden="true"></div>
                <div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" aria-hidden="false"></div>
                <div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" aria-hidden="false"></div>
                <div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" aria-hidden="false"></div>
                <div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" aria-hidden="false"><a class="add" href="#"><img src="${pageContext.request.contextPath}/ibsImg/img_add.png" alt="추가"></a></div>
            <div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" class="bx-clone" aria-hidden="true"></div><div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" class="bx-clone" aria-hidden="true"></div><div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" class="bx-clone" aria-hidden="true"></div><div style="float: left; list-style: none; position: relative; width: 125px; margin-right: 10px;" class="bx-clone" aria-hidden="true"></div></div></div><div class="bx-controls bx-has-controls-direction"><div></div><div class="bx-controls-direction"><div></div><a class="bx-prev" href="">Prev</a><a class="bx-next" href="">Next</a></div></div></div>
            <input type="text" class="form-control m-b-10" placeholder="제목">
            <textarea class="form-control m-b-10" placeholder="내용"></textarea>
            <input type="text" class="form-control m-b-10" placeholder="키워드 및 태그">
        </div>
        <div class="modal-footer">
            <button class="btn btn-sm cancel">취소</button>
            <button class="btn btn-sm">확인</button>
        </div>
    </div>
 </div>   
 <!-- ###############영상 편집 모달 끝 ######################## -->
 <!-- ###############라이브 편집 모달 시작 ######################### -->
 <div class="modal fade in" id="liveEditModal" tabindex="-1" role="dialog" aria-hidden="false"> 
 라이브편집 
 </div>  
 <!-- ###############라이브 편집 모달 끝 ######################## -->
 <!-- ###############게시물 보기 모달 시작 ######################### -->
 <div class="modal fade in" id="scheduleViewModal" tabindex="-1" role="dialog" aria-hidden="false"> 
 게시물보기 
 </div>  
 <!-- ###############게시물 보기 모달  끝 ######################### --> 
 <!-- ###############게시물 추가 모달 시작 ######################### -->
 <div class="modal fade in" id="scheduleEditModal" tabindex="-1" role="dialog" aria-hidden="false"> 
 게시물편집 
 </div> 
 <!-- ###############게시물 편집 모달 끝 ######################## -->  
 <!-- ###############스케쥴 보기 모달 시작 ######################### -->
 <div class="modal fade in" id="scheduleViewModal" tabindex="-1" role="dialog" aria-hidden="false">
 	<div class="modal-dialog">
        <div class="modal-content mainImgPopup">
            <div class="media-form">
                <div class="video"><img src="${pageContext.request.contextPath}/ibsImg/img_video.png" alt="샘플"></div>
                <a class="play" href="#"><img src="${pageContext.request.contextPath}/ibsImg/img_play.png" alt="재생"></a>
                <!-- <a class="info" href="#"><img src="${pageContext.request.contextPath}/ibsImg/img_info.png" alt="정보"></a> -->
                <div class="infoForm">
                    <ul>
                        <li>해상도 : 1808 x 920</li>
                        <li>재생시간 : 01:00:24</li>
                        <li>용량 : 3.7GB</li>
                    </ul>
                </div>
            </div>
            <div class="contents">
               
                <p class="title">VOD 방송 #1</p>
                <div class="data">
                    <p class="bell"><i class="fa fa-bell"></i> 2018.4.10 13:30~15:00</p>
                </div>
                <p class="text">
                    2045년, 암울한 현실과 달리 가상현실 오아시스(OASIS)에서는  누구든 원하는 캐릭터로 어디든지 갈 수 있고, 뭐든지 할 수 있고 상상하는 모든 게 가능하다.<br>웨이드 와츠(타이 쉐리던) 역시 유일한 낙은 대부분의 사람들이 하루를 보내는 오아시스에 접속하는 것이다. 어느 날 오아시스의 창시자인 괴짜 천재 제임스 할리데이(마크 라이런스)는 자신이 가상현실 속에 숨겨둔 3개의 미션에서 우승하는 사람에게 오아시스의 소유권과 막대한 유산을 상속한다는 유언을 남기고, 그가 사랑했던 80년대 대중문화 속에 힌트가 있음을 알린다.<br>제임스 할리데이를 선망했던 소년 ‘웨이드 와츠’가 첫 번째 수수께끼를 푸는 데 성공하자 이를 저지하기 위해 현실에서 살인도 마다하지 않는 ‘IOI’라는 거대 기업이 뛰어든다. 
                </p>
            </div>
            <div class="modal-footer">
                <button class="btn btn-sm cancel">취소</button>
                <button class="btn btn-sm">삭제</button>
                <button class="btn btn-sm pull-right" id="popupSub">편집</button>
            </div>
        </div>
    </div> 
 	
 </div>  
 <!-- ###############스케쥴 보기 모달  끝 ######################### --> 
 <!-- ###############스케쥴 추가 모달 시작 ######################### -->
 <div class="modal fade in" id="addNew-event" tabindex="-1" role="dialog" aria-hidden="false"> 
	<div class="modal-dialog">
         <div class="modal-content mainImgPopup">
         	      
             <div class="modal-body" style="overflow:hidden;">
              <form class="form-validation">
                 <div class="media-form">
                 	<div class="fileupload fileupload-new" data-provides="fileupload" style="height:323px;">
     					<div class="fileupload-preview thumbnail form-control imgSize" id="imgName_view" style="padding:0;height:323px;">
     					<img src="${pageContext.request.contextPath}/img/live.jpg" alt="샘플" class="upImageSize"></div>
      					<div class="pull-right">
          					<span class="btn btn-file btn-alt btn-sm blackBtn" style="position: absolute; top: 20px; left: 20px;">
              					<span class="fileupload-new">대표 이미지</span>
              					<span class="fileupload-exists">이미지 바꾸기</span>
              					<input type="file" id="imgName" onchange="uploadFile.scheduleImg(this,'imgName');" />
              				</span>
          				</div>
          				<input type="text" id="image_path" class="validate[required]" style="opacity: 0;width:1px;height:1px;"> 
  					</div> 
  					
                 <!--  -->
                 	<!--  <button class="btn btn-sm" style="position:  absolute; z-index: 1; top: 10px; left: 10px;">대표이미지</button>   -->
                     <!-- <div class="video"><img src="${pageContext.request.contextPath}/img/live.jpg" alt="샘플"></div> -->
                     <!-- <a class="play" href="#"><img src="${pageContext.request.contextPath}/ibsImg/img_play.png" alt="재생"></a> -->
                     <!-- <a class="info" href="#"><img src="${pageContext.request.contextPath}/ibsImg/img_info.png" alt="정보"></a> -->
                 </div>
                 <div class="slideInner">
	                  <div class="slide">
	                  	<ul id="slideShow">
	                  		<li id="scheduleVodList">
	                  			<a class="add"><img src="${pageContext.request.contextPath}/ibsImg/img_add.png" alt="추가" /></a>
	                  		</li>
	                  	</ul>
                      </div>
                      <div>
                          <a class="prev" onClick='slide.prev();'>prev</a>
                          <a class="next" onClick='slide.next();'>next</a>
                      </div>
                  </div>
                  <input type="hidden" id="groupArr" class="input-sm form-control"/>
                  <input type="hidden" class="form-control" id="live_stream_url"/>
                  <input type="hidden" class="form-control" id="color" value="#9FD5EF">
                  <input type="hidden" id="vodArr" class="form-control"/>
                  <input type="hidden" class="form-control" id="idx"/>
                  <input type="hidden" class="form-control" id="source_type"  value="VOD"/>
              	  <input type="hidden" class="form-control" id="live_ch_idx" class="form-control"/>
                  <input type="hidden" class="form-control" id="captionYn" value="N">
                  <input type="hidden" class="form-control" id="order" value="insert">
                  <div class="get" style="position: absolute; top: 280px; right: 35px; display: none;">
                     <div class="btn btn-sm pull-left m-b-5 blackBtn">PC에서 가져오기</div><br>
                     <div class="btn btn-sm pull-left blackBtn" id="repositoryAdd">저장소에서 가져오기</div>
                 </div>
                 <div class="col-md-9 m-b-10">
                     <input type="text" class="form-control validate[required]" id="eventName" placeholder="제목" value="" placeholder="방송 제목">
                 </div>
                 <div class="col-md-3 m-b-10" id="check">
	             	<div class="icheckbox_minimal">
	             		<div aria-checked="false" aria-disabled="false" style="position: relative;">
                       		<input type="checkbox" />
                         		방송 시작 알림
                     	</div>
                 	</div>
                 </div>
                 <div class="col-md-6 m-b-10">
                     <input type="text" class="form-control validate[required]" id="getStart" value="" placeholder="예)2018-01-01 23:12:06:49">
                 </div>
                 <div class="col-md-6 m-b-10">
                     <input type="text" class="form-control validate[required,funcCall[uploadFile.checkSchedule]]" id="getEnd"  value="" placeholder="예)2018-01-01 23:12:06:49">
                 </div>
                 <div class="col-md-12 m-b-10"><textarea class="form-control m-b-10 validate[required]" id="desc_text" placeholder="내용"></textarea></div>
             	</form>
             </div> 
                                 
             <div class="modal-footer" style="margin-top:0;">
                 <button type="button" class="btn btn-sm" data-dismiss="modal">취소</button>
                 <button type="button" class="btn btn-sm" style="display:none">삭제</button>
                 <input type="button"  class="btn btn-sm pull-right" id="addEvent" value="확인">
             </div>
             
         
         </div>
         
     </div>
 </div> 
 <!-- ###############스케쥴 편집 모달 끝 ######################## -->
 <!-- ################## content list modal start####################--> 
 <div class="modal fade in" id="repositoryList" tabindex="-1" role="dialog" aria-hidden="false"> 
    <div class="modal-dialog" style="width:500px; margin-top: 10%;">
        <div class="modal-content"> 
            <div class="modal-header" style="overflow: hidden;">
                <h5 class="pull-left">저장소에서 가져오기</h5>
                <div class="pull-right">
                    <div class="col-md-4 p-r-20 m-t-5">
                        <select id="repoType" class="form-control input-sm">
                            <option value="VOD">VOD</option>
                            <option value="LIVE">LIVE</option>
                        </select>
                    </div>
                    <div class="col-md-8 p-0">                                        
                        <input type="text" class="main-search" style="border-bottom: 1px solid #fff; width: 100%;" placeholder="검색어를 입력하세요." />                               
                    </div>
                </div>
            </div>                           
            <div class="modal-body" style="text-align: center;">
               <div class="col-md-12">
                   <div class="col-md-4" style="width:26%;">
                   <!-- TREE START-->
					<div  id="video" style="position:relative; left:-25px;"></div>
					<!-- TREE END-->
          
                   </div>
                   
                   <div class="col-md-8" style="padding:0; left:35px;">
                       <div class="tile">
                           <div class="photo-gallery clearfix">
                               <div class="photo">
                                   <div class="form_div sm col-md-12" style="margin:0; padding:0;" id="repoListPage">
                                       <div class="img_box vodChange" style="background: url(img/20180413141747_0.jpg) no-repeat center; background-size: cover;">
                                        <input class="pull-left m-l-5" type="radio" />
                                       </div>
                                       <div class="img_box" style="background: url(img/20180413142808_0.jpg) no-repeat center; background-size: cover;">
                                        <input class="pull-left m-l-5" type="checkbox" />
                                       </div>
                                       
                                   </div>
                               </div>
                           </div>
                       </div>
                   </div>                        
               </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-sm cancel" data-dismiss="modal">취소</button>
                <button class="btn btn-sm pull-right" id="selectIdxArr">확인</button>
            </div>
        </div>
    </div>
</div><!-- //저장소 -->
            
  <!-- ################## content list modal end####################-->                             
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
		};
		var removeOverlap=function(array){
			var result = [];
		    $.each(array, function(index, element) {   // 배열의 원소수만큼 반복
		 		if ($.inArray(element, result) == -1) {  // result 에서 값을 찾는다.  //값이 없을경우(-1)
		            result.push(element);              // result 배열에 값을 넣는다.
		        }
		    });
		    return result;
		}
		return{
			formatZeroDate:formatZeroDate,
			isNotEmpty:isNotEmpty,
			runtimeToSecond:runtimeToSecond,
			setDate:setDate,
			removeOverlap
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

<script>
  $(function () {
      $(".slide a.add").click(function () {
          $(".get").css("display","block");
      });
      $("#getForm").click(function () {
          $("#popupGetForm").show();
      }); //저장소
      
      	
  })
</script>
