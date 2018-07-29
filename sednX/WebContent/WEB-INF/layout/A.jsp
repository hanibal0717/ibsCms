<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script src="${pageContext.request.contextPath}/ibsUserJs/DevBoxSlide.js"></script>
<c:choose>
	<c:when test="${empty lists }">
		데이타가 없습니다.
	</c:when>
	<c:otherwise>
	<c:forEach items="${lists}" var="list" varStatus="status">
		<c:if test="${status.index eq 0}">
			<c:set var="oneImg" value="${list.vod_repo}" />
		</c:if>
		<c:if test="${status.index eq 0}">
			<c:set var="onetitle" value="${list.vod_repo}" />
		</c:if>
		<c:if test="${status.index eq 0}">
			<c:set var="oneContent" value="${list.vod_repo}" />
		</c:if>
		<c:if test="${status.index eq 1}">
			<c:set var="twoImg" value="${list.vod_repo}" />
		</c:if>
		<c:if test="${status.index eq 2}">
			<c:set var="threeImg" value="${list.vod_repo}" />
		</c:if>
	</c:forEach>
<span class="gra"></span>
<span class="line"></span>
<div class="textForm">
	<div class="inner">
		<p class="title">${oneImg}</p>
		<p class="f19">Marionette, 2017</p>
		<p class="f20 mt-20">고등학교 여교사 ‘서린’은 책상에 놓인 커피를 마신 뒤<br/>취한 듯 잠든다.  다음날, ‘마스터’라는 정체불명의<br/>발신자가 보낸 한 통의 문자.</p>
		<button class="white f13 mt-60">바로가기</button>
	</div>
</div>
<div class="bxslider">
	<div class="bx-img">
		<img src="${oneImg}" alt="샘플 이미지1" />
	</div>
	<div class="bx-img">
		<img src="${twoImg}" alt="샘플 이미지2" />
	</div>
	<div class="bx-img">
		<img src="${threeImg}" alt="샘플 이미지3" />
	</div>
</div>
	</c:otherwise>
</c:choose>