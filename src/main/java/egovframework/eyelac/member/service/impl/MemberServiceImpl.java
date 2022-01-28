package egovframework.eyelac.member.service.impl;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import egovframework.eyelac.member.service.MemberService;
import egovframework.eyelac.member.web.MemberController;
import egovframework.eyelac.util.Util;


@Service("memberService")
public class MemberServiceImpl implements MemberService {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Resource(name="memberMapper")
	private MemberMapper memberMapper;
	
	@Override
	public MemberVO getMemberByMemberId(String memberId) {
		return memberMapper.getMemberByMemberId(memberId);
	}

	@Override
	public void doJoin(Map<String, Object> param) {
		String memberPw = (String) param.get("memberPw");
		String area1 = (String) param.get("area1");
		String area2 = (String) param.get("area2");
		String area3 = (String) param.get("area3");
		
		String memberAddress = area1 + area2 + area3;
		
		BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder(10);

		String securityPassword = pwEncoder.encode(memberPw);

		param.put("memberAddress", memberAddress);
		param.put("memberPw", securityPassword);

		memberMapper.doJoin(param);
	}

	private MemberVO memberDupCheck(Map<String, Object> param) {
		return memberMapper.getMemberDupCheck(param);
	}

	@Override
	public MemberVO getMemberByMemberName(String memberName) {
		return memberMapper.getMemberByMemberName(memberName);
	}

	@Override
	public Map<String, Object> checkJoinMember(Map<String, Object> param) {
		
		Map<String,Object> result = new HashMap<>();
		
		String area1 = (String) param.get("area1");
		String area2 = (String) param.get("area2");
		String area3 = (String) param.get("area3");
		String memberName = (String) param.get("memberName");
		String memberPhoneNumber = (String) param.get("memberPhoneNumber");
		String memberPw = (String) param.get("memberPw");
		String memberPwConfirm = (String) param.get("memberPwConfirm");
		String memberBirth = (String) param.get("memberBirth");
		String gender = (String) param.get("gender");
		
		
		
		memberPhoneNumber.replaceAll("-", "");
		memberPhoneNumber.replaceAll(" ", "");
		
		if(memberName == null || memberName.equals("") ) {
			result = Util.MapResultAlert("F-1", "성명 미입력", "성명을 입력해주세요", "error");
			return result;
		} else if(gender == null || gender.equals("")) {
			result = Util.MapResultAlert("F-2", "성별 미입력", "성별을 입력해주세요", "error");
			return result;
		} else if(memberPhoneNumber == null || memberPhoneNumber.equals("")) {
			result = Util.MapResultAlert("F-3", "전화번호 미입력", "휴대폰 번호를 입력해주세요", "error");
			return result;
		} else if(memberPw == null || memberPw.equals("")) {
			result = Util.MapResultAlert("F-4", "패스워드 미입력", "패스워드를 입력해주세요", "error");
			return result;
		} else if(memberPwConfirm == null || memberPwConfirm.equals("")) {
			result = Util.MapResultAlert("F-5", "패스워드 확인 미입력", "패스워드 확인을 입력해주세요", "error");
			return result;
		} else if(memberBirth == null || memberBirth.equals("")) {
			result = Util.MapResultAlert("F-6", "생년월일 미입력", "생년월일을 입력해주세요", "error");
			return result;
		} else if(area1 == null || area1.equals("null")) {
			result = Util.MapResultAlert("F-7", "지역 미입력", "지역을 입력해주세요", "error");
			return result;
		} else if(area2 == null || area2.equals("null")) {
			result = Util.MapResultAlert("F-8", "시/군/구 미입력", "시/군/구를 입력해주세요", "error");
			return result;
		} else if(area3 == null || area3.equals("null")) {
			result = Util.MapResultAlert("F-9", "읍/내/동 미입력", "읍/내/동을 입력해주세요", "error");
			return result;
		}
		
		boolean isName = memberName.matches("^[a-zA-Z가-힣]*$");
		boolean isPhoneNumber = memberPhoneNumber.matches("^\\d{11}$");
		boolean isBirth = memberBirth.matches("^\\d{8}$");
		
		if ( isName == false ) {
			result = Util.MapResultAlert("F-10", "성명 입력 오류", "성명에는 이름, 영어 외 문자가 들어갈 수 없습니다.", "error");
			return result;
		} else if(isPhoneNumber == false) {
			result = Util.MapResultAlert("F-11", "전화번호 입력 오류", "휴대전화 번호 양식을 지켜주세요(- 제외)", "error");
			return result;
		} else if (memberPw.trim().length() < 3) {
			result = Util.MapResultAlert("F-12", "비밀번호 입력 오류", "비밀번호를 4글자 이상으로 입력해주세요.", "error");
			return result;
		} else if (isBirth == false) {
			result = Util.MapResultAlert("F-13", "생년월일 입력 오류", "생년월일의 양식이 일치하지 않습니다.  ex) 20200202", "error");
			return result;
		}
		
		MemberVO member = memberDupCheck(param);
		
		if ( member != null ) {
			result = Util.MapResultAlert("F-16", "중복 생성 오류", "이미 회원님의 계정이 존재 합니다.", "error");
			return result;
		}
		
		result = Util.MapResultAlert("S-1", "계정 생성 완료", "\"" + memberName + "\" 님의 회원가입을 환영합니다.", "success");
		return result;
	}

	@Override
	public Map<String,Object> checkJoinPolicy(Map<String, Object> param) {
		Map<String, Object> result = new HashMap<>();
		
		String policyUse = (String) param.get("policyUse");
		String privacyPolicy = (String) param.get("privacyPolicy");
		String marketing = (String) param.get("marketPolicy");
		
		if( policyUse == null || policyUse.trim().equals("on") == false ) {
			result = Util.MapResultAlert("F-1", "이용약관 미동의", "이용약관에 동의 해주셔야 회원가입이 가능합니다", "error");
			return result; 
		}
		
		if( privacyPolicy == null || privacyPolicy.trim().equals("on") == false ) {
			result = Util.MapResultAlert("F-2", "처리방침 미동의", "개인정보 처리방침에 동의 해주셔야 회원가입이 가능합니다", "error");
			return result;
		}
		
		String url = "/user/member/join.do";
		
		if( marketing != null ) {
			url= url + "?marketing=" + marketing;
			result = Util.MapResultAlert("S-1", "동의", "마케팅 활용에 동의해주셨습니다.", "info");
			
			result.put("redirectURI", url);
			
			return result;
		}
		
		logger.debug("url=" + url);
		
		result = Util.MapResultAlert("S-2", "", "", "info");
		result.put("redirectURI", url);
		
		return result;
	}

	@Override
	public void doChangePassword(Map<String, Object> param) {
		
		String key = (String) param.get("key");
		
		BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder(10);
		
		String securityPassword = pwEncoder.encode(key);
		
		param.put("key", securityPassword);
		
		memberMapper.changePassword(param);
	}

	@Override
	public Map<String, Object> doLoginCheck(Map<String, Object> param) {
		String memberName = (String) param.get("memberName");
		String memberPw = (String) param.get("memberPw");
		
		if(memberName != null) {
			memberName = memberName.trim();
		}
		
		if(memberPw != null) {
			memberPw = memberPw.trim();
		}
		
		MemberVO member = getMemberByMemberName(memberName);
		
		Map<String, Object> result = new HashMap<>();
		
		logger.debug("param=" + param);
		
		if(memberName == null || "".equals(memberName)) {
			result = Util.MapResultAlert("F-1", "성함 미입력", "성함을 입력해주세요.", "error");
			return result;
		} else if(memberPw == null || "".equals(memberPw)) {
			result = Util.MapResultAlert("F-2", "패스워드 미입력", "패스워드를 입력해주세요.", "error");
			return result;
		}
		
		if(member == null) {
			result = Util.MapResultAlert("F-3", "회원 정보 없음", "입력하신 정보와 일치하는 회원이 없습니다.", "error");
			return result;
		}
		
		BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder(10);

		boolean loginPwCheck = pwEncoder.matches(memberPw, member.getMemberPw());
		
		if( loginPwCheck == false ) {
			result = Util.MapResultAlert("F-4", "비밀번호 불일치", "비밀번호가 일치하지 않습니다.", "error");
			return result;
		}
		
		result = Util.MapResultAlert("S-1", "로그인", "로그인 되었습니다.", "success");
		
		return result;
	}

	@Override
	public Map<String, Object> ChangePw(Map<String, Object> param) {
		
		Map<String, Object> result = new HashMap<>();
		
		String birthReg = "^\\d{8}$";
		String phoneNumber = "\\d{11}$";
		
		String memberName = (String) param.get("memberName");
		String memberBirth = (String) param.get("memberBirth");
		String memberPhNum = (String) param.get("memberPhNum");
		String memberEmail = (String) param.get("memberEmail");
		
		if(memberName == null || memberName.length() < 1) {
			result = Util.MapResultAlert("F-2", "성함 미입력", "성함을 입력해주세요.", "error");
			return result;
		} else if ( ! Pattern.matches(birthReg, memberBirth) ) {
			result = Util.MapResultAlert("F-3", "생년월일 양식", "생년월일의 양식이 일치하지 않습니다.", "error");
			return result;
		} else if ( ! Pattern.matches(phoneNumber, memberPhNum) ) {
			result = Util.MapResultAlert("F-4", "전화번호 양식", "전화번호 양식이 일치하지 않습니다.", "error");
			return result;
		} else if(memberEmail == null || memberEmail.length() < 1) {
			result = Util.MapResultAlert("F-5", "이메일 미입력", "이메일을 입력해주세요.", "error");
			return result;
		}
		
		MemberVO member = memberMapper.getMemberByNameAndBirthAndPhoneNumberAndEmail(param);
		
		if ( member == null ) {
			result = Util.MapResultAlert("F-1", "일치하는 정보 없음", "입력하신 정보와 일치하는 정보가 없습니다.", "error");
			return result;
		}
		
		result = Util.MapResultAlert("S-1", "인증 성공", "입력하신 이메일로 임시비밀번호가 전송 되었습니다.", "success");
		return result;
	}
}