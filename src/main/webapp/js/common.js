function movePage(page){
	if(page == $(location).attr('pathname') ){
		page = "/index.do";
	}
	
	location.href= page;
}
function fn_pageMove(moveUrl){
	var frm = document.uriForm;
	frm.method = "POST";
	frm.action = moveUrl;
	frm.submit();
}

function fadeInMobileHead(){
	let header_menu = $('.header_mobile_menu');
	let body = $('body');
	header_menu.addClass('active');
	
	if( header_menu.hasClass('active') ){
		body.css('overflow', 'hidden');
		body.css('touch-action', 'none');
		
		header_menu.fadeIn();
		header_menu.css('display', 'flex');
	}
}

function fadeOutMobileHead(){
	let header_menu = $('.header_mobile_menu');
	let body = $('body');
	header_menu.removeClass('active');
	body.css('overflow', 'auto');
	body.css('touch-action', 'auto');
	
	header_menu.fadeOut();
}

function openSubmenu(){
	let parent = $(event.target).closest('li').children('ul');
	
	$(event.target).closest('li').addClass('openSubMenu');
	
	if( ! parent.hasClass('active') ){
		parent.stop();
		parent.slideDown();
		parent.addClass('active');
	} else if ( parent.hasClass('active') ){
		parent.stop();
		parent.slideUp();
		parent.removeClass('active');
		$(event.target).closest('li').removeClass('openSubMenu');
	}
}

let main_section1 = '';
let main_section2 = '';
let main_section3 = '';
let main_section4 = '';

let curUrl = $(location).attr('pathname');

if ( curUrl.includes('index.do') ){
	main_section1 = $('#main_section1');
	main_section2 = $('#main_section2');
	main_section3 = $('#main_section3');
	main_section4 = $('#main_section4');
}

function smooth_scroll(section){
	
	let ele = "#" + section;
	
	if ( ! curUrl.includes('/user/index.do') ){
		movePage('/user/index.do' + ele);
	}
	
	let li = $('.mobile_menu_middle ul li');
	let children = $('.mobile_menu_middle ul li ul');
	
	li.removeClass('openSubMenu');
	children.removeClass('active');
	children.stop();
	children.slideUp();
	
	$('.header_mobile_menu').removeClass('active');
	$('.header_mobile_menu').fadeOut();
	
	$('body').css('overflow', 'auto');
	$('body').css('touch-action', 'auto');
	
	
	
	let scrollPosition = $(ele).offset().top;
	
	window.scroll({top: scrollPosition, behavior: 'smooth'});
}

$('html').click(function(e){
	let li = $('.mobile_menu_middle ul li');
	let children = $('.mobile_menu_middle ul li ul');
	
	if( ! $(e.target).closest('li').hasClass('openSubMenu') ){
		li.removeClass('openSubMenu');
		children.removeClass('active');
		children.stop();
		children.slideUp();
	}
	
})

$('.header_menu ul li').hover(function(){
	let sldUl = $(this).children('ul');
	$(this).children('ul').stop();
	$(this).children('ul').slideDown();
}, function(){
		let sldUl = $(this).children('ul');
		$(this).children('ul').stop();
		$(this).children('ul').slideUp();
	}
);

$('.header_hamburger').click(function (){
	document.querySelector('.header_mobile_menu').style.height = window.innerHeight + "px";
	fadeInMobileHead();
});

$(window).resize(function(){
	fadeOutMobileHead();
});

$('.mobile_menu_exit span').click(function(){
	fadeOutMobileHead();
});

$.datepicker.setDefaults({
	dateFormat : 'yy-mm-dd',
	prevText : '이전 달',
	nextText : '다음 달',
	monthNames : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	dayNames : ['일','월','화','수','목','금','토'],
	dayNamesShort : ['일','월','화','수','목','금','토'],
	dayNamesMin : ['일','월','화','수','목','금','토'],
	showMonthAfterYear : false,
	changeMonth : true,
	changeYear : true,
	yearSuffix : '년',
	yearRange : 'c-70:c+1',
});

$( function() {
	$( "#datepicker" ).datepicker();
});
function sweetAlert(title, text, icon, inputName){
	swal({
		title : title,
		text : text,
		icon : icon
	}).then(function(){
		inputName.focus();
	})
}

function openIdentification(){
	let identBox = document.querySelector('.identPopupBox');
	
	identBox.classList.add('active');
	
	let identBoxDiv = document.createElement('div');
	let identHead = document.createElement('section');
	let identBody = document.createElement('section');
	identBox.appendChild(identBoxDiv);
	identBoxDiv.appendChild(identHead);
	identBoxDiv.appendChild(identBody);
	identBoxDiv.firstChild.classList.add('identHead');
	identBoxDiv.lastChild.classList.add('identBody');
	identHead.innerHTML = '본인확인 화면';
	identBody.innerHTML = '내용';
}
