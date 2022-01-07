<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<script>
	function changeActive(){
		$('#member_pw').toggleClass('active');
		if( $('#member_pw').hasClass('active') ){
			$('#member_pw').attr('type' , 'text');
			
		} else {
			$('#member_pw').attr('type', 'password');
		}
	}
</script>

<main class="flex flex-jc-c flex-ai-c width-100p" style="margin-top:30px;">
	<div class="main_container">
		<div class="login_box">
			<form action="/member/myInfor.do" method="POST">
				<input type="hidden" name="afterLoginURI" value="${param.afterLoginURI}" />
				<input type="hidden" name="memberId" value="${loginedMember.id}">
				<div class="login_input_box"> 
					<label>
						<input name="member_pw" id="member_pw" type="password" required />
						<div class="label-text"> 패스워드 <a class="showPassword" href="javascript:changeActive();"> <i class="far fa-eye"></i></a></div>
					</label>
				</div>
				
				<c:if test="${param.err == true}">
					<section class="login_alert">아이디와 비밀번호가 일치하지 않습니다</section>
				</c:if>
				
				<section class="login_btn_box flex height-100p flex-jc-ar">
					<div class="btn_login-box">
						<button type="submit" value="Submit">내 정보 확인</button>
					</div>
				</section>
			</form>
		</div>
		
	</div>
</main>