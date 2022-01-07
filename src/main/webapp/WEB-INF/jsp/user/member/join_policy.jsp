<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<script>
	let nextStep = false;
	function checkBoxCheck(){
		
		if ( nextStep ){
			alert('처리중입니다.');
		}
		
		if ( $('#policyUse').is(":checked") == false ){
			alert('이용약관에 동의 해주셔야 회원가입이 가능합니다.');
			$('#policyUse').focus();
			return;
		}
		
		else if ( $('#privacyPolicy').is(":checked") == false ){
			alert('개인정보 처리방침에 동의 해주셔야 회원가입이 가능합니다.');
			$('#privacyPolicy').focus();
			return;
		}
		
		nextStep = true;
		
		if(nextStep){
			$('#join_policy_checkBox').submit();	
		}
	}
</script>

<main class="join_policy_page">
	<div class="title_image" style="height:455px;">
		<div class="page_title">
			<h1>회원가입 약관</h1>
		</div>
	</div>
	
	<div class="join_container">
		<div class="policy_title">
			<div>약관 동의</div>
		</div>
		
		<form method="POST" id="join_policy_checkBox" action="/user/member/join_policyCheck.do">
		<div>
			<span>[필수] 이용약관 동의</span>
				<div class="policy_box policy_box1">
					<div class="policy_box_tit">
						<h2 class="policy_box_top">이용 약관</h2>
						
						<h4> &lt; 제 1 장 총칙 &gt; </h4>
						
						<div>
							<strong>제 1조 (목적)</strong>
							<ul class="policy_ul">
								<li>본 약관은 아일락블로우(이하 '회사'라 한다.)이 제공하는 인터넷 서비스 (영문영 eyelac.com 이하 '서비스'라 한다.)를 이용함에 있어 이용조건 및 절차에 관한 기본적인 사항과 기타 필요한 사항에 관한 통합 약관의 정의를 목적으로 합니다. </li>
							</ul>
						</div>
						
						<div>
							<strong>제 2조 (용어의 정의)</strong>
							<ul class="policy_ul">
								<li>이 약관에서 사용하는 용어의 정의는 다음과 같습니다.</li>
								<li>1. 이용자 : 회사가 운영하는 서비스를 이 약관에 따라 제공받는 회원 및 비회원을 말합니다.</li>
								<li>2. 회 원 : 회사가 운영하는 서비스에 개인정보를 제공하여 회원등록을 한 자로서, 회사가 제공하는 서비스를 계속적으로 이용할 수 있는 자를 말합니다.</li>
								<li>3. 비회원 : 회원에 가입하지 않고 회사가 제공하는 서비스를 이용하는자를 말합니다.</li>
								<li>4. ID : 회원식별과 회원의 서비스 이용을 위하여 회원이 선정하고 회사가 승인하는 문자와 숫자의 조합을 말합니다.</li>
								<li>5. e-mail : 회원 식별과 회원의 서비스 이용을 위한 회원의 e-mail 주소를 말합니다.</li>
								<li>6. 비밀번호 : 회원이 부여받은 아이디(ID)와 일치된 회원임을 확인하고 회원 자신의 비밀을 보호하기 위하여 회원이 정한 문자와 숫자의 조합을 말합니다.</li>
								<li>7. 해 지 : 회사 또는 회원이 서비스를 개통 후 이용계약을 해약 하는 것을 말합니다.</li>
							</ul>
						</div>
						
						<div>
							<strong>제 3 조 (약관의 공지 및 변경)</strong>
							<ul class="policy_ul">
								<li>1. 이 약관의 내용은 서비스 화면에 게시하거나 기타의 방법으로 회원에게 송지함으로써 효력을 발생합니다.</li>
								<li>2. 회사는 이 약관을 변경할 수 있으며, 변경된 약관은 제7조와 같은 방법으로 공지함으로써 효력을 발생합니다.</li>
							</ul>
						</div>
						
						<div>
							<strong>제 4 조 (약관외 준칙)</strong>
							<ul class="policy_ul">
								<li>본 약관에 명시 되지 않은 사항은 관련 법령 또는 일반 상관례 원칙에 따릅니다.</li>
							</ul>
						</div>
						
						<h4> &lt; 제 2 장 회원 가입 및 탈퇴 &gt; </h4>
						
						<div>
							<strong>제 5 조 (회원 가입 및 이용 계약의 성립)</strong>
							<ul class="policy_ul">
								<li>1. 이용자의 본 약관에 대한 동의와 이용자의 이용 신청에 대한 회사의 동의로 회원가입 및 이용 계약이 성립됩니다.</li>
								<li>2. 회원 가입 신청시 이용자는 회사에서 요청하는 개인 신상 정보를 거짓 없이 정확히 기입 하여야 합니다.</li>
								<li>3. 회사는 제2항과 같이 회원가입을 신청한 이용자 중 다음 각호에 해당하지 않는 한 회원으로 등록합니다.</li>
								<li>① 회원가입시 등록 내용이 허위, 기재누락, 오기가 있는 경우</li>
								<li>② 회원으로 등록하는 것이 회사의 기술상 현저히 지장이 있다고 판단되는 경우</li>
								<li>③ 기타 회사가 필요하다고 인정되는 경우</li>
								<li>4. 회원가입 계약의 성립 시기는 회사가 승낙함으로써 성립합니다.</li>
								<li>5. 회원은 이용신청시 기재한 이용자정보가 변경되었을 경우에는, 온라인으로 수정을 하여야 하며 미변경으로 인하여 발생되는 문제의 책임은 이용자에게 있습니다</li>
							</ul>
						</div>
						
						<div>
							<strong>제 7 조 (회원에 대한 통지)</strong>
							<ul class="policy_ul">
								<li>1. 회사가 회원에게 통지가 필요한 경우, 회원이 회사에 제출한 전자우편 주소로 할 수 있습니다.</li>
								<li>2. 회사는 불특정 다수 회원에 대한 통지의 경우 1주일이상 서비스내에 별도로 게시함으로서 개별 통지에 대신할 수 있습니다.</li>
							</ul>
						</div>
						
						<h4> &lt; 제 3 장 서비스 제공, 이용, 변경 및 중단 &gt; </h4>
						
						<div>
							<strong>제 8 조 (서비스 제공)</strong>
							<ul class="policy_ul">
								<li>회사에서 제공하는 모든 서비스는 무료이며, 회원의 동의하에 회사는 회원이 서비스 이용 중 필요하다고 인정되는 다양한 정보에 대해서 e-mail,
									서신 우편 등 기타의 방법으로 회원에게 제공할 수 있습니다.</li>
							</ul>
						</div>
						
						<div>
							<strong>제 9 조 (서비스 이용시간 및 내용변경)</strong>
							<ul class="policy_ul">
								<li>1. 서비스 이용시간은 연중무휴 1일 24시간을 원칙으로 합니다.</li>
								<li>2. 회사가 불가피한 여건으로 인하여 회원에게 사전 공지 없이 회사에서 제공하는 서비스의 내용을 변경 할 수 있습니다.</li>
							</ul>
						</div>
						
						<div>
							<strong>제 10 조 (서비스 중단)</strong>
							<ul class="policy_ul">
								<li>1. 회사는 서비스의 갱신, 시스템의 보수점검 및 교체, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다.</li>
								<li>2. 제1항에 의한 서비스 중단의 경우에는 회사는 제7조에 정한 방법으로 이용자에게 통지합니다.</li>
								<li>3. 회사는 제1항의 사유로 서비스의 제공이 일시적으로 중단됨으로 인한 이용자 또는 제3자가 입은 손해에 대하여 배상하지 않습니다.</li>
							</ul>
						</div>
						
						<div>
							<strong>제 11 조 (광고주와의 거래)</strong>
							<ul class="policy_ul">
								<li>회사는 본 서비스상에 게재되어 있거나 본 서비스를 통한 광고주의 판촉활동에 회원이 참여하거나 교신 또는 거래의 결과로서 발생하는 모든 손실 또는 손해에 대해 책임을 지지 않습니다.</li>
							</ul>
						</div>
						
						<h4> &lt; 제 4 장 의무 &gt; </h4>
						
						<div>
							<strong>제 12 조 (회사의 의무)</strong>
							<ul class="policy_ul">
								<li>1. 회사는 이 약관에서 정한바에 따라 계속적, 안정적으로 서비스를 제공할 의무가 있습니다.</li>
								<li>2. 회사는 이용자의 개인 신상 정보를 본인의 승낙없이 타인에게 누설, 배포하여서는 아니됩니다.</li>
								<li>다만, 전기통신관련법령 등 관계법령에 의하여 관계 국가기관등의 요구가 있는 경우는 제외합니다.</li>
							</ul>
						</div>
						
						<div>
							<strong>제 13 조 (이용자 및 회원의 의무)</strong>
							<ul class="policy_ul">
								<li>1. 이용자 및 회원은 본 약관에서 규정하는 사항을 준수 하여야 합니다.</li>
								<li>2. 이용자 및 회원은 아래 각 호의 행위를 하지 않아야 합니다.</li>
								<li>① 회원 가입 및 개인 신상 정보의 변경 시 허위 내용의 등록</li>
								<li>② 서비스에 게시된 정보의 변경</li>
								<li>③ 서비스가 정한 정보 이외의 정보(컴퓨터 프로그램 등)의 송신 또는 게시</li>
								<li>④ 회사 혹은 제3자의 저작권 등 기타 지적재산권에 대한 침해</li>
								<li>⑤ 회사 또는 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위</li>
								<li>⑥ 공공질서 및 미풍양속에 위반되는 정보, 문장, 도형등을 타인에게 유포하는 행위</li>
								<li>⑦ 관계 법령에 위배되는 행위록</li>
								<li>⑧ 기타 회사가 판단 하기에 부적절하다고 판단 되는 행위</li>
								<li>⑧ 서비스에서 얻은 정보를 회사의 사전 승낙 없이 회원 사용 이외의 목적으로 복제하거나 이를 출판 및 방송에 사용하거나 제 3자에게 제공하는 행위</li>
							</ul>
						</div>
						
						<div>
							<strong>제 14 조 (회원의 이름, 아이디, 비밀번호, e-mail 관리에 대한 의무)</strong>
							<ul class="policy_ul">
								<li>1. 제11조의 경우를 제외하고 회원이름, 아이디, 비밀번호, e-mail 주소 관리에 대한 책임은 회원에게 있습니다.</li>
								<li>2. 회원은 이름, 아이디, 비밀번호, e-mail주소를 제3자에게 이용하게 해서는 안됩니다.</li>
								<li>3. 이름, 아이디, 비밀번호, e-mail 주소의 관리소홀, 부정 사용 및 사용상의 과실 등에 의하여 발생하는 모든 결과에 대한 책임은 회원에게 있습니다.</li>
								<li>4. 회원은 자신의 이름, 아이디, 비밀번호, e-mail주소 및 비밀번호가 부정하게 사용되고 있음을 인지한 경우, 바로 회사에 그 사실을 통보하고 회사의 지시에 따릅니다.</li>
								<li>5. 회원은 회사가 제공하는 서비스를 통하여 음란물이나, 불온한 내용, junk mail, spam mail 및 타인에게 피해를 주거나 미풍양속을 해치는 e-mail을 보내서는 안됩니다.</li>
							</ul>
						</div>
						
						<h4> &lt; 제 5 장 손해배상 / 면책조항 &gt; </h4>
						
						<div>
							<strong>제 15 조 (손해 배상)</strong>
							<ul class="policy_ul">
								<li>사 또는 회원이 약관을 위반함으로써 발행하는 모든 책임은 위반한 자가 부담하여, 이로 인하여 상대방에게 손해를 입힌 경우 배상하여야 합니다.</li>
							</ul>
						</div>
						
						<div>
							<strong>제 16 조 (면책 조항)</strong>
							<ul class="policy_ul">
								<li>1. 회사는 천재지변, 국가 비상사태 또는 이에 준하는 불가항력으로 서비스를 제공할 수 없는 경우 이에 대한 책임을 지지 않습니다.</li>
								<li>2. 회사는 회원이 서비스를 이용하여 기대하는 손익이나, 서비스를 통하여 얻은 자료로 인한 손해에 관해서 책임을 지지 않습니다.</li>
								<li>3. 회사는 회원이 서비스에 게재한 정보 자료 사실의 신뢰도, 정확성 등 내용에 관하여 책임지지 않습니다.</li>
							</ul>
						</div>
						
						<h4> &lt; 제 6 장 기타 &gt; </h4>
						
						<div>
							<strong>제 17 조 (저작권의 귀속 및 이용제한)</strong>
							<ul class="policy_ul">
								<li>1. 회사가 작성한 저작물에 대한 저작권 기타 지적재산권은 회사에 귀속합니다.</li>
								<li>2. 이용자는 회사의 서비스를 이용함으로써 얻은 정보를 회사의 사전 승낙없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다.
								    이에 발생한 결과에 대하여 회사는 책임을 지지 않습니다.</li>
							</ul>
						</div>
						
						<div>
							<strong>제 18 조 (분쟁해결)</strong>
							<ul class="policy_ul">
								<li>서비스 이용으로 인하여 발생한 분쟁에 대해 소송이 제기될 경우, 회사 소재지 관할 법원을 관할 법원으로 정합니다.</li>
							</ul>
						</div>
						
					</div>
					
					
					<div class="policy_check_box">
						<div>
							<input type="checkbox" name="policyUse" id="policyUse">
							<label for="policyUse">동의함</label>
						</div>
					</div>
				</div>
			</div>
			
			<div>
				<span>[필수] 개인정보 처리방침 동의</span>
				<div class="policy_box policy_box2">
					<div class="policy_box_tit">
						<h2 class="policy_box_top">개인정보처리 방침</h2>
						
						<div>
							<strong>개인정보 보호정책 안내</strong>
							<ul class="policy_ul">
								<li>본 정책은 아일락뷰티살롱(이하 '회사'라 한다.)이 제공하는 인터넷 서비스 (영문영 eyelac.com 이하 '서비스'라 한다.)를 이용함에 있어 개인정보보호 정책 정의를 목적으로 합니다.</li>
							</ul>
						</div>
						
						<div>
							<strong>수집하는 개인정보 항목</strong>
							<ul class="policy_ul">
								<li>o 회사는 회원가입, 상담, 서비스 신청 등등을 위해 아래와 같은 개인정보를 수집하고 있습니다.</li>
								<li>o 수집항목 : 이름 , 생년월일 , 성별 , 로그인ID , 비밀번호 , 전화번호 , 휴대전화번호 , 이메일 등</li>
								<li>o 개인정보 수집방법 : 홈페이지(회원가입)</li>
							</ul>
						</div>
					
						<div>
							<strong>개인정보의 수집 및 이용목적</strong>
							<ul class="policy_ul">
								<li>o 회사는 수집한 개인정보를 다음의 목적을 위해 활용합니다.</li>
								<li>o 회사에서 제공하는 모든 서비스는 무료이며 회원의 동의하에 회사는 회원이 서비스 이용 중 필요하다고 인정되는 다양한 정보에 대하여 e-mail 우편등 기타의 방법으로 회원에게 제공 할 수 있습니다.</li>
								<li>o 회원 관리 - 회원제 서비스 이용에 따른 본인확인 , 개인 식별 , 불량회원의 부정 이용 방지와 비인가 사용 방지 , 가입 의사 확인 , 연령확인 , 불만처리 등 민원처리 , 고지사항 전달</li>
								<li>o 마케팅 및 광고에 활용</li>
								<li>이벤트 등 광고성 정보 전달 , 접속 빈도 파악 또는 회원의 서비스 이용에 대한 통계</li>
							</ul>
						</div>
					
						<div>
							<strong>개인정보의 보유 및 이용기간</strong>
							<ul class="policy_ul">
								<li>원칙적으로, 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 단, 관계법령의 규정에 의하여 보존할 필요가 있는 경우 회사는 아래와 같이 관계법령에서 정한 일정한 기간 동안 회원정보를 보관합니다.</li>
								<li>o 보존 항목 : 결제기록</li>
								<li>o 보존 근거 : 계약 또는 청약철회 등에 관한 기록</li>
								<li>o 보존 기간 : 3년</li>
								<li>o 계약 또는 청약철회 등에 관한 기록 : 5년 (전자상거래등에서의 소비자보호에 관한 법률)</li>
								<li>o 대금결제 및 재화 등의 공급에 관한 기록 : 5년 (전자상거래등에서의 소비자보호에 관한 법률)</li>
								<li>o 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년 (전자상거래등에서의 소비자보호에 관한 법률)</li>
								<li>o 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」 제29조 및 시행령 제16조에 따라 휴면회원의 경우 다음과 같이 처리합니다.</li>
								<li>- 미이용 기준 : 홈페이지 이용 1년 초과</li>
								<li>- 휴면회원 처리에 대한 안내 : 30일 이전 메일을 통한 안내</li>
								<li>- 휴면회원에 대한 개인정보 처리 : 분리 보관조치내</li>
								<li>- 분리 보관 정보 : 회원정보, 주문/결제 정보 등</li>
								<li>- 분리 보관 정보에 대한 보존 기간 : 관련 법령에 의거 보존</li>
								<li>- 계정 활성화 : 고객의 요청에 의거 계정활성화 조치 실시</li>
							</ul>
						</div>
					
						<div>
							<strong>개인정보위탁</strong>
							<ul class="policy_ul">
								<li>회사는 서비스 이행을 위해 아래와 같이 외부에 위탁하여 운영하고 있습니다.</li>
								<li>위탁 대상자 : 방혜성</li>
								<li>위탁업무 내용 : 웹사이트 및 시스템 관리</li>
							</ul>
						</div>
						
						<div>
							<strong>개인정보보호 책임자</strong>
							<ul class="policy_ul">
								<li>회사는 이용자의 개인정보 관련 문의사항 및 불만 처리 등을 위하여 개인정보 보호책임자 및 담당자를 지정하고 있으며 관련 문의사항은 고객센터를 이용하여 주시기 바랍니다.</li>
								<li>개인정보보호책임자</li>
								<li>이름 : 김태수</li>
								<li>직위 : </li>
							</ul>
						</div>
						
						<div>
							<strong>개인정보보호 담당자</strong>
							<ul class="policy_ul">
								<li>회사는 이용자의 개인정보 관련 문의사항 및 불만 처리 등을 위하여 개인정보 보호책임자 및 담당자를 지정하고 있으며 관련 문의사항은 고객센터를 이용하여 주시기 바랍니다.</li>
								<li>개인정보보호책임자</li>
								<li>이름 : 김태수</li>
								<li>직위 : </li>
							</ul>
						</div>
					</div>
						
					<div class="policy_check_box">
						<div>
							<input type="checkbox" name="privacyPolicy" id="privacyPolicy">
							<label for="privacyPolicy">동의함</label>
						</div>
					</div>
				</div>
			</div>
			
			<div>
				<span>[선택] 마케팅 활용 동의</span>
				<div class="policy_box policy_box3">
					<div class="policy_box_tit">
						<h2 class="policy_box_top">개인정보처리 방침</h2>
						
						<div>
							<strong>1. SMS알림 문자</strong>
						</div>
						
						<div>
							<strong>2. 뉴스레터 및 안내 메일 수신</strong>
						</div>
						
					</div>
					
					<div class="policy_check_box">
						<div>
							<input type="checkbox" name="marketPolicy" id="marketPolicy">
							<label for="marketPolicy">동의함</label>
						</div>
					</div>
				</div>
			</div>
			<div class="allCheckBox">
				<input type="checkbox" name="allCheck" id="allCheck">
				<label for="allCheck">아일락 이용약관, 개인정보 처리방침, <div class="wr"></div> 마케팅 활용(선택) 에 모두 동의합니다.</label>
			</div>
		</form>
	</div>

	<div class="buttonBox">
		<div class="btn_join"><button onclick="checkBoxCheck()">회원가입</button></div>
		<div class="btn_return"><button onclick="movePage('${param.returnUrl}')">돌아가기</button></div>
	</div>
	
	<script>
		let checkBox = $('#allCheck');
		
		checkBox.change(function(){
			if ( checkBox.is(":checked") ){
				$('#policyUse').prop("checked", true);
				$('#privacyPolicy').prop("checked", true);
				$('#marketPolicy').prop("checked", true);
			} else {
				$('#policyUse').prop("checked", false);
				$('#privacyPolicy').prop("checked", false);
				$('#marketPolicy').prop("checked", false);
			}
		})
	</script>
	
	
</main>

