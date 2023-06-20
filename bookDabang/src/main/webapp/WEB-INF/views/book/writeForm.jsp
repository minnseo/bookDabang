<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">
<title>도서 등록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#write_form').submit(function(){
			if($('#title').val().trim()==''){
				alert('도서명을 입력하세요!');
				$('#name').val('').focus();
				return false;
			}
			if($('#author').val().trim()==''){
				alert('저자명을 입력하세요!');
				$('#author').val('').focus();
				return false;
			}
			if($('#publisher').val().trim()==''){
				alert('출판사를 입력하세요!');
				$('#publisher').val('').focus();
				return false;
			}
			if($('#price').val()==''){ 
				alert('가격을 입력하세요!');
				$('#price').focus();
				return false;
			}
			if($('#stock').val()==''){
				alert('재고를 입력하세요!');
				$('#stock').focus();
				return false;
			}
			if($('#thumbnail').val()==''){
				alert('썸네일 사진을 첨부하세요!');
				$('#thumbnail').focus();
				return false;
			}
			if($('#content').val().trim()==''){
				alert('내용을 입력하세요!');
				$('#content').val('').focus();
				return false;
			}
		});
	});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- 내용 시작 -->
	<div class="content-main">
		<h2>도서 등록</h2>
		<form action="write.do" method="post" encType="multipart/form-data" id="write_form">
			<ul>
				<li>
					<label for="title">도서명</label>
					<input type="text" name="title" id="title" maxlength="40">
				</li>
				<li>
					<label for="author">저자명</label>
					<input type="text" name="author" id="author" maxlength="20">
				</li>
				<li>
					<label for="publisher">출판사</label>
					<input type="text" name="publisher" id="publisher" maxlength="20">
				</li>
				<li>
					<label for="price">가격</label>
					<input type="number" name="price" id="price" min="1" max="99999999">
				</li>
				<li>
					<label for="stock">재고</label>
					<input type="number" name="stock" id="stock" min="0" max="9999">
				</li>
				<li>
					분류
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<select name="category" id="category">
						<option value="문학">문학</option>
						<option value="경제/경영">경제/경영</option>
						<option value="인문">인문</option>
						<option value="예술/대중문화">예술/대중문화</option>	
						<option value="사회/정치">사회/정치</option>
						<option value="자연과학">자연과학</option>
						<option value="자기계발">자기계발</option>
						<option value="IT모바일">IT모바일</option>
						<option value="유아/어린이">유아/어린이</option>
						<option value="만화">만화</option>
					</select>
				</li>
				<li>
					<label for="thumbnail">썸네일</label>
					<input type="file" name="thumbnail" id="thumbnail" accept="image/gif,image/png,image/jpeg">
					<img src="${pageContext.request.contextPath}/images/bk_no_image.png" width="200" id="show_thumbnail">
					<script type="text/javascript">
						$(function(){
							let new_thumbnail;
							$('#thumbnail').change(function(){
								new_thumbnail = this.files[0];
								//새 이미지를 선택 안 했을 경우 (선택하려다 취소)
								if(!new_thumbnail){ 
									$('#show_thumbnail').attr('src','${pageContext.request.contextPath}/images/bk_no_image.png');
									return;
								}
								//파일 용량이 지정한 범위를 넘을 경우
								if(new_thumbnail.size > 1024*1024){
									alert(Math.round(new_thumbnail.size/1024) + 'kbytes(1024kbytes까지만 업로드 가능)');
									$('#show_thumbnail').attr('src','${pageContext.request.contextPath}/images/bk_no_image.png');
									$(this).val(''); //선택한 파일 정보 지우기
									return;
								}
								//이미지 읽기
								let reader = new FileReader();
								reader.readAsDataURL(new_thumbnail);
								reader.onload=function(){
									$('#show_thumbnail').attr('src',reader.result);
								};
							});//end of change
						});
					</script>
				</li>
				<li>
					<label for="content">내용</label>
					<textarea rows="5" cols="30" name="content" id="content"></textarea>
				</li>
			</ul>
			<div class="align-center">
				<input type="submit" value="등록">
				<input type="button" value="목록" onclick="location.href='list.do'">
			</div>
		</form>
	</div>
	<!-- 내용 끝 -->
</div>
</body>
</html>