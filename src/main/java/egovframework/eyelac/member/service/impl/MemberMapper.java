package egovframework.eyelac.member.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("memberMapper")
public interface MemberMapper {
	MemberVO getMemberByMemberId(String memberId);
	
	void doJoin(Map<String, Object> param);

	MemberVO getMemberByMemberName(String memberName);

	void changePassword(Map<String,Object> key);

	MemberVO getMemberDupCheck(Map<String, Object> param);

	Map<String, Object> doLoginCheck(Map<String, Object> param);

	MemberVO getMemberByNameAndBirthAndPhoneNumberAndEmail(Map<String, Object> param);

}
