package egovframework.eyelac.member.service;

import java.util.List;
import java.util.Map;

import egovframework.eyelac.member.service.impl.MemberVO;

public interface MemberService{
	MemberVO getMemberByMemberId(String memberId);

	List<MemberVO> getMemberByMemberNames(String memberName);

	int getMemberByMemberEmailCount(String memberEmail);

	MemberVO getMemberByMemberNickname(String memberNickname);

	void doJoin(Map<String, Object> param);

	MemberVO doLoginCheck(Map<String, Object> param);

	MemberVO getMemberByMemberName(String memberName);

	MemberVO getMemberById(Integer changeMemberId);

	MemberVO getMemberByMemberNameAndEmail(Map<String, Object> param);

	Map<String, Object> checkJoinMember(Map<String, Object> param);

	MemberVO getMemberByIdAndEmailAndBirth(Map<String, Object> param);

	Map<String, Object> memberIdDuplicateResult(String memberId);

	Map<String, Object> getLoginMsg(Map<String, Object> param);

}
