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
		
		let nameReg = /^[가-힣]{2,13}$/;
		let phoneNumberReg = /^\d{3}\d{4}\d{4}$/;
		let birthReg = /^([0-9]{4})-?([0-9]{2})-?([0-9]{2})$/;
		
		if( ! nameReg.test(memberName.value.trim()) ) {
			sweetAlert('이름 입력 오류', '이름을 두 글자 이상 13글자 이하로 입력해주세요' ,"error", memberName);
			return;
		} else if ( isGenderCheck == false ){
			swal('성별 체크', '성별을 체크해주세요.', 'error');
			return;
		} else if( ! phoneNumberReg.test(memberPhoneNumber.value.trim()) ) {
			sweetAlert('전화번호 입력 오류', '휴대전화 번호 양식을 지켜주세요.(- 제외)', "error", memberPhoneNumber);
			return;
		} else if( memberPw.value.trim().length < 3 ) {
			sweetAlert('패스워드 에러', '비밀번호를 4글자 이상으로 입력해주세요.', 'error', memberPw);
			return;
		} else if ( memberPw.value != memberPwConfirm.value ){
			sweetAlert('비밀번호 불일치','비밀번호와 비밀번호확인이 일치하지 않습니다', 'error', memberPwConfirm);
		} else if( ! birthReg.test(memberBirth.value.trim()) ) {
			sweetAlert('생년월일 양식','생일의 양식을 맞춰서 입력 해주세요', 'error', memberBirth);
			return;
		}
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
		let areaSeoul = ['종로구', '중구', '용산구', '성동구', '광진구', '동대문구', '중랑구', '성북구',
						'강북구', '도봉구', '노원구', '은평구', '서대문구', '마포구', '양천구', '강서구',
						'구로구', '금천구', '영등포구', '동작구', '관악구', '서초구', '강남구', '송파구', '강동구'];
		
		let areaBusan = ['중구', '서구', '동구', '영도구', '부산진구', '동래구', '남구', '북구', '해운대구', '사하구', '금정구', '강서구',
						 '연제구', '수영구', '사상구', '기장군'];
		
		let areaIncheon = ['동구', '중구', '미추홀구', '연수구', '남동구', '부평구', '계양구', '서구', '광화군', '옹진군'];
		
		let areaGwangju = ['동구', '서구', '남구', '북구', '광산구'];
		
		let areaDaejeon = ['동구', '중구', '서구', '유성구', '대덕구'];
		
		let areaUlsan = ['중구', '남구', '동구', '북구', '울주군'];
		
		let areaSejong = ['세종특별자치시'];
		
		let areaGyeonggi = ['수원시', '성남시', '고양시', '용인시', '부천시', '안산시', '안양시', '남양주시', '화성시', '평택시', '의정부시', '시흥시', '파주시', '광명시',
							'김포시', '군포시', '광주시', '이천시', '양주시', '오산시', '구리시', '안성시', '포천시', '의왕시', '하남시', '여주시', '양평군', '동두천시',
							'과천시', '가평군', '연천군'];
		
		let areaGangwon = ['춘천시', '원주시', '강릉시', '동해시', '태백시', '속초시', '삼척시', '홍천군', '횡성군', '영월군', '평창군', '정선군', '철원군', '화천군',
						   '양구군', '인제군', '고성군', '양양군'];
		
		let areaChungbuk = ['청주시', '충주시', '제천시', '보은군', '옥천군', '영동군', '진천군', '괴산군', '음성군', '단양군', '증평군'];
		
		let areaChungnam = ['천안시', '공주시', '보령시', '아산시', '서산시', '논산시', '계룡시', '당진시', '금산군', '부여군', '서천군', '청양군', '홍성군', '예산군', '태안군'];
		
		let selectList = document.querySelector('.area2');
		selectList.options.length = 1;
		let area1 = document.querySelector('.area1').value;
		viewArea(area1);
		
		function viewArea(area){
			if ( area == "서울"){
				for ( var i = 0; i < areaSeoul.length; i ++ ){
					let option = document.createElement("option");
					option.value = areaSeoul[i];
					option.text = areaSeoul[i];
					selectList.appendChild(option);
				}
			}
			else if ( area == "부산"){
				for ( var i = 0; i < areaBusan.length; i ++ ){
					let option = document.createElement("option");
					option.value = areaBusan[i];
					option.text = areaBusan[i];
					selectList.appendChild(option);
				}
			}
			else if ( area == "인천"){
				for ( var i = 0; i < areaIncheon.length; i ++ ){
					let option = document.createElement("option");
					option.value = areaIncheon[i];
					option.text = areaIncheon[i];
					selectList.appendChild(option);
				}
			}
			else if ( area == "광주"){
				for ( var i = 0; i < areaGwangju.length; i ++ ){
					let option = document.createElement("option");
					option.value = areaGwangju[i];
					option.text = areaGwangju[i];
					selectList.appendChild(option);
				}
			}
			else if ( area == "대전"){
				for ( var i = 0; i < areaDaejeon.length; i ++ ){
					let option = document.createElement("option");
					option.value = areaDaejeon[i];
					option.text = areaDaejeon[i];
					selectList.appendChild(option);
				}
			}
			else if ( area == "울산"){
				for ( var i = 0; i < areaUlsan.length; i ++ ){
					let option = document.createElement("option");
					option.value = areaUlsan[i];
					option.text = areaUlsan[i];
					selectList.appendChild(option);
				}
			}
			else if ( area == "세종"){
				for ( var i = 0; i < areaSejong.length; i ++ ){
					let option = document.createElement("option");
					option.value = areaSejong[i];
					option.text = areaSejong[i];
					selectList.appendChild(option);
				}
			}
			else if ( area == "경기"){
				for ( var i = 0; i < areaGyeonggi.length; i ++ ){
					let option = document.createElement("option");
					option.value = areaGyeonggi[i];
					option.text = areaGyeonggi[i];
					selectList.appendChild(option);
				}
			}
			else if ( area == "강원"){
				for ( var i = 0; i < areaGangwon.length; i ++ ){
					let option = document.createElement("option");
					option.value = areaGangwon[i];
					option.text = areaGangwon[i];
					selectList.appendChild(option);
				}
			}
			else if ( area == "충북"){
				for ( var i = 0; i < areaChungbuk.length; i ++ ){
					let option = document.createElement("option");
					option.value = areaChungbuk[i];
					option.text = areaChungbuk[i];
					selectList.appendChild(option);
				}
			}
			else if ( area == "충남"){
				for ( var i = 0; i < areaChungnam.length; i ++ ){
					let option = document.createElement("option");
					option.value = areaChungnam[i];
					option.text = areaChungnam[i];
					selectList.appendChild(option);
				}
			}
			else if ( area == "전북"){
				for ( var i = 0; i < areaJeonbuk.length; i ++ ){
					let option = document.createElement("option");
					option.value = areaJeonbuk[i];
					option.text = areaJeonbuk[i];
					selectList.appendChild(option);
				}
			}
			else if ( area == "전남"){
				for ( var i = 0; i < areaJeonnam.length; i ++ ){
					let option = document.createElement("option");
					option.value = areaJeonnam[i];
					option.text = areaJeonnam[i];
					selectList.appendChild(option);
				}
			}
			else if ( area == "경북"){
				for ( var i = 0; i < areaGyeongbuk.length; i ++ ){
					let option = document.createElement("option");
					option.value = areaGyeongbuk[i];
					option.text = areaGyeongbuk[i];
					selectList.appendChild(option);
				}
			}
			else if ( area == "경남"){
				for ( var i = 0; i < areaGyeongnam.length; i ++ ){
					let option = document.createElement("option");
					option.value = areaGyeongnam[i];
					option.text = areaGyeongnam[i];
					selectList.appendChild(option);
				}
			}
			else if ( area == "제주"){
				for ( var i = 0; i < areaJeju.length; i ++ ){
					let option = document.createElement("option");
					option.value = areaJeju[i];
					option.text = areaJeju[i];
					selectList.appendChild(option);
				}
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
						<td><span>영문 및 숫자 특수문자<div class="mobile_display_block"></div>(6~17)</span></td>
					</tr>
					<tr>
						<th><span>비밀번호<div class="mobile_display_block"></div>확인</span></th>
						<td>
							<input type="password" name="memberPwConfirm" id="memberPwConfirm">
							<span class="open_password" style="cursor:pointer" onclick="changeActive();"><i class="far fa-eye"></i></span>
						</td>
						<td id="pwConfirm_txt"><span id="inputSpanMsg"></span></td>
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
								  <option>-선택-</option>
								  <option value='서울'>서울</option>
								  <option value='부산'>부산</option>
								  <option value='대구'>대구</option>
								  <option value='인천'>인천</option>
								  <option value='광주'>광주</option>
								  <option value='대전'>대전</option>
								  <option value='울산'>울산</option>
								  <option value='세종'>세종</option>
								  <option value='경기'>경기</option>
								  <option value='강원'>강원</option>
								  <option value='충북'>충북</option>
								  <option value='충남'>충남</option>
								  <option value='전북' >전북</option>
								  <option value='전남'>전남</option>
								  <option value='경북'>경북</option>
								  <option value='경남'>경남</option>
								  <option value='제주'>제주</option>
								</select>
								<select name="area2" onChange="selectArea2();" class="area2">
								  <option>-선택-</option>
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
	
	pwConfirm.addEventListener('keyup', e => {
		setTimeout(function(){
			if ( pw.value.trim() != pwConfirm.value.trim() ){
				let pwConfirmSpan = document.getElementById('pwConfirm_txt');
				
				let inputError = document.getElementById('inputSpanMsg');
				
				inputError.className = 'errorMsg';
				
				inputError.innerHTML = '비밀번호와 일치하지 않습니다.';
				
			} else if (pw.value.trim() == pwConfirm.value.trim() ){
				let pwConfirmSpan = document.getElementById('pwConfirm_txt');
				
				let inputError = document.getElementById('inputSpanMsg');
				
				inputError.className = 'successMsg';
				
				inputError.innerHTML = '비밀번호와 일치합니다.';
			}
		},250);
	})
		
</script>