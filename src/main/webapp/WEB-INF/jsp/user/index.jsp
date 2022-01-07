<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="/js/instafeed.min.js"></script>

<main>
	
	<div class="right_ball">
		<a href="javascript:smooth_scroll('main_section1')"><div class="active"></div></a>
		<a href="javascript:smooth_scroll('main_section2')"><div></div></a>
		<a href="javascript:smooth_scroll('main_section3')"><div></div></a>
		<a href="javascript:smooth_scroll('main_section4')"><div></div></a>
	</div>
	
	<section class="main_wrapper" id="main_section1">
		<div class="center_title">
			<h1>EYELAC</h1>
			<h1>BROW</h1>
			<h3>- Beauty Salon -</h3>
		</div>
		
		<div class="main_wrapper_arrow">
			<a href="javascript:smooth_scroll('main_section2')"><i class="fas fa-chevron-down"></i></a>
		</div>
	</section>
	
	<section class="main_wrapper_2" id="main_section2">
		<div class="wrap">
			<h1 class="main_wrapper2_logoBox">
				<span class="main_wrapper2_logo1">ABOUT.</span>
			</h1>
			
			<div class="main_wrapper2_left_imgBox">
				<div class="img_box">
					<img alt="" src="/images/eyebrow2.jpg">
				</div>
			</div>
			
			<div class="main_wrapper2_manual">
				<p>
					대전 눈썹미용 전문점 아일락 입니다.<br/>
				</p>
				<p>
					탄방동에 위치하며, 역에서 5분거리이고 건물에 주차장이 있어 주차가 가능합니다.
				</p>
				<p>
					Eyelac Blow는 100% 예약제이니 미리 예약해 주시기 바랍니다.
				</p>
				<p>
					홈페이지와 인스타그램에 여러 이벤트가 진행중이니 확인해 주시길 바라겠습니다.
				</p>
				<p>
					세부적인 문의는 이메일과 오픈채팅으로 하실 수 있습니다.
				</p>
				<p>
					예약과 상담은 오픈채팅으로 하실 수 있습니다.
				</p>
				<p>
					<br/> 또 방문해주시고 좋은 하루 되세요 :)
				</p>
			</div>
		</div>
	</section>
	
	<section class="main_wrapper_3" id="main_section3">
		<section class="main_background flex flex-column flex-jc-c height-100p">
			<div class="section3_logo ">
				<h1>SERVICE</h1>
				<div class="price_infor">
					<ul>
						<li>
							<span class="pro_tit">눈썹문신</span>
							<span class="pro_pri">150,000</span>
							<span class="pro_eve">100,000 <span class="pro_eve_attr">(이벤트)</span></span>
						</li>
						<li>
							<span class="pro_tit">헤어라인</span>
							<span class="pro_pri">180,000</span>
							<span class="pro_eve"></span>
						</li>
						<li>
							<span class="pro_tit">미인점</span>
							<span class="pro_pri">30,000</span>
							<span class="pro_eve"></span>
						</li>
						<li>
							<span class="pro_tit">속눈썹펌</span>
							<span class="pro_pri">25,000</span>
							<span class="pro_eve"></span>
						</li>
					</ul>
					
					<div class="button_box">
						<a href="#" class="reser">예약하기 ></a>
					</div>
					
				</div>
			</div>
		</section>
	</section>
		
	<section class="main_wrapper_4" id="main_section4">
		<div class="container-fluid">
			<div class="portfolio_tit">
				<h1 class="">G A L L A R Y</h1>
			</div>
			<ul id="gallery" class="row"></ul>
		</div>
	</section>
	
	<article class="insta_popup">
		<section class="insta_popup_img"><div class="img_box"></div></section>
		<section class="flex flex-column insta_popup_titAndCon">
			<div class="insta_popup_top">
				<div class="insta_popup_logo">
					<div class="img_box"><img src="/images/eyelac_logo.jpg"></div>
				</div>
				<div class="insta_popup_title"><a href="https://www.instagram.com/eyelac_brow/" target="_blank">eyelac_brow</a></div>
				<div class="insta_popup_exit"><span><i class="fas fa-times"></i></span></div>
			</div>
			<div class="insta_popup_middle">
				<div class="insta_popup_content"></div>
			</div>
			<div class="insta_popup_bottom"></div>
		</section>
	</article>
	
	<script async>
		function test(id){
			let origin = $('.' + id);
			let content = origin.children('span').html();
			let img = origin.find('#insta_img').attr("src");
			let instaPopup = $('.insta_popup');
			
			$('.insta_popup_img .img_box').html('<img src=\"' + img + '\">');
			$('.insta_popup_content').html('<span>' + content +'</span>');
			
			instaPopup.fadeIn();
			
			instaPopup.css('display', 'flex');
			instaPopup.addClass('active');
			
			console.log(content.html());
			console.log(img);
		}
		$('.insta_popup_exit span').click(function(){
			let instaPopup = $('.insta_popup');
			instaPopup.fadeOut();
			instaPopup.removeClass('active');
		})
		
		$(document).keydown(function(event) {
			let instaPopup = $('.insta_popup');
		    if ( event.keyCode == 27 || event.which == 27 ) {
				instaPopup.fadeOut();
				instaPopup.removeClass('active');    
		    }
		});
		
	    var feed = new Instafeed({
	      target:'gallery',
	      template:'<li class=\"col-md-3 {{id}}\"><span onclick="test(\'{{id}}\')">{{caption}}</span><a class="insta-Bg_box" href="javascript:test(\'{{id}}\');"><img id="insta_img" title="{{caption}}" src="{{image}}" /></a></li>',
	      accessToken: 'IGQVJYU1MtVFQxamZAlMGJtNWpQS2hwMFdGS3c0RjY0RVAzaXFLYTdtd0M1Rkl0TjZAWSnNQanF2aUJIZA1d1MDUxMzJwbFR2d3JRdTYxVXd3T0xGVjdidUFmNXhWYzNKOEUzaWIxV3U1V3JYNjh5cXVYcwZDZD',
	      limit : 8
	    });
	    feed.run();
		
	</script>
	
	<script src="/js/main.js"></script>
</main>

	