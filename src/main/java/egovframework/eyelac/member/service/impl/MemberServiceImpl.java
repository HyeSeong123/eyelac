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
		// TODO Auto-generated method stub

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
	public String checkJoinMember(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return null;
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
		String msg = "";
		result.put("member", member);
		
		if(memberId == null) {
			msg = "아이디를 입력해주세요";
			result.put("msg", msg);
			
			return result; 
		}
		
		if(memberPw == null) {
			msg = "패스워드를 입력해주세요";
			result.put("msg", msg);
			
			return result;
		}
		
		if(member == null) {
			msg = "존재하지 않는 아이디 입니다.";
			result.put("msg", msg);
			
			return result;
		}
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		boolean loginPwCheck = encoder.matches(memberPw, member.getMemberPw());
		
		if( loginPwCheck == false ) {
			msg = "패스워드가 일치하지 않습니다.";
			result.put("msg", msg);
			
			return result;
		}
		
		msg = "통과";
		result.put("msg", msg);
		
		return result;
	}

}
