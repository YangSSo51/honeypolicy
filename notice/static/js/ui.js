
$(document).ready(function(){
    if($(this).width() < 1070) {
        $("html").removeClass().addClass("mobile");
		$(".skip_nav .go_gnb").attr("href","#m_gnb")
    }else{
        $("html").removeClass().addClass("pc");
		$(".skip_nav .go_gnb").attr("href","#pc_gnb")
    }

	// header
	var header_h = $(".header").height()
	$(".wrap").css("padding-top", header_h)
	

	// mobile gnb 열기
    $(".header .btn_gnb").on("click", function(){
		$("body").addClass("fixed");
		$(".header").addClass("gnb_active");
		$(".m_gnb_wrap .gnb_wrap").addClass("open");
        $(".m_gnb_wrap .gnb_wrap").animate({"right":"0"});
		$(".m_gnb_wrap .gnb_wrap + .btn_close").show();
		$(".header_ban").hide()

		if($(".top_banner").is(":visible")){
			$(".top_banner").addClass("show").hide();
		}
		var header_h = $(".header").height()
		$(".wrap").css("padding-top", header_h)
    })

	$(".skip_nav .go_gnb").on("click", function(){
		if($(this).width() < 1070){
		$("body").addClass("fixed");
		$(".header").addClass("gnb_active");
			$(".m_gnb_wrap .gnb_wrap").addClass("open")
			$(".m_gnb_wrap .gnb_wrap").animate({"right":"0"})
			$(".m_gnb_wrap .gnb_wrap + .btn_close").show();
			$(".header_ban").hide()

			if($(".top_banner").is(":visible")){
				$(".top_banner").addClass("show").hide();
			}
			var header_h = $(".header").height()
			$(".wrap").css("padding-top", header_h)
		}
	})

	// mobile gnb 닫기
    $(".gnb_wrap + .btn_close").on("click", function(){
		$("body").removeClass("fixed");
		$(".header").removeClass("gnb_active");
        $(".m_gnb_wrap .gnb_wrap").animate({"right":"-100%"}, function(){
			$(".m_gnb_wrap .gnb_wrap").removeClass("open")
		})
		$(".m_gnb_wrap .gnb_wrap + .btn_close").hide();
		$(".header .btn_gnb").focus();

		if($(".top_banner").hasClass("show")){
			$(".top_banner").removeClass("show").show();
		}
		var header_h = $(".header").height()
		$(".wrap").css("padding-top", header_h)

		setTimeout(function(){$(".header_ban").fadeIn()}, 500)
    });
	
	// mobile gnb 메뉴 선택 시
	$(".m_gnb_wrap .gnb_list > li > a").on("click", function(){
		if($(this).hasClass("on")){
			$(this).next(".dep2").slideUp();
			$(this).removeClass("on")
		} else{
			$(".m_gnb_wrap .gnb_list > li > a").removeClass("on")
			$(".m_gnb_wrap .gnb_list > li .dep2").slideUp();
			$(this).next(".dep2").slideDown();
			$(this).addClass("on")
		}
	})
	
	// pc gnb 열기
	$(".pc_gnb_wrap .gnb_wrap .gnb_list").on("mouseenter focusin", function(){
		if($(".allmenu_wrap .btn_allmenu").hasClass("open")){
			return false;
		}
		$(".pc_gnb_wrap .gnb").append("<div class='pc_bg'></div>")
		$(".pc_gnb_wrap .gnb_wrap .gnb_list .dep2, .pc_gnb_wrap .pc_bg").stop().slideDown();
		
	})
	
	// pc gnb 닫기
	$(".pc_gnb_wrap .gnb_wrap .gnb_list").on("mouseleave focusout", function(){
		$(".pc_gnb_wrap .gnb_wrap .gnb_list .dep2, .pc_gnb_wrap .pc_bg").stop().slideUp(function(){
			$(".pc_gnb_wrap .gnb .pc_bg").remove()
		});
		
	});

	$(".pc_gnb_wrap .gnb_wrap .gnb_list > li, .allmenu > ul > li").on("mouseenter focusin", function(){
		if($(window).width() > 1070){
			$(this).addClass("over")
		}
	});

	$(".pc_gnb_wrap .gnb_wrap .gnb_list > li, .allmenu > ul > li").on("mouseleave focusout", function(){
		if($(window).width() > 1070){
			$(this).removeClass("over")
		}
	});
	
	// pc 전체메뉴 열기
	$(".allmenu_wrap .btn_allmenu").on("click", function(){
		$(this).addClass("open")
		$(".allmenu").stop().slideDown();
		$(".allmenu_wrap .btn_allmenu_close").show();
	})
	
	// pc 전체메뉴 닫기
	$(".allmenu_wrap .btn_allmenu_close").on("click", function(){
		$(this).hide();
		$(".allmenu_wrap .btn_allmenu").removeClass("open")
		$(".allmenu").stop().slideUp();
			
	})
	
	// mobile 검색영역 열기
	$(".header .btn_search").on("click", function(){
		if($(".m_gnb_wrap .gnb_wrap").hasClass("open")){
			$(".header").removeClass("gnb_active")
			$(".m_gnb_wrap .gnb_wrap").animate({"right":"-100%"}, function(){
				$(".gnb_wrap").removeClass("open")
			})
			$(".gnb_wrap + .btn_close").hide();
		}
		$(".header .search_wrap").fadeIn();
		$(".header .search_wrap .txt_search").focus();
		$(this).addClass("open")

		if($(".top_banner").hasClass("show")){
			$(".top_banner").removeClass("show").show();
		}
		var header_h = $(".header").height()
		$(".wrap").css("padding-top", header_h)

	})
	
	// mobile 검색영역 닫기
	$(".header .search_wrap .btn_search_close").on("click", function(){
		$(".header .btn_search").focus();
		$(".header .search_wrap").fadeOut();
	})

	// TOP 버튼
	$(".btn_page_top").hide();
	$(".btn_page_top").on("click", function(){
		$("html, body").animate({scrollTop:0}, 500);
		return false;
	});

	$(window).scroll(function(){
		if($(window).width() > 1069){
			if($(window).scrollTop() > 200){
				$(".btn_page_top").fadeIn();
			} else{
				$(".btn_page_top").fadeOut();
			}

			var f_offset = $(".footer").offset().top;
			var f_h = $(".footer").height();
			if($(window).scrollTop() + $(window).height() > f_offset+f_h-160){
				$(".btn_page_top").addClass("position")
			} else {
				$(".btn_page_top").removeClass("position")
			}
		}
	})

	if($(window).width() < 1600){
		$(".btn_page_top").css({"right":"15px","margin-right":"0"});
		if($(window).width() < 1070){
			$(".btn_page_top").hide()
		}
	}else{
		$(".btn_page_top").css({"right":"50%","margin-right":"-760px"})
	}

	// 관련사이트
	$(".footer .dropdown_pc > p a").attr("title","관련사이트 목록 열기");
	$(".footer .dropdown_pc > p a").on("click", function(){
		if($(this).hasClass("open")){
			$(this).removeClass("open").attr("title","관련사이트 목록 열기").parent("p").next("ul").stop().slideUp()
		} else {
			$(this).addClass("open").attr("title","관련사이트 목록 닫기").parent("p").next("ul").stop().slideDown()	
		}
	})

	//Datepicker
	$(".datepicker").datepicker({
		changeYear: true, 
		changeMonth: true, 
		dateFormat: "yy-mm-dd",
		showMonthAfterYear: true,
		monthSuffix: "년",
		dayNames: ['일요일','월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
		dayNamesMin: ['일','월', '화', '수', '목', '금', '토'],  
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		numberOfMonths: [1,1],
		buttonImage: "/images/common/icon_cal.png",
		buttonText: "달력 열기",
		showOn: "button",
		yearRange: "c-50:c+10"
	})

	// location
	$(document).on("click", ".location .location_list > li > button", function(){
		if($(this).hasClass("active")){
			$(this).attr("title","메뉴열기")
			$(this).removeClass("active").next("ul").stop().slideUp();
		} else {
			$(this).attr("title","메뉴닫기")
			$(this).addClass("active").next("ul").stop().slideDown();
			$(this).parent().siblings("li").find("button").removeClass("active")
			$(this).parent().siblings("li").find(">ul").stop().slideUp();
		}
	})
	
	if($(window).width()<1070){
		$(".ad-info a.tooltip").on("click", function(){
			if($(this).hasClass("open")){
				$(this).next(".layer-tooltip").css("display","none")
				$(this).removeClass("open")
			} else {
				$(this).next(".layer-tooltip").css("display","block")
				$(this).addClass("open")
			}
			return false
		})
	}
	
	if($(window).width()>1069){
		$(".ad-info a.tooltip").mouseenter(function(){
			$(this).next(".layer-tooltip").css("display","block")
		})

		$(".ad-info em.tooltip").mouseleave(function(){
			$(this).find(".layer-tooltip").css("display","none")
		})

		$(".ad-info a.tooltip").on("focusin", function(){
			$(this).next(".layer-tooltip").css("display","block")
		})

		$(".ad-info a.tooltip").on("focusout", function(){
			$(this).next(".layer-tooltip").css("display","none")
		})

		$(".ad-info em.tooltip").each(function(){
			if($(this).position().left > 1200){
				$(this).addClass("right")
			}
		})
	}

	$(".skip_nav .go_content").on("click", function(){
		$("html,body").animate({scrollTop:0});
	})

	$("em.tooltip a.tooltip").attr("href","#n")
	$("em.tooltip .layer-tooltip").removeAttr("id");
	$("em.tooltip a.tooltip i").each(function(){
		$(this).text("툴팁")
	})

	$(".ply-view-section a[target='_blank']").attr("title","새창열림")
		
})

//lnb
function menuHighlight(dep1, dep2){
	var dep1 = dep1 - 1;
	var dep2 = dep2 - 1;
	var dep1_txt = $(".location_list > li").eq(0).find(">ul li").eq(dep1).text();
	var dep2_txt = $(".location_list > li").eq(1).find(">ul li").eq(dep2).text();

	$(".location_list > li").eq(0).find(">button").text(dep1_txt);
	$(".location_list > li").eq(1).find(">button").text(dep2_txt);

}

$(window).resize(function () {
    if (this.resizeTO) {
        clearTimeout(this.resizeTO);
    }
    this.resizeTO = setTimeout(function () {
        $(this).trigger("resizeEnd");
    }, 100);
});

$(window).on("resizeEnd", function () {

    if($(this).width() < "1070") {
        $("html").removeClass().addClass("mobile");
		$(".skip_nav .go_gnb").attr("href","#m_gnb")
    }else{
        $("html").removeClass().addClass("pc");
		$(".skip_nav .go_gnb").attr("href","#pc_gnb")
		
		$(".header").removeClass("gnb_active")
        $(".m_gnb_wrap .gnb_wrap").animate({"right":"-100%"}, function(){
			$(".m_gnb_wrap .gnb_wrap").removeClass("open")
		})
		$(".m_gnb_wrap .gnb_wrap + .btn_close").hide();
    }
	
	var header_h = $(".header").height()
	$(".wrap").css("padding-top", header_h)

	if($(window).width() < 1600){
		$(".btn_page_top").css({"right":"15px","margin-right":"0"});
		if($(window).width() < 1070){
			$(".btn_page_top").hide()
		}
	}else{
		$(".btn_page_top").css({"right":"50%","margin-right":"-760px"})
	}

	if($(window).width()<1070){
		$(".ad-info a.tooltip").on("click", function(){
			if($(this).hasClass("open")){
				$(this).next(".layer-tooltip").css("display","none")
				$(this).removeClass("open")
			} else {
				$(this).next(".layer-tooltip").css("display","block")
				$(this).addClass("open")
			}
		})
	}
	
	if($(window).width()>1069){
		$(".ad-info a.tooltip").mouseenter(function(){
			$(this).next(".layer-tooltip").css("display","block")
		})

		$(".ad-info em.tooltip").mouseleave(function(){
			$(this).find(".layer-tooltip").css("display","none")
		})

		$(".ad-info a.tooltip").on("focusin", function(){
			$(this).next(".layer-tooltip").css("display","block")
		})

		$(".ad-info a.tooltip").on("focusout", function(){
			$(this).next(".layer-tooltip").css("display","none")
		})

		$(".ad-info em.tooltip").each(function(){
			if($(this).position().left > 1200){
				$(this).addClass("right")
			}
		})
	}
	
});