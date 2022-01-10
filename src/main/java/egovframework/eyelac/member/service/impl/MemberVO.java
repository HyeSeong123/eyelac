package egovframework.eyelac.member.service.impl;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class MemberVO {
	private int id;
	private String regDate;
	private String updateDate;
	private String memberName;
	private String memberId;
	@JsonIgnore
	private String memberPw;
	private String memberBirth;
	@JsonIgnore
	private String memberPostcode;
	@JsonIgnore
	private String memberAddress;
	private String memberNickname;
	private String memberEmail;
	private String memberGender;
	@JsonIgnore
	private String memberPhNum;
	private String memberLevel;
	private String mailAgree;
	private String emailAgree;
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
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
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
	public String getMemberPostcode() {
		return memberPostcode;
	}
	public void setMemberPostcode(String memberPostcode) {
		this.memberPostcode = memberPostcode;
	}
	public String getMemberAddress() {
		return memberAddress;
	}
	public void setMemberAddress(String memberAddress) {
		this.memberAddress = memberAddress;
	}
	public String getMemberNickname() {
		return memberNickname;
	}
	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}
	public String getMemberEmail() {
		return memberEmail;
	}
	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
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
	public String getEmailAgree() {
		return emailAgree;
	}
	public void setEmailAgree(String emailAgree) {
		this.emailAgree = emailAgree;
	}
}