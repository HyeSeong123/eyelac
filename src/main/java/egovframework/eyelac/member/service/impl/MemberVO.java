package egovframework.eyelac.member.service.impl;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class MemberVO {
	private int id;
	private String regDate;
	private String updateDate;
	private String memberName;
	@JsonIgnore
	private String memberPw;
	private String memberBirth;
	@JsonIgnore
	private String memberAddress;
	private String memberGender;
	@JsonIgnore
	private String memberPhNum;
	private String memberLevel;
	private String mailAgree;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getMemberPw() {
		return memberPw;
	}
	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}
	public String getMemberBirth() {
		return memberBirth;
	}
	public void setMemberBirth(String memberBirth) {
		this.memberBirth = memberBirth;
	}
	public String getMemberAddress() {
		return memberAddress;
	}
	public void setMemberAddress(String memberAddress) {
		this.memberAddress = memberAddress;
	}
	public String getMemberGender() {
		return memberGender;
	}
	public void setMemberGender(String memberGender) {
		this.memberGender = memberGender;
	}
	public String getMemberPhNum() {
		return memberPhNum;
	}
	public void setMemberPhNum(String memberPhNum) {
		this.memberPhNum = memberPhNum;
	}
	public String getMemberLevel() {
		return memberLevel;
	}
	public void setMemberLevel(String memberLevel) {
		this.memberLevel = memberLevel;
	}
	public String getMailAgree() {
		return mailAgree;
	}
	public void setMailAgree(String mailAgree) {
		this.mailAgree = mailAgree;
	}
	
}