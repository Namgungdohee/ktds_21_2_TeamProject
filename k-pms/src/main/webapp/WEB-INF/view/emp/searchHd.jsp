<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 검색 페이지</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function(){
		$(".grid > table > tbody > tr").click(function(){
			$(this).find(".radio_idx").prop("checked",true);
		});
		
		$("#cancel_btn").click(function(){
			window.close();	
		});
		
		$("#regist_btn").click(function(){
			var radiobox = $(".radio_idx:checked");
			if(radiobox.length == 0) {
				alert("직원을 선택하세요");
				return;
			}

			var emp = radiobox.closest("tr").data();
			opener.addHdEmpFn(emp);
		});
	});
</script>
</head>
<body>
	<div class="search-popup content">
		<h1>직원검색</h1>
		<form>
			<input type="hidden" name="depId" value="${depId}">
			<div class="search-group">
				<label for="">직원명</label>
				<input type="text" name="fNm" class="grow-1 mr-10" value="${fNm}"/>
				<button class="btn-search" id="search-btn">검색</button>
			</div>
		</form>
		<div class="grid">
			<div class="grid-count align-right">
						총 ${empList.size() > 0 ? empList.size() : 0}건
			</div>
			<table>
				<thead>
					<tr>
						<th></th>
						<th>이름</th>
						<th>성</th>
						<th>부서ID</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty empList}">
							<c:forEach items="${empList}" var="emp">
								<tr data-empid = "${emp.empId}"
									data-fnm = "${emp.fNm}"
									data-lnm = "${emp.lNm}"
									data-pstnnm = "${emp.pstn.pstnNm}"
									data-jobnm = "${emp.job.jobNm}"
									data-phn = "${emp.phn}"
									data-brthdy = "${emp.brthdy}"
									data-eml = "${emp.eml}"
									data-pstnprd = "${emp.pstnPrd}">
									<td>
										<input type="radio" name ="radio_idx" class="radio_idx" value="${emp.empId}" />
									</td>
									<td>${emp.fNm}</td>
									<td>${emp.lNm}</td>
									<td>${emp.depId} </td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="4">검색된 직원이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		<div class="align-right">
			<button id="cancel_btn" class="btn-delete">취소</button>
			<button id="regist_btn" class="btn-primary">등록</button>
		</div>
	</div>
</body>
</html>