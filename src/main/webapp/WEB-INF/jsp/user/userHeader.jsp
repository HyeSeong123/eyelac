<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<form name="uriForm" method="POST">
	<input type="hidden" name="requestURI" value="${requestURI}">
</form>

<c:if test="${loginedMember.getPwStatus() != change}">
	<div class="changePwMember">임시 비밀번호를 발급 받으신 상태 입니다. 비밀번호를 변경해주세요. <a href="/user/member/identification.do">비밀번호 변경하러 가기</a></div>
</c:if>
<header>
	<section class="header_container height-100p">
		<section class="header_min_container height-100p">
		
			<div class="header height-100p flex">
				<div class="header_logo_title height-100p flex flex-ai-c">
					<a class="logo" href="/user/index.do"> <h2 class="" style="margin-bottom:0"><span>Eyelac</span> <span class="">Brow</span></h2> </a>
				</div>
				
				<div class="header_menu height-100p flex flex-ai-c header_pc">
					<ul class="flex">
						<c:forEach items="${boards}" var="board">
							<li>
								<c:forEach items="${boards3}" var="board3">
									<c:if test="${board3.parentCode == board.boardCode}">
										<a href="${board.boardUrl}">${board.boardName}</a> <span class="header_menu_downArrow"><i class="fas fa-sort-down"></i></span>	
									</c:if>
									
									<c:if test="${board3.parentCode != board.boardCode}">
										<a href="${board.boardUrl}">${board.boardName}</a>	
									</c:if>
								</c:forEach>
								<ul>
									<c:forEach items="${boards2}" var="board2">
										<c:if test="${board2.parentCode eq board.boardCode }">
											<li><a href="${board2.boardUrl}">${board2.boardName}</a></li>
										</c:if>
									</c:forEach>
								</ul>
							</li>
						</c:forEach>
					</ul>
				</div>
				
				<div class="header_sns height-100p flex flex-ai-c header_pc">
					<ul class="flex">
						<li>
							<a target="_blank" href="https://www.instagram.com/eyelac_brow/"><i class="fab fa-instagram"></i></a>
						</li>
						<li>
							<a target="_blank" href="https://open.kakao.com/o/s7O9Cqvd"><i class="fas fa-comment"></i></a>
						</li>
						<c:if test="${loginedMember == null}">
							<li>
								<a href="/user/member/login.do?afterLoginURI=${requestURI}" class=""><i class="fas fa-lock"></i></a>
							</li>
							<li>
								<a href="/user/member/join_policy.do?returnUrl=${requestURI}" class=""><i class="fas fa-sign-in-alt"></i></a>
							</li>
						</c:if>
						
						<c:if test="${loginedMember != null}">
							<li>
								<a href="/user/member/logout.do?afterLoginURI=${requestURI}" class=""><i class="fas fa-lock-open"></i></a>
							</li>
							<li>
								<a href="javascript:openIdentification();" class=""><i class="fas fa-user"></i></a>
							</li>
						</c:if>
					</ul>
				</div>
				
				<div class="header_mobile_blank"></div>
				
				<div class="header_hamburger header_mobile height-100p">
					<div></div>
					<div></div>
					<div></div>
				</div>
			</div>
		</section>
	</section>
	
	<div class="header_mobile header_mobile_menu">
		<div class="mobile_menu_top">
			<div class="mobile_menu_blank"></div>
			<div class="mobile_menu_logo">Eyelac Brow</div>
			<div class="mobile_menu_exit"><span><i class="fas fa-times"></i></span></div>
		</div>
		
		<div class="mobile_menu_middle">
			<ul class="flex flex-column">
				<c:forEach items="${boards}" var="board">
					<li class="flex flex-column">
						<c:forEach items="${boards3}" var="board3">
							<c:if test="${board3.parentCode == board.boardCode}">
								<a href="javascript:void(0)" onclick="openSubmenu();">
									${board.boardName}
									<span class="header_menu_downArrow"><i class="fas fa-sort-down"></i></span>
								</a>	
							</c:if>
							
							<c:if test="${board3.parentCode != board.boardCode}">
								<a href="${board.boardUrl}">${board.boardName}</a>	
							</c:if>
						</c:forEach>
						<ul>
							<c:forEach items="${boards2}" var="board2">
								<c:if test="${board2.parentCode eq board.boardCode }">
									<li><a href="${board2.boardUrl}">${board2.boardName}</a></li>
								</c:if>
							</c:forEach>
						</ul>
					</li>
				</c:forEach>
			</ul>
		</div>
		
		<div class="flex-grow-1"></div>
		
		<div class="mobile_menu_bottom">
			<ul class="flex">
				<li>
					<a target="_blank" href="https://www.instagram.com/eyelac_brow/"><i class="fab fa-instagram"></i></a>
				</li>
				<li>
					<a target="_blank" href="https://open.kakao.com/o/s7O9Cqvd"><i class="fas fa-comment"></i></a>
				</li>
				<c:if test="${loginedMember == null}">
					<li>
						<a href="/user/member/login.do?afterLoginURI=${requestURI}" class=""><i class="fas fa-lock"></i></a>
					</li>
					<li>
						<a href="/user/member/join_policy.do?returnUrl=${requestURI}" class=""><i class="fas fa-sign-in-alt"></i></a>
					</li>
				</c:if>
				
				<c:if test="${loginedMember != null}">
					<li>
						<a href="/user/member/logout.do?afterLoginURI=${requestURI}" class=""><i class="fas fa-lock-open"></i></a>
					</li>
					<li>
						<a href="/user/member/myInfor.do?" class=""><i class="fas fa-user"></i></a>
					</li>
				</c:if>
			</ul>
		</div>
	</div>
</header>