<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
 
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 
<script>
	function changeActive(){
		let eye = event.target;
		
		if ( eye.className == "open_password"){
			eye = event.target.firstChild;
		}
		let memberPw = event.target.parentNode.previousElementSibling;
		
		memberPw.classList.toggle('active');
		
		
		if( memberPw.classList.contains('active') ){
			memberPw.setAttribute('type' , 'text');
			eye.classList.remove('far' , 'fa-eye');
			eye.classList.add('far', 'fa-eye-slash');
		} else {
			memberPw.setAttribute('type', 'password');
			eye.classList.remove('far', 'fa-eye-slash');
			eye.classList.add('class', 'far' , 'fa-eye');
			
		}
	}
	
	let nextStep = false;
	let dup_check = false;
	function joinCheck(){
		let frm = document.getElementById('join_form');
		
		if ( nextStep ){
			alert('처리중입니다.');
			return;
		}
		
		let isGenderCheck = false;
		let man = document.getElementById("man");
		let woman = document.getElementById("woman");
		
		if( man.checked || woman.checked ){
			isGenderCheck = true;
		} 
		
		let memberName = document.getElementById("memberName");
		let memberPhoneNumber = document.getElementById("memberPhoneNumber");
		let memberPw = document.getElementById("memberPw");
		let memberPwConfirm = document.getElementById("memberPwConfirm");
		let birth = document.getElementById("memberBirth")
		let area1 = document.querySelector('.area1');
		let area2 = document.querySelector('.area2');
		let area3 = document.querySelector('.area3');
		
		let nameReg = /^[가-힣]{2,13}$/;
		let phoneNumberReg = /^\d{3}\d{4}\d{4}$/;
		let birthReg = /^([0-9]{4})-\d([0-9]{2})-\d([0-9]{2})$/;
		
// 		if( ! nameReg.test(memberName.value.trim()) ) {
// 			sweetAlert('이름 입력 오류', '이름을 두 글자 이상 13글자 이하로 입력해주세요' ,"error", memberName);
// 			return;
// 		} else if ( isGenderCheck == false ){
// 			swal('성별 체크', '성별을 체크해주세요.', 'error');
// 			return;
// 		} else if( ! phoneNumberReg.test(memberPhoneNumber.value.trim()) ) {
// 			sweetAlert('전화번호 입력 오류', '휴대전화 번호 양식을 지켜주세요.(- 제외)', "error", memberPhoneNumber);
// 			return;
// 		} else if( memberPw.value.trim().length < 3 ) {
// 			sweetAlert('패스워드 에러', '비밀번호를 4글자 이상으로 입력해주세요.', 'error', memberPw);
// 			return;
// 		} else if ( memberPw.value != memberPwConfirm.value ){
// 			sweetAlert('비밀번호 불일치','비밀번호와 비밀번호확인이 일치하지 않습니다', 'error', memberPwConfirm);
// 		} else if( ! birthReg.test(memberBirth.value.trim()) ) {
// 			sweetAlert('생년월일 양식','생일의 양식을 맞춰서 입력 해주세요', 'error', memberBirth);
// 			return;
// 		} else if ( area1.value == null || area1.value == "null"){
// 			sweetAlert('주소 미입력','주소를 입력해주세요.', 'error', area1);
// 			return;
// 		} else if ( area2.value == null || area2.value == "null"){
// 			sweetAlert('주소 미입력','주소를 입력해주세요.', 'error', area2);
// 			return;
// 		} else if ( area3.value == null || area3.value == "null"){
// 			sweetAlert('주소 미입력','주소를 입력해주세요.', 'error', area3);
// 			return;
// 		}
		
		nextStep = true;
		
		if(nextStep){
			$.ajax({
				type : "POST",
				data : $('#join_form').serialize() ,
				url : "/user/member/doJoin.do?",
				dataType : "json",
				success : function (resultVal){
					let result = resultVal.result;
					
					if ( result.resultCode.includes("F-") ){
						swal(result.alertTitle,result.alertMsg, result.alertIcon);
						nextStep = false;
					} else if ( result.resultCode.includes("S-") ){
						swal(result.alertTitle,result.alertMsg, result.alertIcon)
						.then(function(){
							location.replace(resultVal.redirectURI);	
						})
					}
					
				}
			});
		}
	}
	function selectArea(){
		
		let area1 = document.querySelector('.area1').value;
		
		var xhr = new XMLHttpRequest();
		
		xhr.open('POST', '/user/area/getSiGunGu.do?ajax=true',true);
		
		xhr.responseType = 'json';
		
		xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
		
		xhr.send("area1=" + area1);
		
		xhr.onload = () => {
			if (xhr.status == 200){
				let resultVal = xhr.response;
				
				result = resultVal.result;
				
				let areaList = [];
				
				result.forEach((area) => {
					areaList.push([area.area2]);
				})
				
				let selectList = document.querySelector(".area2");
				let selectList2 = document.querySelector(".area3");
				
				selectList.options.length = 1;
				selectList2.options.length = 1;
				
				for (var i = 0; i < areaList.length; i++) {
				    let option = document.createElement("option");
				    if ( areaList[i] != "" ){
					    option.value = areaList[i];
					    option.text = areaList[i];
					    selectList.appendChild(option);
				    }
				  }
			} else {
				console.log("통신실패");
			}
		}
	}
function selectArea2(){
		
		let area1 = document.querySelector('.area1').value;
		let area2 = document.querySelector('.area2').value;
		
		var xhr = new XMLHttpRequest();
		
		xhr.open('POST', '/user/area/getDetailArea.do?ajax=true',true);
		
		xhr.responseType = 'json';
		
		xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
		
		xhr.send("area1=" + area1 + "&area2=" + area2);
		
		xhr.onload = () => {
			if (xhr.status == 200){
				let resultVal = xhr.response;
				
				result = resultVal.result;
				
				let areaList = [];
				
				result.forEach((area) => {
					areaList.push([area.area3]);
				})
				
				let selectList = document.querySelector(".area3");
				
				selectList.options.length = 1;
				
				for (var i = 0; i < areaList.length; i++) {
				    let option = document.createElement("option");
				    if ( areaList[i] != "" ){
					    option.value = areaList[i];
					    option.text = areaList[i];
					    selectList.appendChild(option);
				    }
				  }
			} else {
				console.log("통신실패");
			}
		}
	}
</script>

<main class="join_page">
	<div class="title_image" style="height:455px;">
		<div class="page_title">
			<h1>회원가입</h1>
		</div>
	</div>
	
	<div class="join_container">
		<div class="policy_title">
			<div>회원가입</div>
		</div>
		
		<form class="join_form" id="join_form" method="POST" action="javascript:joinCheck();">
			<table class="join_table">
				<tbody>
					<tr>
						<th><span>성명</span></th>
						<td><input type="text" name="memberName" id="memberName"></td>
						<td class="memberGender">
							<span>
								<input type="radio" id="man" name="gender" value="man"><label for="man">남</label>
							</span>
							
							<span>
								<input type="radio" id="woman" name="gender" value="woman"><label for="woman">여</label>
							</span>
						</td>
					</tr>
					<tr>
						<th><span>휴대폰<div class="mobile_display_block"></div>번호</span></th>
						<td><input type="tel" name="memberPhoneNumber" id="memberPhoneNumber"></td>
						<td><input type="checkbox" name="SMSAgree" id="SMS_agree" <c:if test="${SMSAgree eq 'on'}">checked</c:if> value="Y"> <label for="SMS_agree">SMS 알림 문자 수신동의</label></td>
					</tr>
					<tr>
						<th><span>비밀번호</span></th>
						<td>
							<input type="password" name="memberPw" id="memberPw">
							<span class="open_password" style="cursor:pointer" onclick="changeActive();"><i class="far fa-eye"></i></span>
						</td>
						<td>
							<span>영문 4글자 이상</span>
							<span id="inputPwSpanMsg"></span>
						</td>
					</tr>
					<tr>
						<th><span>비밀번호<div class="mobile_display_block"></div>확인</span></th>
						<td>
							<input type="password" name="memberPwConfirm" id="memberPwConfirm">
							<span class="open_password" style="cursor:pointer" onclick="changeActive();"><i class="far fa-eye"></i></span>
						</td>
						<td id="pwConfirm_txt"><span id="inputPwConfirmSpanMsg"></span></td>
					</tr>
					<tr>
						<th><span>생년월일</span></th>
						<td><input type="text" name="memberBirth" id="memberBirth"></td>
						<td><span>ex) 2000-01-01 양식으로 입력해주십시오.</span></td>
					</tr>
					<tr>
						<th><span>주소</span></th>
						<td class="join_address_td">
							<div class="join_address">
								<select name="area1" onChange="selectArea();" class="area1">
								  <option value='null'> - 지역 선택 -</option>
								  <option value='서울특별시'>서울</option>
								  <option value='부산광역시'>부산</option>
								  <option value='대구광역시'>대구</option>
								  <option value='인천광역시'>인천</option>
								  <option value='광주광역시'>광주</option>
								  <option value='대전광역시'>대전</option>
								  <option value='울산광역시'>울산</option>
								  <option value='세종특별자치시'>세종</option>
								  <option value='경기도'>경기</option>
								  <option value='강원도'>강원</option>
								  <option value='충청북도'>충북</option>
								  <option value='충청남도'>충남</option>
								  <option value='전라북도' >전북</option>
								  <option value='전라남도'>전남</option>
								  <option value='경상북도'>경북</option>
								  <option value='경상남도'>경남</option>
								  <option value='제주특별자치도'>제주</option>
								</select>
								
								<select name="area2" onChange="selectArea2();" class="area2">
								  <option value='null'>- 시/군/구 선택 -</option>
								</select>
								
								<select name="area3" class="area3">
								  <option value='null'>- 읍/내/동 선택 -</option>
								</select>
							</div>
							
						</td>
						<td></td>
					</tr>
				</tbody>
			</table>
			
			<div class="buttonBox">
				<div class="btn_join"><button>회원가입</button></div>
				<div class="btn_return"><button type="button" onclick="movePage('/user/member/join_policy.do')">취소</button></div>
			</div>
		</form>
	</div>
</main>

<script>
	$('#memberPhoneNumber').on("change paste", function() {
		let phoneNumber = $('#memberPhoneNumber');
		phoneNumber.val( phoneNumber.val().replaceAll("-",""));
		setTimeout(function(){
			if( phoneNumber.val().length > 11 ){
				phoneNumber.val( phoneNumber.val().substring(0,11) );
				swal('휴대전화 양식','휴대전화 번호 양식을 지켜주세요(- 제외)', 'error');
				phoneNumber.focus();
			}
		},250);
	})
	
	let pwConfirm = document.getElementById('memberPwConfirm');
	let pw = document.getElementById('memberPw');
	
	pw.addEventListener('keyup', e => {
		let inputError = document.getElementById('inputPwSpanMsg');
		setTimeout(function(){
			if ( pw.value.trim().length < 4){
				inputError.className = 'errorMsg';
				inputError.innerHTML = '4글자 이상 입력해주세요.';
			} else {
				inputError.className.remove = 'errorMsg';
				inputError.innerHTML = '';
			}
		},250);
	})
	
	pwConfirm.addEventListener('keyup', e => {
		setTimeout(function(){
			
			if ( pw.value.trim() != pwConfirm.value.trim() ){
				let pwConfirmSpan = document.getElementById('pwConfirm_txt');
				
				let inputError = document.getElementById('inputPwConfirmSpanMsg');
				
				inputError.className = 'errorMsg';
				
				inputError.innerHTML = '비밀번호와 일치하지 않습니다.';
				
			} else if (pw.value.trim() == pwConfirm.value.trim() ){
				let pwConfirmSpan = document.getElementById('pwConfirm_txt');
				
				let inputError = document.getElementById('inputPwConfirmSpanMsg');
				inputError.className.remove = 'errorMsg';
				inputError.className = 'successMsg';
				
				inputError.innerHTML = '비밀번호와 일치합니다.';
			}
		},250);
	})
		
</script>