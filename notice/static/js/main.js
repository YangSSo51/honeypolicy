$(document).ready(function(){

	/* header fixed
	var header_offset = $(".header").offset().top;
	console.log(header_offset)
	if($(window).width()<1070){
		$(window).scroll(function(){
			if($(window).scrollTop() > header_offset){
				$(".header").addClass("fixed");
				$(".wrap").addClass("pd");
			} else {
				$(".header").removeClass("fixed")
				$(".wrap").removeClass("pd");
			}
		})
	}
	*/

	// 퀵메뉴
	$(".quick_menu ul li").eq(0).find("a").addClass("active")
	$(".quick_menu ul li a").hover(function(){
		$(".quick_menu ul li a").removeClass("active");
		$(this).addClass("active");
	}, function(){
		//$(".quick_menu ul li a").removeClass("active");
	});

	// 비쥬얼 슬라이더
	$(".visual_slider").slick({
		autoplay: true,
		autoplaySpeed: 7000,
		speed: 1000,
		infinite: true,
		arrows: true,
		dots: true
	});

	// 청년정책 슬라이더
	$(".policy_list .slider-for").slick({
		slidesToShow: 1,
		slidesToScroll: 1,
		infinite: false,
		arrows: true,
		adaptiveHeight:true,
		asNavFor: '.policy_list .slider-nav'
	});

	$(".policy_cont ul li").eq(0).find("a").addClass("active")
	$(".policy_list .slider-for").on("afterChange", function(event, slick, currentSlide, nextSlide){
		$(".policy_cont.slick-active ul li").eq(0).find("a").addClass("active")
	});

	$(".policy_list .slider-nav").slick({
		slidesToShow: 4,
		slidesToScroll: 1,
		infinite: false,
		arrows: false,
		asNavFor: '.policy_list .slider-for',
		focusOnSelect: true
	});

	// 청년정책
	$(".main_cont03 .policy_cont ul li a").hover(function() {
		$(this).addClass("active");
	}, function() {
		$(this).removeClass("active");
	}
	);

	// 배너 슬라이더
	$(".banner_slider").slick({
		autoplay: true,
		autoplaySpeed: 5000,
		speed: 1000,
		infinite: true,
		arrows: true,
		dots: true
	});

	// 청년공간 Tab
	$(".space_search .tab01 .tab_btn").addClass("active");
	$(".space_search .tab_btn").on("click", function(){
		$(".space_search .tab_btn").removeClass("active")
		$(this).addClass("active")
	})

	// 청년공간 img 위치 조절
	$(".main_cont04 .space_result .space_slider ul li .img").find("img").each(function(){
		var w = $(this).width();
		var	h = $(this).height();

		if (w < h) {
			$(this).parent().addClass("mih")
		} else {
			$(this).parent().addClass("miw")
		}
	});

	// 청년공간 > 공간간편검색
	$(".main_cont04 .space_search .btn_search").on("click", function(){
		//$(".main_cont04 .space_result").attr("tabindex",0).focus();
	})

	// 청년공간 > 전국청년공간지도
	$(".main_cont04 .space_search .tab01 .tab_cont ul li a").on("click", function(){
		//var area_name = $(this).text();
		//$(".main_cont04 .space_search .tab02 .tab_cont .tit .area_name").text(area_name)
		//$(".main_cont04 .space_result").attr("tabindex",0).focus();
	})


	$(".main_cont04 .map_area a").mouseenter(function(){
		if($(window).width()>1050){
			var map_a = $(this).attr("class");
			$(this).find("span").addClass("active")
			$(".main_cont04 .map_area img").attr("src","images/main/"+map_a+".png")
		}
	})

	$(".main_cont04 .map_area a").focusin(function(){
		if($(window).width()>1050){
			var map_a = $(this).attr("class");
			$(this).find("span").addClass("active")
			$(".main_cont04 .map_area img").attr("src","images/main/"+map_a+".png")
		}
	})

	$(".main_cont04 .map_area a").mouseleave(function(){
		if($(window).width()>1050){
			$(".main_cont04 .map_area a").find("span").removeClass("active")
		}
	})

	$(".main_cont04 .map_area a").focusout(function(){
		if($(window).width()>1050){
			$(".main_cont04 .map_area a").find("span").removeClass("active")
		}
	})

	$(".main_cont04 .map_area a").on("click", function(){
		if($(window).width()>1050){
			var map_a = $(this).attr("class");
		}
	})

	// 청년공간 슬라이더
	$(".space_slider").slick({
		autoplay: true,
		autoplaySpeed: 3500,
		speed: 1000,
		infinite: true,
		arrows: true,
		dots: true
	});

	// 동영상 리스트 슬라이더
	$(".video_slider").slick({
		autoplay: true,
		autoplaySpeed: 3500,
		speed: 1000,
		slidesToShow: 4,
		slidesToScroll: 4,
		infinite: true,
		arrows: true,
		dots: true,
		responsive: [
			{
			  breakpoint: 1070,
			  settings: {
				slidesToShow: 3,
				slidesToScroll: 3,
				infinite: true,
				dots: true
			  }
			},
			{
			  breakpoint: 768,
			  settings: {
				slidesToShow: 2,
				slidesToScroll: 2
			  }
			}
		  ]
	});

	// 메인비주얼 정지,재생 버튼 생성
	$(".main_cont01 .slick-dots, .main_cont03 .slick-dots, .main_cont04 .slick-dots").wrap("<div class=\"dots_wrap\">");
	$(".dots_wrap").append("<button type=\"button\" class=\"btn_play\" onclick=\"SliderPlay(this);\"><span class=\"blind\">재생</button>");
	$(".dots_wrap").append("<button type=\"button\" class=\"btn_stop\" onclick=\"SliderStop(this);\"><span class=\"blind\">정지</button>");

	// 동영상 슬라이더 재생,정지버튼 위치
	$(window).load(function(){
		var arrow_wrap_wid = $(".main_cont06 .slick-dots").width()
		var arrow_wrap_top = $(".main_cont06 .slick-dots button").position().top;
		$(".main_cont06 .play_btn_wrap").css({"margin-left":arrow_wrap_wid / 2, "top":arrow_wrap_top})
	})

})

// 슬라이더 재생
function SliderPlay(obj){
	var t = $(obj).parents(".slick-slider");
	t.slick("slickPlay");
}

// 슬라이더 정지
function SliderStop(obj){
	var t = $(obj).parents(".slick-slider");
	t.slick("slickPause");
}

// 슬라이더 재생 - 동영상슬라이더
function SliderPlay2(obj){
	var t2 = $(obj).parent(".play_btn_wrap").prev(".slick-slider");
	t2.slick("slickPlay");
}

// 슬라이더 정지 - 동영상슬라이더
function SliderStop2(obj){
	var t2 = $(obj).parent(".play_btn_wrap").prev(".slick-slider");
	t2.slick("slickPause");
}

// 리사이즈시
$(window).resize(function () {
	if (this.resizeTO) {
		clearTimeout(this.resizeTO);
	}
	this.resizeTO = setTimeout(function () {
		$(this).trigger("resizeEnd");
	}, 100);
});

$(window).on("resizeEnd", function () {
	$(document).ready(function(){
		var arrow_wrap_wid = $(".main_cont06 .slick-dots").width()
		var arrow_wrap_top = $(".main_cont06 .slick-dots button").position().top;
		$(".main_cont06 .play_btn_wrap").css({"margin-left":arrow_wrap_wid / 2, "top":arrow_wrap_top})
	})
});