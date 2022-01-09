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

		BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder();

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
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> checkJoinMember(Map<String, Object> param) {
		
		Map<String,Object> result = new HashMap<>();
		
		String memberName = (String) param.get("memberName");
		String memberPhoneNumber = (String) param.get("memberPhoneNumber");
		String memberId = (String) param.get("memberId");
		String memberPw = (String) param.get("memberPw");
		String memberPwConfirm = (String) param.get("memberPwConfirm");
		String memberEmail = (String) param.get("memberEmail");
		String memberBirth = (String) param.get("memberBirth");
		String memberPostcode = (String) param.get("memberPostCode");
		String memberAddress = (String) param.get("memberAddress");
		String gender = (String) param.get("gender");
		
		memberPhoneNumber.replaceAll("-", "");
		memberPhoneNumber.replaceAll(" ", "");
		
		if(memberName == null || memberName.equals("") ) {
			result = Util.MapResultAlert("F-1", "성명 미입력", "성명을 입력해주세요", "error");
			return result;
		} else if(memberPhoneNumber == null || memberPhoneNumber.equals("")) {
			result = Util.MapResultAlert("F-2", "전화번호 미입력", "휴대폰 번호를 입력해주세요", "error");
			return result;
		} else if(memberId == null || memberId.equals("")) {
			result = Util.MapResultAlert("F-3", "아이디 미입력", "아이디를 입력해주세요", "error");
			return result;
		} else if(memberPw == null || memberPw.equals("")) {
			result = Util.MapResultAlert("F-4", "패스워드 미입력", "패스워드를 입력해주세요", "error");
			return result;
		} else if(memberPwConfirm == null || memberPwConfirm.equals("")) {
			result = Util.MapResultAlert("F-5", "패스워드 확인 미입력", "패스워드 확인을 입력해주세요", "error");
			return result;
		} else if(memberEmail == null || memberEmail.equals("")) {
			result = Util.MapResultAlert("F-6", "이메일 미입력", "이메일을 입력해주세요", "error");
			return result;
		} else if(memberBirth == null || memberBirth.equals("")) {
			result = Util.MapResultAlert("F-7", "생년월일 미입력", "생년월일을 입력해주세요", "error");
			return result;
		} else if(memberPostcode == null || memberPostcode.equals("")) {
			result = Util.MapResultAlert("F-8", "우편번호 미입력", "우편번호를 입력해주세요", "error");
			return result;
		} else if(memberAddress == null || memberAddress.equals("")) {
			result = Util.MapResultAlert("F-9", "주소 미입력", "주소를 입력해주세요", "error");
			return result;
		}
		else if(gender == null || gender.equals("")) {
			result = Util.MapResultAlert("F-10", "성별 미입력", "성별을 입력해주세요", "success");
			return result;
		}
		
		boolean isName = memberName.matches("^[a-zA-Z가-힣]*$");
		boolean isPhoneNumber = memberPhoneNumber.matches("\\d{11}");
		boolean isId = memberId.matches("^[a-zA-Z]{1}[a-zA-Z0-9_]{5,13}$");
		boolean isPassword = memberPw.matches("^(?=.*[A-Za-z])(?=.*\\d)(?=.*[~!@#$%^&*()+|=])[A-Za-z\\d~!@#$%^&*()+|=]{8,19}$");
		boolean isEmail = memberEmail.matches("^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$");
		
		if ( isName == false ) {
			result = Util.MapResultAlert("F-11", "성명 입력 오류", "성명에는 이름, 영어 외 문자가 들어갈 수 없습니다.", "error");
			return result;
		} else if(isPhoneNumber == false) {
			result = Util.MapResultAlert("F-12", "전화번호 입력 오류", "휴대전화 번호 양식을 지켜주세요(- 제외)", "error");
			return result;
		} else if(isId == false) {
			result = Util.MapResultAlert("F-13", "아이디 입력 오류", "아이디에는 특수문자가 포함되지 않은 영어 및 숫자로 6자 이상이어야 합니다.(숫자로 시작 불가능)", "error");
			return result;
		} else if(isPassword == false) {
			result = Util.MapResultAlert("F-14", "비밀번호 입력 오류", "비밀번호는 영문과 특수문자 숫자를 포함하며 8자 이상 18자 이하여야 합니다.", "error");
			return result;
		} else if(isEmail == false) {
			result = Util.MapResultAlert("F-14", "이메일 입력 오류", "이메일 양식을 지켜주세요.", "error");
			return result;
		}
		
		MemberVO member = memberMapper.getMemberByMemberId(memberId);
		
		if ( member != null ) {
			result = Util.MapResultAlert("F-14", "아이디 중복 오류", "이미 사용중인 아이디 입니다.", "error");
			return result;
		}
		
		MemberVO dupMember = memberMapper.getMemberByMemberNameAndEmailAndPhNum(param);
		
		if ( dupMember != null ) {
			result = Util.MapResultAlert("F-14", "계정 중복 생성 오류", "계정은 한 분 당 한 개만 생성 가능합니다.", "error");
			return result;
		}
		
		result = Util.MapResultAlert("S-1", "계정 생성 완료", "\"" + memberName + "\" 님의 회원가입을 환영합니다.", "error");
		return result;
	}

	@Override
	public MemberVO getMemberByIdAndEmailAndBirth(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return null;
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
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		boolean loginPwCheck = encoder.matches(memberPw, member.getMemberPw());
		
		if( loginPwCheck == false ) {
			result = Util.MapResultAlert("F-4", "패스워드 불일치", "계정의 정보와 패스워드가 일치하지 않습니다.", "error");
			
			return result;
		}
		
		result = Util.MapResultAlert("S-1", "로그인 성공", "로그인을 환영합니다.", "success");
		
		return result;
	}

}
