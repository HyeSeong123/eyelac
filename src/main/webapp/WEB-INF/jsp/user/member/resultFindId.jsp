<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<main class="flex flex-jc-c flex-ai-c width-100p" style="margin-top:30px;">
	<div class="main_container">
		<c:if test="${memberName ne null and error eq null}">
			<div class="">
				<div class=""><h3>아이디 정보</h3></div>
			</div>
			<div class="">
				<span>회원님의 아이디는<strong>${memberId}</strong> 입니다.</span>
			</div>
			
			<div class="">
				<div class="">
					<a class="">로그인</a>
				</div>
				
				<div class="">
					<a class="">패스워드 찾기</a>
				</div>
			</div>
		</c:if>
		
		<c:if test="${error eq true}">
			<div class="">
				<h1 class=""><i class=""></i></h1>
				<p>
					잘못된 접근입니다.
				</p>
				
				<p>
					누적될 시 접근불가 조치될 수 있습니다.
				</p>
			</div>
		</c:if>
	</div>
</main>

<script>

</script>