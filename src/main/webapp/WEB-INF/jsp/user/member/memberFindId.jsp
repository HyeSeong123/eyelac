<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<script>
	let nextStep = false;
	function chekcFindLoginId(){
		let frm = document.getElementById('findIdForm');
		
		if(frm.memberName.value.length < 1){
			alert('아이디를 입력해주세요.');
			return;
		} else if(frm.memberEmail.value.length < 1){
			alert('이메일을 입력해주세요.');
			return;
		}
		
		nextStep = true;
		
		if( nextStep ){
			let memberName = frm.memberName.value;
			let memberEmail = String(frm.memberEmail.value);
			
			var xhr = new XMLHttpRequest();
			
			xhr.open('POST', '/member/doFindId.do?ajax=true',true);
			
			xhr.responseType = 'json';
			
			xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
			
			xhr.send("memberName=" + memberName + "&memberEmail=" + memberEmail);
			
			xhr.onload = () => {
				if (xhr.status == 200){
					let result = xhr.response;
					let idOutput = document.querySelector('.id_output');
					
					let resultLength = result.resultCode.length;
					
					if ( result.resultCode.includes("F-") ){
						idOutput.innerHTML = '';
						idOutput.innerHTML = result.resultCode.substr(4,resultLength-4);
						idOutput.classList.remove('successMsg');
						idOutput.classList.add('active', 'errorMsg');
					} else if ( result.resultCode.includes("S-") ){
						idOutput.innerHTML = '';
						idOutput.innerHTML = result.resultCode.substr(4,resultLength-4);
						idOutput.classList.remove('errorMsg');
						idOutput.classList.add('active', 'successMsg');
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
			<h1>아이디 찾기</h1>
		</div>
	</div>
	<div class="findId_container">
		<div class="findId_box">
			<form action="javascript:chekcFindLoginId();" method="POST" id="findIdForm">
				<input type="hidden" name="afterLoginURI" value="${afterLoginURI}" />
				
				<div class="id_output"></div>
				
				<div class="box_input">
					<div class="box_input_input">
						<div class="name_input">
							<span>성명</span>
							<input required type="text" name="memberName" id="memberName" placeholder="성명">
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
						<button onclick="movePage('/member/memberFindPw.do'); return false;">패스워드 찾기</button>
					</div>
				</section>
			</form>
		</div>
	</div>
</main>