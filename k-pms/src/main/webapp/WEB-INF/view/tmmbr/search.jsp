<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀원 검색</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		
		$("#a-btn").click(function() {
			location.href = "${context}/tm/search";
		});
		
		$("#search-btn").click(function() {
			location.href = "${context}/tm/search?tmNm=" + $("#searh-tmNm").val();
		});
		
		$("#all_check").change(function() {
			$(".check-idx").prop("checked", $(this).prop("checked"));
		});
		
		$(".check-idx").change(function() {
			var count = $(".check-idx").length;
			var checkCount = $(".check-idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		});
		
		$("#cancel-btn").click(function() {
			window.close();
		});
		
		$("#regist-btn").click(function() {
			var checkOne = $(".check-idx:checked");
			
			if (checkOne.length == 0) {
				alert("팀원을 선택하세요");
				return;
			}
			
			checkOne.each(function() {
				var each = $(this).closest("tr").data();
				console.log(each);
				opener.addTmMbrFn(each);
			});
			window.close();
		});
		
	});
</script>
</head>
<body>
	<div class="search-popup content">
		<h1>팀원 검색</h1>
			<div class="search-group">
				<label for="searh-tmNm">팀명</label>
				<input type="text" id="searh-tmNm" name="tmVO.tmNm" class="grow-1 mr-10" value="${tmNm}"/>
				<button class="btn-search" id="search-btn">검색</button>
			</div>
			<div>
				<h3>${tmNm}팀</h3>
			</div>
		<div class="grid">
			<div class="grid-count align-right">
						총 ${tmMbrList.size() > 0 ? tmMbrList.size() : 0}건
			</div>
			<table>
				<thead>
					<tr>
						<th><input type="checkbox" id="all_check" /></th>
						<th>직원ID</th>
						<th>성</th>
						<th>이름</th>
						<th>팀명</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty tmMbrList}">
							<c:forEach items="${tmMbrList}"
										var="tmmbr">
								<tr data-tmmbrid="${tmmbr.tmMbrId}"
									data-empid="${tmmbr.empId}"
									data-tmid="${tmmbr.tmId}"
									data-fnm="${tmmbr.empVO.fNm}"
									data-lnm="${tmmbr.empVO.lNm}"
									data-tmnm="${tmmbr.tmVO.tmNm}" >
									<td>
										<input type="checkbox" class="check-idx" value="${tmmbr.tmId}" />
									</td>
									<td>${tmmbr.empId}</td>
									<td>${tmmbr.empVO.fNm}</td>
									<td>${tmmbr.empVO.lNm}</td>
									<td>${tmmbr.tmVO.tmNm}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="5">검색된 팀원이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		<div class="align-right">
			<button id="regist-btn" class="btn-primary">등록</button>
			<button id="cancel-btn" class="btn-delete">취소</button>
		</div>
	</div>
</body>
</html>