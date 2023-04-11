<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		
		$(".grid > table > tbody > tr").click(function() {
			$("#isModify").val("true"); //수정모드
			
			var data = $(this).data();
			$("#depId").val(data.depid);
			$("#depNm").val(data.depnm);
			$("#depHdId").val(data.dephdid);
			$("#depCrtDt").val(data.depcrtdt);
			$("#crtr").val(data.crtr);
			$("#crtDt").val(data.crtdt);
			$("#mdfyDt").val(data.mdfydt);
			$("#mdfyr").val(data.mdfyr);
			$("#mdfyDt").val(data.mdfydt);
			
			$("#useYn").prop("checked", data.useyn == "Y");
			
		});
		
			$("#new_btn").click(function() {
			
			$("#isModify").val("false"); //등록모드
			
			$("#depId").val("");
			$("#depNm").val("");
			$("#depHdId").val("");
			$("#depCrtDt").val("");
			$("#crtr").val("");
			$("#crtDt").val("");
			$("#mdfyr").val("");
			$("#mdfyDt").val(0);
			
			$("#useYn").prop("checked", false);
		});
		
		$("#delete_btn").click(function() {
			var depId =$("#depId").val()
			if (depId == "") {
				alert("선택된 부서가 없습니다.");
				return;
			}
			
			if (!confirm("정말 삭제하시겠습니까?")) { <!-- 사용자에게 확인  확인시 예를 누르면 false값이 return으로 온다.-->
				return;
			}
			
			$.get("${context}/api/dep/delete/" + depId, function(response) {
				if (response.status == "200 OK") {
					location.reload(); //새로고침
				}
				else {
					alert(response.errorCode + " / " + response.message);
				}
			});
		})
		
		$("#save_btn").click(function() {
			if($("#isModify").val() == "false") {
				//신규등록
				$.post("${context}/api/dep/create", {depNm: $("#depNm").val(), useYn: $("#useYn:checked").val()}, function(response) {
					if (response.status == "200 OK") {
						location.reload(); //새로고침
					}
					else {
						alert(response.errorCode + " / " + response.message);
					}
				
				});
			}
			else {
				//수정
				$.post("${context}/api/dep/update", {depId: $("#depId").val(), depNm: $("#depNm").val(), useYn: $("#useYn:checked").val()}, function(response) {
					if (response.status == "200 OK") {
						location.reload(); //새로고침
					}
					else {
						alert(response.errorCode + " / " + response.message);
					}
				});
			}
		});
		
		$("#search-btn").click(function() {
			var depNm = $("#search-keyword").val();
			location.href = "${context}/dep?depNm=" + depNm;
			/* movePage(0) */
		});
		
		$("#all_check").change(function() {
		/* 	console.log($(this).prop("checked")); */
			$(".check_idx").prop("checked", $(this).prop("checked"));
		});
		
		$(".check_idx").change(function() {
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		});
		
		$("#delete_all_btn").click(function() {
			var checkLen = $(".check_idx:checked").length;
			if (checkLen == 0) {
				alert("삭제할 부서가 없습니다.");
				return;
			}
			
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function() {
				console.log($(this).val());
				form.append("<input type='hidden' name='depId' value='" + $(this).val() + "'>"); 
			});
			
			$.post("${context}/api/dep/delete", form.serialize(), function(response) {
				if (response.status == "200 OK") {
					location.reload(); //새로고침
				}
				else {
					alert(response.errorCode + " / " + response.message);
				}
			});
		});
		
		$("#addDepHeadBtn").click(function(event) {
			//event.preventDefault();
			var depHd = window.open("${context}/emp/search", "부서장 검색", "width=500,height=500");
		})
		
	});
		/* function movePage(pageNo) {
			// 전송
			// 입력 값
			var gnrNm = $("#search-keyword").val();
			// URL 요청
			location.href = "${context}/dep/list?depNm=" + depNm + "&pageNo=" + pageNo;
		} */
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/sidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
			
				<div class="path">부서 > 부서관리</div>
				<div class="search-group">
					<label for="search_keyword">부서명</label>
					<input type="text" id="search-keyword" class="search-input" value="${depVO.depNm}"/>
					
					<button class="btn-search" id="search-btn">검색</button>
				</div>
				<div class="grid">
					
					<div class="grid-count align-right">
						<%-- 총 ${depList.size() > 0 ? depList.get(0).totalCount : 0}건  --%>
					</div>
					<table>
						<thead>
							<tr>
								<th><input type="checkbox" id="all_check" /></th>
								<th>순번</th>
								<th>부서ID</th>
								<th>부서명</th>
								<th>부서장ID</th>
								<th>부서생성일</th>
								<th>사용여부</th>
								<th>등록자</th>
								<th>등록일</th>
								<th>수정자</th>
								<th>수정일</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty depList}">
									<c:forEach items="${depList}"
												var="dep">
										<tr data-depid="${dep.depId}"
											data-depnm="${dep.depNm}"
											data-dephdid="${dep.depHdId}"
											data-depcrtdt="${dep.depCrtDt}"
											data-useyn="${dep.useYn}"
											data-crtr="${dep.crtr}"
											data-crtdt="${dep.crtDt}"
											data-mdfyr="${dep.mdfyr}"
											data-mdfydt="${dep.mdfyDt}">
											<td>
												<input type="checkbox" class="check_idx" value="${dep.depId}"/>
											</td>
											<td>순번</td>
											<td>${dep.depId}</td>
											<td>${dep.depNm}</td>
											<td>${dep.depHdId}</td>
											<td>${dep.depCrtDt}</td>
											<td>${dep.useYn}</td>
											<td>${dep.crtr}</td>
											<td>${dep.crtDt}</td>
											<td>${dep.mdfyr}</td>
											<td>${dep.mdfyDt}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="10" class="no-items">
											등록된 부서가 없습니다.
										</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					
					<div class="align-right mt-10">
						<button id="delete_all_btn" class="btn-delete">삭제</button>
					</div>
					
					<<%-- div class="pagenate">
						<ul>
							<c:set value="${depList.size() > 0 ? depList.get(0).lastPage : 0}" var="lastPage" />
							<c:set value="${depList.size() > 0 ? depList.get(0).lastGroup : 0}" var="lastGroup" />
							
							<fmt:parseNumber var="nowGroup" value="${Math.floor(depVO.pageNo / 10)}" integerOnly="true" />
							<c:set value="${nowGroup * 10}" var="groupStartPageNo" />
							<c:set value="${groupStartPageNo + 10}" var="groupEndPageNo" />
							<c:set value="${groupEndPageNo > lastPage ? lastPage : groupEndPageNo-1}" var="groupEndPageNo" />
							
							<c:set value="${(nowGroup - 1) * 10}" var="prevGroupStartPageNo" />
							<c:set value="${(nowGroup + 1) * 10}" var="nextGroupStartPageNo" />
							
							<!--lastPage: ${lastPage}
							lastGroup: $lastGroup}
							nowGroup: ${nowGroup}
							groupStartPageNo: ${groupStartPageNo}
							groupEndPageNo: ${groupEndPageNo}
							prevGroupStartPageNo: ${prevGroupStartPageNo}
							nextGroupStartPageNo: ${nextGroupStartPageNo}  -->
							
							<c:if test="${nowGroup > 0}">
								<li><a href="javascript:movePage(0)">처음</a></li>
								<li><a href="javascript:movePage(${prevGroupStartPageNo})">이전</a></li>
							</c:if>
							
							<c:forEach begin="${groupStartPageNo}" end="${groupEndPageNo}" step="1" var="pageNo">
								<li><a class="${pageNo eq depVO.pageNo ? 'on' : ''}" href="javascript:movePage(${pageNo})">${pageNo+1}</a></li>
							</c:forEach>
							
							<c:if test="${lastGroup > nowGroup}">
								<li><a href="javascript:movePage(${nextGroupStartPageNo})">다음</a></li>
								<li><a href="javascript:movePage(${lastPage})">끝</a></li>
							</c:if>
							
						</ul>
					</div> --%>
					
				</div>
				
				<div class="grid-detail">
					<form id="detail_form">
						<!--
						isModify == true => 수정 (update)
						isModify == false => 등록 (insert)	
						-->
						<input type="hidden" id="isModify" value="false" />
						<div class="input-group inline">
							<label for="depId" style="width: 180px;">부서ID</label><input type="text" id="depId" name="depId" readonly value="" />
						</div>
						<div class="input-group inline">
							<label for="depNm" style="width: 180px;">부서명</label><input type="text" id="depNm" name="depNm" value=""/>
						</div>
						<div class="input-group inline">
							<label for="depHdId" style="width: 180px;">부서장ID</label>
							<div class="create-head">
								<button id="addDepHeadBtn" class="btn-p">등록</button>
							</div>
						</div>
						<div class="input-group inline">
							<label for="depCrtDt" style="width: 180px;">부서생성일</label><input type="text" id="depCrtDt" name="depCrtDt" disabled value="" />
						</div>
						<div class="input-group inline">
							<label for="useYn" style="width: 180px;">사용여부</label><input type="checkbox" id="useYn" name="useYn" value="Y"/>
						</div>
						<div class="input-group inline">
							<label for="crtr" style="width: 180px;">등록자</label><input type="text" id="crtr" disabled value=""/>
						</div>
						<div class="input-group inline">
							<label for="crtDt" style="width: 180px;">등록일</label><input type="text" id="crtDt" disabled value=""/>
						</div>
						<div class="input-group inline">
							<label for="mdfyr" style="width: 180px;">수정자</label><input type="text" id="mdfyr" disabled value=""/>
						</div>
						<div class="input-group inline">
							<label for="mdfyDt" style="width: 180px;">수정일</label><input type="text" id="mdfyDt" disabled value=""/>
						</div>
					</form>
				</div>
				<div class="align-right">
					<button id="new_btn" class="btn-primary">신규</button>
					<button id="save_btn" class="btn-primary">저장</button>
					<button id="delete_btn" class="btn-delete">삭제</button>
				</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>