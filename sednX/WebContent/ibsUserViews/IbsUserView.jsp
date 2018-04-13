<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
	<meta name="format-detection" content="telephone=no">
	<meta charset="UTF-8">
	<meta http-equiv="Cache-Control" content="no-cache" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="X-UA-Compatible" content="ie=10">

<title>SEDN</title>
<link rel="stylesheet" type="text/css"	href="${pageContext.request.contextPath}/ibsUserCss/common.css">
<%-- <link rel="stylesheet" type="text/css"	href="${pageContext.request.contextPath}/ibsUserCss/menu.css"> --%>
<link rel="stylesheet" type="text/css"	href="${pageContext.request.contextPath}/ibsUserCss/jquery.bxslider.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/ibsUserCss/jquery.mCustomScrollbar.css" />
<link href="${pageContext.request.contextPath}/ibsCmsCss/video-js.css" rel="stylesheet">

<script type="text/javascript"	src="${pageContext.request.contextPath}/ibsUserJs/common/jquery-2.2.1.js"></script>
<script type="text/javascript"	src="${pageContext.request.contextPath}/ibsUserJs/common/jquery-ui.js"></script>
<script type="text/javascript"	src="${pageContext.request.contextPath}/ibsUserJs/common/jquery.bxslider.min.js"></script>
<script type="text/javascript"	src="${pageContext.request.contextPath}/ibsUserJs/common/jquery.mCustomScrollbar.concat.min.js"></script>
<script type="text/javascript"	src="${pageContext.request.contextPath}/ibsUserJs/common/jquery.cycle2.js"></script>
<script type="text/javascript"	src="${pageContext.request.contextPath}/ibsUserJs/ibsUser/ibsUserView.js"></script>
<script type="text/javascript"	src="${pageContext.request.contextPath}/ibsUserJs/common/common.js"></script> 
<script src="${pageContext.request.contextPath}/ibsCmsJs/video.js"></script>
<script src="${pageContext.request.contextPath}/ibsCmsJs/videojs-flash.js"></script>
<script src="${pageContext.request.contextPath}/ibsCmsJs/videojs-contrib-hls.js"></script>


</head>
<body>

	<div id="page">
		<div class="top"></div>
		<div class="contents">
			<div class="bxslider"></div>
			<div class="slider_container"></div>
		</div>
		
	</div>
	
	<input type ="hidden" id = "request" value="${pageContext.request.contextPath}"></input>
</body>
</html> 