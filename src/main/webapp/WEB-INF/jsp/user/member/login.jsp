<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<script>
	function changeActive(){
		let memberPw = $('#memberPw')
		
		memberPw.toggleClass('active');
		
		if( memberPw.hasClass('active') ){
			memberPw.attr('type' , 'text');
			$('.open_password').html('<i class=\"far fa-eye-slash\"></i>');
		} else {
			memberPw.attr('type', 'password');
			$('.open_password').html('<i class=\"far fa-eye\"></i>');
			
		}
	}
	let nextStep = false;
	function checkLoginForm(){
		let frm = document.getElementById('loginForm');
		
		if (nextStep) {
			alert('처리중입니다.');
			return;
		}
		
		if(frm.memberId.value.length < 1){
			alert('아이디를 입력해주세요.');
			return;
		} else if(frm.memberPw.value.length < 1){
			alert('패스워드를 입력해주세요.');
			return;
		}
		
		nextStep = true;
		
		if ( nextStep ){
			frm.action = "/user/member/doLogin.do";
			frm.method = "POST";
			frm.submit();
		}
	}
</script>

<main class="main">
	<div class="title_image">
		<div class="page_title">
			<h1>로그인</h1>
		</div>
	</div>
	<div class="login_container">
		<div class="login_box">
			<form action="/user/member/doLogin.do" method="POST" id="loginForm">
				<input type="hidden" name="afterLoginURI" value="${afterLoginURI}" />
				
				<div class="box_input">
					<div class="box_input_input">
						<div class="id_input">
							<span>아이디</span>
							<input required type="text" name="memberId" placeholder="아이디">
						</div>
						
						<div class="pw_input">
							<span>패스워드</span>
							<input class="" required type="password" name="memberPw" id="memberPw" placeholder="패스워드">
							<span class="open_password" style="cursor:pointer" onclick="changeActive();"><i class="far fa-eye"></i></span>
						</div>
					</div>
					
					<div class="login_btn">
						<button type="submit" value="Submit">로그인</button>
					</div>
				</div>
				
				<section class="buttonBox">
				
					<div class="">
						<input type="checkbox" name="remember" id="remember">
						<label for="remember">아이디 저장</label>
					</div>
					
					<div class="">
						<button onclick="fn_pageMove('/user/member/join_policy.do?returnUrl=${requestURI}'); return false;">회원가입</button>
					</div>
					
					<div class="">
						<button onclick="movePage('/user/member/memberFindId.do?afterLoginURI=${param.afterLoginURI}'); return false;">ID/PW 찾기</button>
					</div>
				</section>
			</form>
		</div>
		
	</div>
</main>