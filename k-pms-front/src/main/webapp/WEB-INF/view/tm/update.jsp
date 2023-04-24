<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%=new Random().nextInt()%>" />
<c:set scope="request" var="selected" value="prj"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 수정</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">	
	
	var tmHd;
	var tmMbr;
	
	function addHdEmpFn(message) {
		
		var tmHdIdItems = $("#addTmHeadBtn").closest(".create-group").find(".items");
		if (tmHdIdItems.find("." + message.empid).length > 0) {
			alert(message.lnm + message.fnm + "은(는) 이미 추가된 팀장입니다.");
			return;
		}
			
		var itemDiv = tmHdIdItems.find(".head-item");
			
		var itemId = itemDiv.find("#tmHdId")
		itemId.val(message.empid);
		itemDiv.append(itemId);
			
		var itemSpan = itemDiv.find("span");
		itemSpan.text(message.lnm + message.fnm);
		itemDiv.append(itemSpan);
			
		$("#tmHdId").val(message.empid);
		$("#tmHdNm").text(message.lnm + message.fnm);
			
		tmHdIdItems.append(itemDiv);
			
		tmHd.close();
	}
	
	$().ready(function() {
		
		$("#addTmHeadBtn").click(function(event) {
			event.preventDefault(); 
			var depId = $("#depId").val();
			var tmHd = window.open("${context}/emp/search/head?depId=" + depId, "팀장 검색", "width=500,height=500");
		});
		
		$("#addTmMbrBtn").click(function(event) {
			event.preventDefault();
			var depId = $("#depId").val();
			tmMbr = window.open("${context}/emp/search?depId=" + depId, "팀원검색", "width=500, height=500")
		});
		
		$("#save-btn").click(function() {
			var tmId = $("#tmId").val();
			$.post("${context}/api/tm/update/" + tmId, $("#create_form").serialize(), function(response) {
				if (response.status == "200 OK") {
					location.href = "${context}" + response.redirectURL;
				}
				else {
					alert(response.errorCode + "/" + response.message);
				}
			});
		});
		
		
		$("#delete-btn").click(function() {
			var tmId = $("#tmId").val();
			if(!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			
			$.get("${context}/api/tm/delete/" + tmId, function(response) {
				if (response.status == "200 OK") {
					location.href = "${context}/tm/list"
				}
				else {
					alert(response.errorCode + "/" + response.message);
				}
			});
		});
	});
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/prjSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />		
				<div class="path"> 팀 수정</div>
				<form id="create_form" enctype="multipart/form-data">
					<div class="create-group">
						<label for="depId">부서ID</label>
						<input type="text" id="depId" name="depId" value="${tmVO.depIdDepVO.depId}" readonly/>
					</div>
					<div class="create-group">
						<label for="tmNm">팀명</label>
						<input type="text" id="tmNm" name="tmNm" value="${tmVO.tmNm}"/>
					</div>
					<div class="create-group">
						<label for="tmId">팀ID</label>
						<input type="text" id="tmId" name="tmId" value="${tmVO.tmId}" readonly/>
					</div>
						<div class="create-group">
							<label for="addTmHeadBtn" style="width: 180px;">팀장ID</label>
							<button id="addTmHeadBtn" class="btn-tm">등록</button>
							<div class="items">
								<div class='head-item'>
									<input type="text" id="tmHdId" name="tmHdId" readonly value="${tmVO.tmHdId}" />
									<span id="tmHdNm"></span>						
								</div>
							</div>
						</div>
					<div class="create-group">
						<label for="tmCrtDt">팀 생성일</label>
						<input type="date" id="tmCrtDt" name="tmCrtDt" value="${tmVO.tmCrtDt}"/>
					</div>
					<div class="create-group">
						<label for="useYn">사용여부</label>
						<input type="checkbox" id="useYn" name="useYn" value="Y" ${tmVO.useYn eq 'Y' ? 'checked' : ''}/>
					</div>
					
						<div class="create-group">
							<label for="tmMbr">팀원</label>
							<div>
								<button id="addTmMbrBtn" class="btn-primary">추가</button>
								<div class="items"></div>
							</div>
							<div class="grid">
								<table>
									<thead>
										<tr>
											<th>순번</th>
											<th>직원ID</th>
											<th>이름</th>
											<th>생년월일</th>
											<th>이메일</th>
											<th>전화번호</th>
											<th>직급연차</th>
										</tr>
									</thead>
									<tbody>
										<c:choose>
											<c:when test="${not empty tmVO.tmMbrList}">
												<c:forEach items="${tmVO.tmMbrList}" 
															var="tmMbr"
															varStatus="index">
													<tr>
														<td>${index.index + 1}</td>
														<td>${tmMbr.empId}</td>
														<td>${tmMbr.empVO.lNm}${tmMbr.empVO.fNm}</td>
														<td>${tmMbr.empVO.brthdy}</td>
														<td>${tmMbr.empVO.eml}</td>
														<td>${tmMbr.empVO.phn}</td>
														<td>${tmMbr.empVO.pstnPrd}</td>
													</tr>
												</c:forEach>
											</c:when>
										<c:otherwise>
											<td colspan="7" class="no-items">
												등록된 팀원이 없습니다.
											</td>
										</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
						</div>
					</form>	
				<div class="align-right">
					<button id="save-btn" class="btn-primary">저장</button>
					<button id="delete-btn" class="btn-delete">삭제</button>
				</div>
			<jsp:include page="../include/footer.jsp" />			
		</div>
	</div>
</body>
</html>