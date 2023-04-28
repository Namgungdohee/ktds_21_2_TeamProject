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
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function(){
		$("#all_check").change(function(){
			$(".check_idx").prop("checked", $(this).prop("checked"));
		});
		
		$(".check_idx").change(function(){
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		});
		
		$("#cancel_btn").click(function(){
			window.close();	
		});
		
		$("#regist_btn").click(function(){
			var checkbox = $(".check_idx:checked");
			if(checkbox.length == 0) {
				alert("직급을 선택하세요");
				return;
			}
			checkbox.each(function(){
				var each = $(this).closest("tr").data();
				opener.addPstnFn(each);
			});
		});
	});
</script>
</head>
<body>
	<div class="search-popup content">
		<h1>직급검색</h1>
		<form>
			<div class="search-group">
				<label for="">직급명</label>
				<input type="text" name="pstnNm" class="grow-1 mr-10" value="${pstnNm}"/>
				<button class="btn-search" id="btn-search-btn">검색</button>
			</div>
		</form>
		<div class="grid">
			<div class="grid-count align-right">
						총 ${pstnList.size() > 0 ? pstnList.size() : 0}건
			</div>
			<table>
				<thead>
					<tr>
						<th>
							<input type="checkbox" id="all_check" />
						</th>
						<th>직급명</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty pstnList}">
							<c:forEach items="${pstnList}" var="pstn">
								<tr data-pstnid = "${pstn.pstnId}"
									data-pstnnm = "${pstn.pstnNm}"}>
									<td>
										<input type="checkbox" class="check_idx" value="${pstn.pstnId}" />
									</td>
									<td>${pstn.pstnNm}</td>
									<td>${pstn.crtDt}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="3">검색된 직급이 없습니다.</td>
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