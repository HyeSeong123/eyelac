package egovframework.eyelac.member.service;

import java.util.List;
import java.util.Map;

import egovframework.eyelac.member.service.impl.MemberVO;

public interface MemberService{
	MemberVO getMemberByMemberId(String memberId);

	void doJoin(Map<String, Object> param);

	MemberVO getMemberByMemberName(String memberName);

	Map<String, Object> checkJoinMember(Map<String, Object> param);

	Map<String, Object> checkJoinPolicy(Map<String, Object> param);

	void changePassword(Map<String, Object> param);

	Map<String, Object> doLoginCheck(Map<String, Object> param);

}
