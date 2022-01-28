<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Eyelac_Brow</title>
	<meta name="_csrf" th:content="${_csrf.token}">
	<meta name="_csrf_header" th:content="${_csrf.headerName}">
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
	<link rel="stylesheet" href="/css/default.css">
	<link rel="stylesheet" href="/css/style.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
	<!-- 부트스트랩  -->
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.9.0/gsap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.9.0/ScrollTrigger.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
	
	<meta name="description" content="아일락 눈썹 전문 샵 입니다." />
	<meta property="og:locale" content="ko_KR" />
	<meta property="og:type" content="site" />
	<meta property="og:title" content="Eyelac Beauty Salon" />
	<meta property="og:description" content="탄방동, 대전, 눈썹, 눈썹정리, 눈썹문신, 아일락, Eyelac" />
	<meta property="og:url" content="eyelac.shop" />
	<meta property="og:site_name" content="Eyelac Beauty Salon" />
	<link rel="icon" href="/images/favicon.ico" />
</head>
<body>
	<tiles:insertAttribute name="userHeader" />
	
	<section>
		<div class="identPopupBox"></div>
		<tiles:insertAttribute name="userContents" />
	</section>
	
	<tiles:insertAttribute name="userFooter" />
	
	<script src="/js/common.js"></script>
	<script src="/js/member.js"></script>
	<script src="https://cdn.jsdelivr.net/gh/hi098123/prism-for-tistory/prism.js"></script>
</body>
</html>