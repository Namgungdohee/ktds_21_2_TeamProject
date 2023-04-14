<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}"/>

<div class="header bg-black">
	<ul class="nav">
		<li class="nav-item emp">
			<a href="${context}/emp/list">임직원관리</a>
			<ul class="sub-item">
				<li><a href="${context}/emp/create">임직원 등록</a></li>
				<li><a href="${context}/emp/list">임직원 목록</a></li>
				<li><a href="${context}/emp/lgn/hst">로그인 이력</a></li>
				<li><a href="${context}/emp/acs/log">화면 접근 이력</a></li>
				<li><a href="${context}/emp/pstn/log">직급 변경 이력</a></li>
				<li><a href="${context}/emp/job/log">직무 변경 이력</a></li>
				<li><a href="${context}/emp/dep/log">부서 변경 이력</a></li>
			</ul>
		</li>
		<li class="nav-item dep">
			<a href="${context}/dep/list">부서관리</a>
			<ul class="sub-item">
				<li><a href="${context}/dep/list">부서 목록</a></li>
				<li><a href="${context}/cmncd/list">부서원 관리</a></li>
				<li><a href="${context}/job/list">직무 관리</a></li>
				<li><a href="${context}/pstn">직급 관리</a></li>
			</ul>
		</li>
		<li class="nav-item eqp">
			<a href="${context}/eqp/list">비품관리</a>
			<ul class="sub-item">
				<li><a href="${context}/eqp/list">대여 관리</a></li>
				<li><a href="${context}/eqp/list">대여 신청 관리</a></li>
				<li><a href="${context}/eqp/list">변경 관리</a></li>
				<li><a href="${context}/eqp/list">분실물 관리</a></li>
			</ul>
		</li>
		<li class="nav-item prj">
			<a href="${context}/prj/list">프로젝트관리</a>
			<ul class="sub-item">
				<li><a href="${context}/prj/list">프로젝트 목록</a></li>
				<li><a href="${context}/issu/list">이슈</a></li>
				<li><a href="${context}/req/list">요구사항</a></li>
				<li><a href="${context}/knw/list">지식관리</a></li>
			</ul>
		</li>
		<li class="nav-item sys">
			<a>시스템관리</a>
			<ul class="sub-item">
				<li><a href="${context}/emp/admin/list">관리자 관리</a></li>
				<li><a href="${context}/cmncd/list">공통코드 관리</a></li>
				<li><a href="${context}/pstn/list">직급 관리</a></li>
				<li><a href="${context}/job/list">직무 관리</a></li>
			</ul>
		</li>
	</ul>
	<div class="inline profile">
		${sessionScope.__USER__.fNm} <a href="${context}/emp/lgt">(Logout)</a>
	</div>
</div>