<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<script>
	let nextStep = false;
	let isCertificationSuccess = false; 
	
	
	function chekcFindLoginPw(){
		let frm = document.getElementById('findPwForm');
		
		if(frm.memberName.value.length < 1){
			sweetAlert('성함 미입력','성함을 입력해주세요.','error',frm.memberName);
			return;
		} else if (frm.memberBirth.value.length < 1){
			sweetAlert('생년월일 미입력','생년월일을 입력해주세요.','error',frm.memberBirth);
			return;
		} else if(frm.memberPhoneNumber.value.length < 1){
			sweetAlert('휴대전화번호 미입력','전화번호를 입력해주세요.','error',frm.memberPhoneNumber);
			return;
		} else if(frm.memberEmail.value.length < 1){
			sweetAlert('이메일을 미입력','이메일을 입력해주세요.','error',frm.memberEmail);
			return;
		}
		
		let birthReg = /^\d{8}$/;
		let phoneNumberReg = /^\d{11}$/;
		
		if ( ! birthReg.test(frm.memberBirth.value.trim()) ){
			sweetAlert('생년월일 양식','생년월일의 양식이 일치하지 않습니다.  ex) 20200202', 'error', frm.memberBirth);
			return;
		} else if ( ! phoneNumberReg.test(frm.memberPhoneNumber.value.trim()) ){
			sweetAlert('전화번호 양식','전화번호 양식이 일치하지 않습니다.  ex) 01012345678', 'error', frm.memberPhoneNumber);
			return;
		}
		
		nextStep = true;
		
		if( nextStep ){
			let memberName = frm.memberName.value.trim();
			let memberBirth = frm.memberBirth.value.trim();
			let memberPhoneNumber = frm.memberPhoneNumber.value.trim();
			let memberEmail = frm.memberEmail.value.trim();
			
			var xhr = new XMLHttpRequest();
			
			xhr.open('POST', '/user/member/doFindPw.do?ajax=true&memberName=' + memberName + "&memberBirth=" + memberBirth + "&memberPhNum=" + memberPhoneNumber + "&memberEmail=" + memberEmail,true);
			
			xhr.responseType = 'json';
			
			xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
			
			xhr.send();
			
			xhr.onload = () => {
				if (xhr.status == 200){
					let resultVal = xhr.response;
					let result = resultVal.result;
					console.log(resultVal);
					console.log(result);
					if ( result.resultCode.includes("F-") ){
						sweetAlert(result.alertTitle, result.alertMsg, result.alertIcon, frm.memberName);
					} else if ( result.resultCode.includes("S-") ){
						sweetAlert(result.alertTitle, result.alertMsg, result.alertIcon, frm.certificationInput);
						
						setTimeout(function(){
							location.href="/user/member/login.do"
						},2500);
						
						
						var xhr2 = new XMLHttpRequest();
						
						xhr2.open('POST', '/user/email/emailCheck.do?ajax=true' + "&memberName=" + memberName + "&memberPhNum=" + memberPhoneNumber + "&memberBirth=" + memberBirth + "&memberEmail=" + memberEmail ,true);
						 
						xhr2.responseType = 'json';
						
						xhr2.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
						
						xhr2.send();
						
						xhr2.onload = () => {
							if (xhr.status == 200){
								
							}
						}
				} else{
					console.log("통신 실패");
					swal("전송 실패", "메일 전송에 실패하였습니다. 관리자에게 문의 해주세요", "error");
				}
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
							<span>성함</span>
							<input type="text" name="memberName" id="memberName" placeholder="성함">
						</div>
						
						<div class="birth_input">
							<span>생년월일</span>
							<input autocomplete="off" class="" type="text" name="memberBirth" placeholder="생년월일 예) 20200202">
						</div>
						
						<div class="phNum_input">
							<span>전화번호</span>
							<input class="" type="text" name="memberPhoneNumber" id="memberPhoneNumber" placeholder="휴대전화 번호">
						</div>
						
						<div class="email_input">
							<span>이메일</span>
							<input class="" type="email" name="memberEmail" id="memberEmail" placeholder="이메일">
						</div>
											
					</div>

					<div class="login_btn">
						<button type="submit" value="Submit">찾기</button>
					</div>
				</div>
				
				<section class="buttonBox">
					<div class="">
						<button onclick="fn_pageMove('/user/member/login.do?afterLoginURI=${param.afterLoginURI}'); return false;">로그인 페이지로</button>
					</div>
				</section>
			</form>
		</div>
	</div>
</main>