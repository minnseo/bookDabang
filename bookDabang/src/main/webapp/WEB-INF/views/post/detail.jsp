<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>서평 상세</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/post.fav.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/post.reply.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/post.report.js"></script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- 내용 시작 -->
	<div class="content-main">
	<h2>${post.post_title}</h2>
	<div class="align-right">
	<%-- 신고 --%>
	<!-- 신고 버튼 -->
	<button type="button" class="btn btn-primary" data-toggle="modal" data-target=".bd-example-modal-lg" id="modal">신고하기</button>
	<!-- 모달창 시작 -->
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  	<div class="modal-dialog modal-lg" role="document">
    	<div class="modal-content">
      	<div class="modal-header">
        	<h5 class="modal-title" id="exampleModalLabel">신고</h5>
        	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
          	<span aria-hidden="true">&times;</span>
        	</button>
      	</div>
      	<div class="modal-body">
        	<form style="border:none;" id="repo_submit" action="writeReport.do" method="post">
        	<input type="hidden" name="post_num" value="${post.post_num}">
               <div class="form-row">
                  <dl class="row">
                     <dd class="align-center"><b>신고하기</b></dd>
                        <dd class="col-12 col-sm-10 d-flex align-items-center">
                        <fieldset data-role="controlgroup">
                           <div class="form-check form-check-inline">
                               <input class="form-check-input" type="radio" name="repo_category" id="repo_category1" value="1">
                               <label class="form-check-label" for="inlineRadio1">욕설 및 비방</label>
                           </div>
                           <div class="form-check form-check-inline">
                               <input class="form-check-input" type="radio" name="repo_category" id="repo_category2" value="2">
                               <label class="form-check-label" for="inlineRadio2">홍보 및 영리 목적</label>
                           </div>
                           <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="repo_category" id="repo_category3" value="3">
                                <label class="form-check-label" for="inlineRadio3">불법 정보, 청소년 유해</label>
                           </div>
                           <div class="form-check form-check-inline">
                                 <input class="form-check-input" type="radio" name="repo_category" id="repo_category4" value="4">
                                 <label class="form-check-label" for="inlineRadio4">개인 정보 노출/유포/거래</label>
                           </div>
                           <div class="form-check form-check-inline">
                                 <input class="form-check-input" type="radio" name="repo_category" id="repo_category5" value="5">
                                 <label class="form-check-label" for="inlineRadio5">도배 및 스팸</label>
                           </div>
                           <div class="form-check form-check-inline">
                                 <input class="form-check-input" type="radio" name="repo_category" id="repo_category6" value="6">
                                 <label class="form-check-label" for="inlineRadio6">기타</label>
                           </div>
                           <div>
                           <textarea name="repo_content" id="repo_content" placeholder="*상세 사유를 입력하세요."></textarea>
                           </div>
                      </fieldset>
                     </dd>       
                  </dl>
               </div>  
                 <div class="modal-footer">
        	<button type="button" class="btn btn-secondary" data-dismiss="modal" id="modal_cancel" onclick="location.href='${pageContext.request.contextPath}/post/detail.do?post_num=${post.post_num}'">취소</button>
        	<input type="submit" id="report" class="btn btn-primary" value="등록">
      			</div>               
        	</form>
      	</div>

    	</div>
  	</div>
	</div>
	<!-- 모달창 끝 -->
	</div>
		<ul class="detail-info">
			<li>
				<c:if test="${!empty post.photo}">
				<img src="${pageContext.request.contextPath}/upload/${post.photo}" 
					 width="40" height="40" class="my-photo">
				</c:if>
				<c:if test="${empty post.photo}">
				<img src="${pageContext.request.contextPath}/images/face.png" 
					 width="40" height="40" class="my-photo">
				</c:if> 
			</li>
			<li>
				${post.name} | ${post.post_date}<br>
			</li>
		</ul>
		<hr size="1" noshade="noshade" width="100%">
		<c:if test="${!empty post.post_photo}">
		<div class="align-center">
			<img src="${pageContext.request.contextPath}/upload/${post.post_photo}" class="detail-img">
		</div>
		</c:if>
		<p>
			${post.post_content}
		</p>
		<hr size="1" noshade="noshade" width="100%">
		<ul class="detail-sub">
			<li>
				<%-- 좋아요 --%>
				<%-- html은 속성태그 추가X (예외)'data-' 형태로만 추가 가능--%>
				<img id="output_fav" data-num="${post.post_num}" src="${pageContext.request.contextPath}/images/fav01.gif" width="50">
				좋아요
				<span id="output_fcount"></span>
			</li>
			<li>
				<br>
				<%-- 로그인한 회원번호와 작성자 회원번호가 일치해야 수정/삭제 가능 --%>
				<c:if test="${user_num == post.mem_num}">
				<input type="button" value="수정" onclick="location.href='updateForm.do?post_num=${post.post_num}'">
				<input type="button" value="삭제" id="delete_btn">
				<script type="text/javascript">
				 let delete_btn = document.getElementById('delete_btn');
				 //이벤트 연결
				 delete_btn.onclick=function(){
					 let choice = confirm('삭제하시겠습니까?');
					 if(choice){
						 //히스토리를 지우면서 이동
						 location.replace('delete.do?post_num=${post.post_num}');
					 }
				 };
				</script>
				</c:if>
			</li>
		</ul>
		<br>
		<hr>
		<span>댓글</span>
	</div>
		<!-- 댓글 시작 -->
		<!-- 댓글 목록 출력 시작 -->
		<div id="output"></div>
		<div class="paging-button" style="display:none;">
			<input type="button" value="다음글 보기">
		</div>
		<div id="loading" style="display:none;">
			<img src="${pageContext.request.contextPath}/images/loading.gif" width="50" height="50">
		</div>
		<!-- 댓글 목록 출력 끝 -->
		<div id="reply_div">
			<span class="re-title">댓글 달기</span>
			<form id="re_form">
				<input type="hidden" name="post_num" value="${post.post_num}" id="post_num">
				<textarea rows="3" cols="50" name="re_content" id="re_content" class="rep-content"
				<c:if test="${empty user_num}">disabled="disabled"</c:if>
				><c:if test="${empty user_num}">로그인해야 작성할 수 있습니다.</c:if></textarea>
				<c:if test="${!empty user_num}"> <!-- 로그인 여부 체크 -->
				<div id="re_first">
					<span class="letter-count">300/300</span>
				</div>
				<div id="re_second" class="align-right">
					<input type="submit" value="전송">
				</div>
				</c:if>
			</form>
		</div>		
		<!-- 댓글 끝 -->
	<!-- 내용 끝 -->
</div>
</body>
</html>