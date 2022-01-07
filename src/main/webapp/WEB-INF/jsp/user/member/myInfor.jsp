<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<main class="flex flex-jc-c flex-ai-c width-100p" style="margin-top:30px;">
	<div class="main_container2">
		<div class="page_title_l">
			<h2>내 정보</h2>
		</div>
		
		<section class="profile_box">
			<div class="profile_title profile1_title">
				<span>프로필</span>
			</div>
			<div class="profile_content profile1_content flex flex-ai-c">
				<div class="profile_img">
					<div class="img_box">
						<img src="/images/예비이미지.jpg" alt="">
					</div>
				</div>
				<div class="fBox_2 flex-column emailNameBox">
					<div class="profile_email">${member.memberEmail}</div>
					<div  class="profile_name">${member.memberName}</div>
				</div>
			</div>
		</section>
		
		<section class="profile_box">
			<form method="POST" name="profile_change" id="profile_change">
				<div class="profile_title profile1_title">
					<span>개인 정보</span>
				</div>
				<div class="profile_content profile1_content flex flex-ai-c">
					<div style="padding-top : 15px;" class="profile_opt">
						<span>휴대전화 번호</span>
						<input type="text" name="profile_phNum" value="${member.memberPhnum}">
					</div> 
				</div>
				<div class="profile_content profile1_content flex flex-ai-c">
					<div class="profile_opt">
						<span>닉네임</span>
						<input type="text" name="profile_nickname" value="${member.memberNickname}">
					</div>
				</div>
				<div class="profile_content profile1_content flex flex-ai-c">
					<div style="padding-bottom : 15px;" class="profile_opt">
						<span>생일</span>
						<input type="text" name="profile_birth" value="${member.memberBirth}">
					</div>
				</div>
				
				<div class="btn_box btn_2 profile_changBtn">
					<button onclick="modify_profile();">수정</button>
					<button onclick="return_profile();">취소</button>
				</div>
			</form>
		</section>
	</div>
</main>
