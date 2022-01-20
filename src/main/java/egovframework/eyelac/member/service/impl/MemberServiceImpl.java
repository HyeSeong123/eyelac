package egovframework.eyelac.member.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public List<MemberVO> getMemberByMemberNames(String memberName) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getMemberByMemberEmailCount(String memberEmail) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public MemberVO getMemberByMemberNickname(String memberNickname) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void doJoin(Map<String, Object> param) {
		String memberPw = (String) param.get("memberPw");

		BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder(10);

		String securityPassword = pwEncoder.encode(memberPw);

		param.put("memberPw", securityPassword);

		memberMapper.doJoin(param);
	}

	@Override
	public MemberVO doLoginCheck(Map<String, Object> param) {
		return memberMapper.doLoginCheck(param);
	}

	@Override
	public MemberVO getMemberByMemberName(String memberName) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MemberVO getMemberById(Integer changeMemberId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MemberVO getMemberByMemberNameAndEmail(Map<String, Object> param) {
		
		return memberMapper.getMemberByMemberNameAndEmail(param);
	}

	@Override
	public Map<String, Object> checkJoinMember(Map<String, Object> param) {
		
		Map<String,Object> result = new HashMap<>();
		
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
		} else if(memberPhoneNumber == null || memberPhoneNumber.equals("")) {
			result = Util.MapResultAlert("F-2", "전화번호 미입력", "휴대폰 번호를 입력해주세요", "error");
			return result;
		} else if(memberPw == null || memberPw.equals("")) {
			result = Util.MapResultAlert("F-4", "패스워드 미입력", "패스워드를 입력해주세요", "error");
			return result;
		} else if(memberPwConfirm == null || memberPwConfirm.equals("")) {
			result = Util.MapResultAlert("F-5", "패스워드 확인 미입력", "패스워드 확인을 입력해주세요", "error");
			return result;
		} else if(memberBirth == null || memberBirth.equals("")) {
			result = Util.MapResultAlert("F-7", "생년월일 미입력", "생년월일을 입력해주세요", "error");
			return result;
		} else if(gender == null || gender.equals("")) {
			result = Util.MapResultAlert("F-10", "성별 미입력", "성별을 입력해주세요", "success");
			return result;
		}
		
		boolean isName = memberName.matches("^[a-zA-Z가-힣]*$");
		boolean isPhoneNumber = memberPhoneNumber.matches("\\d{11}");
		
		if ( isName == false ) {
			result = Util.MapResultAlert("F-11", "성명 입력 오류", "성명에는 이름, 영어 외 문자가 들어갈 수 없습니다.", "error");
			return result;
		} else if(isPhoneNumber == false) {
			result = Util.MapResultAlert("F-12", "전화번호 입력 오류", "휴대전화 번호 양식을 지켜주세요(- 제외)", "error");
			return result;
		} else if (memberPw.trim().length() < 3) {
			result = Util.MapResultAlert("F-14", "비밀번호 입력 오류", "비밀번호를 4글자 이상으로 입력해주세요.", "error");
			return result;
		}
		
		MemberVO member = memberMapper.getMemberByMemberName(memberName);
		
		if ( member != null ) {
			result = Util.MapResultAlert("F-16", "중복 생성 오류", "이미 회원님의 계정이 존재 합니다.", "error");
			return result;
		}
		
		result = Util.MapResultAlert("S-1", "계정 생성 완료", "\"" + memberName + "\" 님의 회원가입을 환영합니다.", "success");
		return result;
	}

	@Override
	public MemberVO getMemberByIdAndEmailAndBirth(Map<String, Object> param) {
		return memberMapper.getMemberByIdAndEmailAndBirth(param);
	}

	@Override
	public Map<String, Object> memberIdDuplicateResult(String memberId) {
		
		boolean isId = memberId.matches("^[a-zA-Z]{1}[a-zA-Z0-9_]{5,13}$");

		if (isId == false) {
			return Util.MapResultReturn("F-1", "아이디를 6글자 이상 13글자 이하 영문으로 숫자가 먼저 오지 않게 지정해주세요.");
		}

		MemberVO member = getMemberByMemberId(memberId);
		
		if (member != null) {
			return Util.MapResultReturn("F-2", "이미 존재하는 아이디 입니다.");
		}

		return Util.MapResultReturn("S-1", "사용가능한 아이디 입니다.");
	}

	@Override
	public Map<String,Object> getLoginMsg(Map<String, Object> param) {
		
		String memberId = (String) param.get("memberId");
		String memberPw = (String) param.get("memberPw");
		
		String afterLoginURI = (String) param.get("afterLoginURI");
		
		MemberVO member = doLoginCheck(param);
		
		Map<String, Object> result = new HashMap<>();
		
		logger.debug("member=" + member);
		
		result.put("member", member);
		
		if(memberId == null) {
			result = Util.MapResultAlert("F-1", "아이디 미입력", "아이디를 입력해주세요", "error");
			return result; 
		}
		
		if(memberPw == null) {
			Util.MapResultAlert("F-2", "패스워드 미입력", "패스워드를 입력해주세요", "error");
			return result;
		}
		
		if(member == null) {
			result = Util.MapResultAlert("F-3", "존재하지 않는 아이디", "일치하는 정보의 계정이 없습니다.", "error");
			return result;
		}
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(10);
		
		boolean loginPwCheck = encoder.matches(memberPw, member.getMemberPw());
		
		if( loginPwCheck == false ) {
			result = Util.MapResultAlert("F-4", "패스워드 불일치", "계정의 정보와 패스워드가 일치하지 않습니다.", "error");
			
			return result;
		}
		
		result = Util.MapResultAlert("S-1", "로그인 성공", "로그인을 환영합니다.", "success");
		
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
	public Map<String, Object> doFindId(Map<String, Object> param) {
		
		MemberVO member = getMemberByMemberNameAndEmail(param);
		
		Map<String, Object> result = new HashMap<>();
		
		if(member == null) {
			result = Util.MapResultReturn("F-1", "입력하신 정보와 일치하는 아이디가 없습니다.");
			
			return result;
		}
		
		String memberId = (String) member.getMemberId();
		
		result = Util.MapResultReturn("S-1", "회원님의 아이디는 " + memberId + " 입니다.");
		
		return result;
	}

	@Override
	public Map<String, Object> doFindPw(Map<String, Object> param) {
		
		Map<String, Object> result = new HashMap<>();
		
		MemberVO member = getMemberByIdAndEmailAndBirth(param);
		
		if(member == null) {
			result = Util.MapResultAlert("F-1", "계정정보 없음", "입력하신 정보와 일치하는 계정이 없습니다.", "error");
			return result;
		}
		
		result = Util.MapResultAlert("S-1", "임시 비밀번호 발급" , member.getMemberEmail() + "로 임시 비밀번호를 발급 했습니다.", "success");
		return result;
	}

	@Override
	public void changePassword(Map<String, Object> param) {
		
		String key = (String) param.get("key");
		
		BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder(10);
		
		String securityPassword = pwEncoder.encode(key);
		
		param.put("key", securityPassword);
		
		memberMapper.changePassword(param);
	}

}
