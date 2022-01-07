gsap.registerPlugin(ScrollTrigger);

let windowWidth = $(window).width();
let currentWidth = 0;
$(window).resize(function(){
	windowWidth = $(window).width();
	setTimeout(function(){
		currentWidth = windowWidth;
	},1000);
});

let scr = 0;
$(window).scroll(function(){
	scr = $(window).scrollTop();
	
	let scrollPosition1 = $('#main_section1').offset().top - 60;
	let scrollPosition2 = $('#main_section2').offset().top - 150;
	let scrollPosition3 = $('#main_section3').offset().top - 250;
	let scrollPosition4 = $('#main_section4').offset().top - 400;
	
	let section1 = $('.right_ball > a:nth-child(1) > div ');
	let section2 = $('.right_ball > a:nth-child(2) > div ');
	let section3 = $('.right_ball > a:nth-child(3) > div ');
	let section4 = $('.right_ball > a:nth-child(4) > div ');
	
	if ( scr >= 0 && scr < scrollPosition2){
		section1.addClass('active');
		section2.removeClass('active');
		section3.removeClass('active');
		section4.removeClass('active');
	}
	if ( scr >= scrollPosition2 && scr < scrollPosition3){
		section1.removeClass('active');
		section2.addClass('active');
		section3.removeClass('active');
		section4.removeClass('active');
	}
	if ( scr >= scrollPosition3 && scr < scrollPosition4){
		section1.removeClass('active');
		section2.removeClass('active');
		section3.addClass('active');
		section4.removeClass('active');
	}
	if ( scr >= scrollPosition4){
		section1.removeClass('active');
		section2.removeClass('active');
		section3.removeClass('active');
		section4.addClass('active');
	}
})

function origin(){
//	let main2_img = $('.main_wrapper2_left_imgBox'); 
//	let main2_logo = $('.main_wrapper2_logoBox');
//	let main2_manual = $('.main_wrapper2_manual');
//	let main3_logo = $('.section3_logo');
	
	let main2_img = document.querySelector('.main_wrapper2_left_imgBox');
	let main2_logo = document.querySelector('.main_wrapper2_logoBox');
	let main2_manual = document.querySelector('.main_wrapper2_manual');
	let main3_logo = document.querySelector('.section3_logo');
	
	main2_img.classList.add('activeM');
	main2_logo.classList.add('activeM');
	main2_manual.classList.add('activeM');
	main3_logo.classList.add('activeM');
}

function move_section2(num){
	console.log(num);
//	let main = $('.main_wrapper');
//	let main2_img = $('.main_wrapper2_left_imgBox'); 
//	let main2_logo = $('.main_wrapper2_logoBox');
//	let main2_manual = $('.main_wrapper2_manual');
	
	let main = document.querySelector('.main_wrapper');
	let main2_img = document.querySelector('.main_wrapper2_left_imgBox'); 
	let main2_logo = document.querySelector('.main_wrapper2_logoBox');
	let main2_manual = document.querySelector('.main_wrapper2_manual');
	
	t1 = gsap.timeline({
		scrollTrigger : {
			trigger : main,
			start : "bottom 60%",
			toggleActions : 'restart none none reverse',
			end : "+=500",
		}
	});

	if(num == 1){
		t1.to(main2_img, { opacity : 1, y : -100, x:50, duration : 0.9 });
		t1.to(main2_logo, { opacity : 1, y : -200, duration : 0.7 }, -0.1);
		t1.to(main2_manual, { opacity : 1, y : -150, duration : 0.8 }, -0.1);
	}
	else if ( num == 2){
		t1.to(main2_img, { opacity : 1, y : -95, x:50, duration : 0.9 });
		t1.to(main2_logo, { opacity : 1, y : -100, duration : 0.7 }, -0.1);
		t1.to(main2_manual, { opacity : 1, y : -105, duration : 0.7 });
	}
}

function move_section3(num){
	let main = document.querySelector('#main_section2');
	let main3_logo = document.querySelector('.section3_logo');
	
	let t1 = gsap.timeline({
		scrollTrigger : {
			trigger : main,
			start : "90% center",
			toggleActions : 'restart none none reverse',
			end : "+=500",
		}
	});
	
	if(num==1){
		t1.to(main3_logo, { opacity :1, y : -70, duration : 1});
	}
	else if ( num == 2 ){
		t1.to(main3_logo, { opacity :1, y : -80, duration : 1});
	}
}


if ( windowWidth > 1000 ){
	move_section2(1);
	move_section3(1);
} else if ( windowWidth < 1000 ){
	move_section2(2);
	move_section3(2);
}

$(window).resize(function(){
	let reloadPage = windowWidth - currentWidth; 
	
	if ( reloadPage > 400 ){
		window.location.reload();
	}
});

if ( windowWidth > 1000 ){
	var t1 = gsap.timeline({
		repeat : -1,
		repeatDelay : 0.7
	});
	
	t1.to(".main_wrapper_arrow", {
		opacity : 1,
		y : 100,
		duration : 1.3
	});
}