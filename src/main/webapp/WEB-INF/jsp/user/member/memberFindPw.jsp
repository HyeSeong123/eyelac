<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script>
	let nextStep = false;
	function chekcFindLoginPw(){
		let frm = document.getElementById('findPwForm');
		
		if(frm.memberId.value.length < 1){
			alert('아이디를 입력해주세요.');
			return;
		} else if (frm.memberBirth.value.length < 1){
			alert('생년월일을 입력해주세요');
			return;
		} else if(frm.memberEmail.value.length < 1){
			alert('이메일을 입력해주세요.');
			return;
		}
		
		nextStep = true;
		
		if( nextStep ){
			let memberId = frm.memberId.value.trim();
			let memberBirth = frm.memberBirth.value.trim();
			let memberEmail = frm.memberEmail.value.trim();
			
			var xhr = new XMLHttpRequest();
			
			xhr.open('POST', '/member/doFindPw.do?ajax=true',true);
			
			xhr.responseType = 'json';
			
			xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
			
			xhr.send("memberId= " + memberId + "&memberBirth=" + memberBirth + "&memberEmail=" +memberEmail);
			
			xhr.onload = () => {
				if (xhr.status == 200){
					let result = xhr.response;
					let resultLength = result.resultCode.length;
					
					if ( result.resultCode.includes("F-") ){
						alert( result.resultCode.substr(4,resultLength-4) );
						document.getElementById('memberId').focus();
					} else if ( result.resultCode.includes("S-") ){
						
					}
					
				} else{
					console.log("통신 실패");
				}
			}
		}
	}
</script>

<main class="main">
	<div class="title_image">
		<div class="page_title">
			<h1>패스워드 찾기</h1>
		</div>
	</div>
	<div class="findPw_container">
		<div class="findPw_box">
			<form action="javascript:chekcFindLoginPw();" method="POST" id="findPwForm">
				<input type="hidden" name="afterLoginURI" value="${afterLoginURI}" />
				
				<div class="box_input">
					<div class="box_input_input">
						<div class="name_input">
							<span>아이디</span>
							<input required type="text" name="memberId" id="memberId" placeholder="아이디">
						</div>
						
						<div class="birth_input">
							<span>생년월일</span>
							<input autocomplete="off" class="" id="datepicker" required type="text" name="memberBirth" placeholder="생년월일">
						</div>
						
						<div class="email_input">
							<span>이메일</span>
							<input class="" required type="email" name="memberEmail" id="memberEmail" placeholder="이메일">
						</div>
					</div>
					
					<div class="login_btn">
						<button type="submit" value="Submit">찾기</button>
					</div>
				</div>
				
				<section class="buttonBox">
					<div class="">
						<button onclick="fn_pageMove('/member/login.do?afterLoginURI=${param.afterLoginURI}'); return false;">로그인</button>
					</div>
					
					<div class="">
						<button onclick="movePage('/member/memberFindPw.do'); return false;">아이디 찾기</button>
					</div>
				</section>
			</form>
		</div>
	</div>
</main>