<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript"	src="${pageContext.request.contextPath}/ibsUserJs/ibsUser/ibsUserPlayView_1.0.01.js"></script>
<script type="text/javascript"	src="${pageContext.request.contextPath}/ibsUserJs/common/UserCommon/ibsUserCommon_1.0.01.js"></script>

<div class="modal" id="modal_01">
	<div class="button"	style="display: block; position: absolute; top: 0px; left: 0px; z-index: 3">
		<button type="button" class="modal_close">
			<img src="${pageContext.request.contextPath}/ibsUserImg/modal_prev.png"	alt="닫기"/>
		</button>
	</div>

	<div class="vod_play" id="vod_play"	style="display: block; position: absolute; top: 0px; left: 0px; z-index: 2"></div>

	<div class="contents" style="display: block; position: absolute; top: 0px; left: 0px; z-index: 1">
		<div class="slider_container" id="slider_container"></div>
	</div>
</div> 


<script>
$(document).ready(function() {
	UserVodPlayApp.start("${IDX}");
});
</script> 