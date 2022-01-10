<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<script>
	function changeActive(){
		let memberPw = $('#memberPw');
		
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
		let memberId = frm.memberId.value;
		let memberPw = frm.memberPw.value;
		
		if (nextStep) {
			swal('기다려 주세요!', '처리중입니다.', "info");
			return;
		}
		
		if(memberId.length < 1){
			sweetAlert('아이디 미입력','아이디를 입력해주세요','error', frm.memberId);
			frm.memberId.focus();
			return;
		} else if(memberPw.length < 1){
			sweetAlert('패스워드 미입력','패스워드를 입력해주세요','error', frm.memberPw);
			return;
		}
		
		nextStep = true;
		
		if ( nextStep ){
			
			var xhr = new XMLHttpRequest();
			
			xhr.open('POST', '/user/member/doLogin.do?ajax=true&memberId=' + memberId + "&memberPw=" + memberPw,true);
			xhr.responseType = 'json';
			
			xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
			
			xhr.send();
			
			xhr.onload = () => {
				if (xhr.status == 200){
					let result = xhr.response;
					let resultVal = result.result; 
					console.log(result);
					
					if ( resultVal.resultCode.includes("F-") ){
						sweetAlert(resultVal.alertTitle,resultVal.alertMsg,resultVal.alertIcon, frm.memberId);
						nextStep = false;	
					}	else if (resultVal.resultCode.includes("S-") ) {
						swal({
							title : resultVal.alertTitle,
							text : resultVal.alertMsg,
							icon : resultVal.alertIcon,
						}).then(function(){
							location.replace(resultVal.afterLoginURI);
						});
					} 
				} else {
					nextStep = false;
				}
			}
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
			<form action="javascript:checkLoginForm()" method="POST" id="loginForm">
				<input type="hidden" name="afterLoginURI" value="${afterLoginURI}" />
				
				<div class="box_input">
					<div class="box_input_input">
						<div class="id_input">
							<span>아이디</span>
							<input type="text" name="memberId" placeholder="아이디">
						</div>
						
						<div class="pw_input">
							<span>패스워드</span>
							<input class="" type="password" name="memberPw" id="memberPw" placeholder="패스워드">
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
						<button onclick="fn_pageMove('/user/member/join_policy.do?returnUrl=${requestURI}'); return false;" type="button">회원가입</button>
					</div>
					
					<div class="">
						<button type="button" onclick="movePage('/user/member/memberFindId.do?afterLoginURI=${param.afterLoginURI}'); return false;">ID/PW 찾기</button>
					</div>
				</section>
			</form>
		</div>
		
	</div>
</main>