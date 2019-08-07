


<!DOCTYPE html>
<html lang="ko">
<head>
	








<title>청년정책통합검색 &lt; 청년정책 | 온라인청년센터</title>
<meta name="_csrf_parameter" content="_csrf" /><meta name="_csrf_header" content="X-CSRF-TOKEN" /><meta name="_csrf" content="507c867f-72a1-4520-86d6-7daf8e4f91ab" />
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0">
<meta name="format-detection" content="telephone=no, address=no, email=no">
<meta name="description" content="고용노동부 -청년 대상 정책 안내, 공간 정보, 상담서비스 등 유익한 정보 제공">
<meta property="og:title" content="">
<meta property="og:description" content="">
<meta property="og:url" content="">
<meta property="og:image" content="https://www.youthcenter.go.kr/images/common/sns_logo.png">
<link rel="stylesheet" href="/css/reset.css?v=1.0">
<link rel="stylesheet" href="/css/common.css?v=1.0">
<link rel="stylesheet" href="/css/jquery-ui.css?v=1.0">
<link rel="stylesheet" href="/css/seon.css?v=1.0">
<link rel="stylesheet" href="/css/style.css?v=1.0">
<script src="/js/jquery-1.11.2.min.js?v=1.0"></script>
<script src="/js/jquery-ui.js?v=1.0"></script>
<script src="/js/ui.js?v=1.0"></script>
<script type="text/javascript" src="/js/keis.import.min.js?v=1.0"></script>
<script type="text/javascript">
//<![CDATA[
    
    var csUser = '';
	var spcUser = '';
   	var user = ''; // 아이디
           
	// 상담사 로그인 시, 상담쪽만 이용 가능 (2019.04.29 hgj)
   	if(csUser != '' && user == '' && spcUser == ''){
   		var uri = "/jynEmpSptNew/jynEmpSptList.do";
   		uri = uri.substring(0,10);
   		if(uri != '/jobConslt'){
   			location.href='/jobConslt/jobConsltList.do';
   		}
   	}
   	
 	// 공간 담당자 로그인 시, 공간쪽만 이용 가능 (2019.05.17 hgj)
   	if(spcUser != '' && user == '' && csUser == ''){
   		var uri = "/jynEmpSptNew/jynEmpSptList.do";
   		uri = uri.substring(0,7);
   		if(uri != '/jynSpc'){
   			location.href='/jynSpc/jynSpcList.do';
   		}
   	}

   	if(user != '' && csUser == '' && spcUser == ''){
   		
   		// 최초회원 약관 동의
   		if('' != 'Y'){
   	   		//alert('약관 동의 필요');
   			window.open("/member/custJoin/popYgmnCustAgree.do","최초 회원 약관 동의", "width=500, height=500");
   	   	}else{
   	   		
	   	   	var now = new Date();
	   	   	
	   		var lastUpdtDt = '';
	   		var cDate = new Date(parseInt(lastUpdtDt.substring(0,4))+2,lastUpdtDt.substring(4,6),lastUpdtDt.substring(6,8));
   	   		
   	  		// 기간 만료에 따른 약관 재동의
   	   		if(cDate < now){
   	   			//alert('기간 만료에 따른 약관 재동의 필요');
   	   			window.open("/member/custJoin/popInfoAgree.do","개인정보 수집 재동의", "width=500, height=500");
   	   		}
   	   	}
   		
   	}
 
	function f_responseIntgCustJoinAjax(resultObj){

		var object = JSON.parse(resultObj.ajaxResult);
		
		if(object.resultCd == "0000"){	
			var imsWebDomain = object.imsWebDomain;
			
			if(imsWebDomain.indexOf("https") > -1) {
				imsWebDomain = imsWebDomain.replace("https", "http");
			}
			if(object.intgType == "JOIN") {		
				window.open(imsWebDomain + "/linkApi.do?"+ object.linkUrl, 'intgIMSWEB');
			}
			else {
				window.open(imsWebDomain + "/linkApi.do?"+ object.linkUrl, 'intgIMSWEB','width=530,height=800,resizable=0,scrollbars=no,status=0,titlebar=0,toolbar=0,left=300,top=100');
			}
		}
		else {
			if(object.intgType == "JOIN")
				alert("One-ID시스템에 접속할 수 없어 통합회원(One-ID)\n가입을 할 수 없습니다.\n온라인청년센터 회원가입 화면으로 이동합니다.");
				location.href = "/member/custJoin/retrieveIndivCustClauseAgree.do?memType="+ object.ageType;
		}
	}
//]]>
</script>
</head>
<body>
	<div id="wrap" class="wrap">
		

	
	<script type="text/javascript" src="/js/youthcenter.snsLogin.js"></script>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#searchWordInput").keypress(function(event) {
				if(event.which == 13) {
					searchSubmit();
				}
			});
		});
		
		var f_logout = function() {
			
			if(!confirm("로그아웃 하시겠습니까?")) {
				return;	   		
			}
			
			f_logout2();
		};
	
		var f_logout2 = function() {
	
			$.ajax({
				'url'		: '/member/login/logOutAjax.do',
				'method'	: 'post',
				'beforeSend': function(request){
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					if(token != null && token != 'undefinded'){
						request.setRequestHeader(header, token);
					}else if(oThis.header != null && oThis.token != null ){
						request.setRequestHeader(oThis.header, oThis.token);
					}
				},			
				'complete'	: function () {
				
					var url = "/main.do";	
	
					
	
					
					alert("로그아웃 되었습니다.");
					location.href = url;
					
				}
			});
	
		};
		
		function searchSubmit(){
			var input = $('#searchWordInput').val();
			if(input == ''){
				alert("검색어를 입력해주세요!");
			}else{
				$('#searchWord').val(input);
				$('#jynSearchFrm').attr("action", "/jynSearch/jynSearch.do");
				$('#jynSearchFrm').submit();
			}
		};
	 </script>
	<!-- header -->
	<div class="skip_nav">
		<a href="#content" class="go_content">본문 바로가기</a>
		<a href="#gnb" class="go_gnb">주메뉴 바로가기</a>
	</div>
	<div class="header">
	
		<div class="top_banner" style="display: none;">
			<div class="ban_cont">
				
				<div class="ban_form_wrap">
					<form name="ban_form" id="btn03">
						<input type="checkbox" id="chkbox" name="chkbox">
						<label for="chkbox">하루동안 다시 보지 않기</label>
					</form>
				</div>
				<button type="button" class="btn_top_close" onclick="javascript:closeWin();">상단배너닫기</button>
			</div>
		</div>
		
		<div class="header_main">
			<h1 class="logo"><a href="/main.do">온라인청년센터</a></h1>
			<button type="button" class="btn_gnb">메인메뉴열기</button>
			<button type="button" class="btn_search">검색영역펼치기</button>
	
			<div class="search_wrap">
				<span>검색</span>
				<div class="search_field">
					<input type="text" name="searchWordInput" id="searchWordInput" class="txt_search" title="검색어 입력" placeholder="청년정책, 청년공간 검색을 해보자!" value="">
					<button type="button" class="btn" onclick="searchSubmit()">검색버튼</button>
					<form id="jynSearchFrm" name="jynSearchFrm" action="">
						<input type="hidden" name="searchWord" id="searchWord" />
					</form>
				</div>
				<button type="button" class="btn_search_close">검색영역닫기</button>
			</div>
	
			<ul class="utill_list">
	
				<li><a href="/member/bodyLogin.do" class="utill01">로그인</a></li>
	
				<li><a href="/member/custJoin/retrieveIndivCustClauseAgree.do?memType=member" class="utill04">회원가입</a></li>
	
	
			</ul>
		</div>
		
		<!-- 사용자 불편 문제로 제거 / 2019.04.30 hgj -->
		<!-- 
		<div class="header_ban">
			<a href="/kakao/kakao.html" target="_blank" title="새창열림"><img src="/images/common/ban_top.png" alt="청년정책 궁금하니?"></a>
		</div> 
		-->
	
		<!-- pc에서 보여지는 gnb -->
		<div class="pc_gnb_wrap">
			<div class="gnb_wrap">
				<div id="pc_gnb" class="gnb">
					<ul class="gnb_list">
	
		
			
			
		
			
				
				
				
						<li class="gnb01">
							<a href="/jynEmpSptNew/jynEmpSptList.do">청년정책</a>
			
		
			
		
	
		
			
			
		
			
		
			
				
							<ul class="dep2">
				
								<li><a href="/jynEmpSptNew/jynEmpSptList.do">청년정책통합검색</a></li>
				
			
		
	
		
			
			
		
			
		
			
				
								<li><a href="/jynEmpCmpr/jynEmpCmprList.do">정책비교</a></li>
				
			
		
	
		
			
							</ul>
			
			
						</li>
			
		
			
				
				
				
						<li class="gnb02">
							<a href="/jynSpc/jynSpcList.do">청년공간</a>
			
		
			
		
	
		
			
			
		
			
		
			
				
							<ul class="dep2">
				
								<li><a href="/jynSpc/jynSpcList.do">청년공간검색</a></li>
				
			
		
	
		
			
							</ul>
			
			
						</li>
			
		
			
				
				
				
						<li class="gnb03">
							<a href="/jobConslt/jobConsltMain.do">청년상담실</a>
			
		
			
		
	
		
			
			
		
			
		
			
				
							<ul class="dep2">
				
								<li><a href="/jobConslt/jobConsltMain.do">청년상담실은?</a></li>
				
			
		
	
		
			
			
		
			
		
			
				
								<li><a href="/kakao/kakao.html" target="_blank" title="새창열림">카카오톡 상담</a></li>
				
			
		
	
		
			
			
		
			
		
			
				
								<li><a href="/board/boardList.do?bbsNo=4&pageUrl=board/board">자주묻는질문(FAQ)</a></li>
				
			
		
	
		
			
							</ul>
			
			
						</li>
			
		
			
				
				
				
						<li class="gnb04">
							<a href="/board/boardList.do?bbsNo=3&pageUrl=board/board">청년뉴스</a>
			
		
			
		
	
		
			
			
		
			
		
			
				
							<ul class="dep2">
				
								<li><a href="/board/boardList.do?bbsNo=3&pageUrl=board/board">공지사항</a></li>
				
			
		
	
		
			
							</ul>
			
			
						</li>
			
		
			
				
				
				
						<li class="gnb05">
							<a href="/seekActvSptfndAppl/aboutThis.do">청년구직활동지원금</a>
			
		
			
		
	
		
			
			
		
			
		
			
				
							<ul class="dep2">
				
								<li><a href="/seekActvSptfndAppl/aboutThis.do">청년구직활동지원금이란?</a></li>
				
			
		
	
		
			
			
		
			
		
			
				
								<li><a href="/seekActvSptfndAppl/idifClctAgreForm.do">지원금 신청</a></li>
				
			
		
	
		
			
							</ul>
			
			
						</li>
			
		
			
				
				
				
						<li class="gnb06">
							<a href="/intro/centerIntro.do">소개</a>
			
		
			
		
	
		
			
			
		
			
		
			
				
							<ul class="dep2">
				
								<li><a href="/intro/centerIntro.do">온라인청년센터는?</a></li>
				
			
		
	
		
			
			
		
			
		
			
				
								<li><a href="/intro/deptIntro.do">업무별 담당자 안내</a></li>
				
			
		
	
		
	
		
	
	
	
							</ul>
	
						</li>
					</ul>
	
					<div class="allmenu_wrap">
						<button type="button" class="btn_allmenu">
							<strong>전체메뉴열기</strong>
							<span class="line01"></span>
							<span class="line02"></span>
							<span class="line03"></span>
						</button>
	
						<div class="allmenu">
							<ul>
	
	
	
		
			
			
		
			
				
				
				
						<li class="gnb01">
							<a href="/jynEmpSptNew/jynEmpSptList.do"
							>청년정책</a>
			
		
			
		
	
		
			
			
		
			
		
			
				
							<ul>
				
								<li><a href="/jynEmpSptNew/jynEmpSptList.do"
															   
								>청년정책통합검색</a></li>
				
			
		
	
		
			
			
		
			
		
			
				
								<li><a href="/jynEmpCmpr/jynEmpCmprList.do"
															   
								>정책비교</a></li>
				
			
		
	
		
			
							</ul>
			
			
						</li>
			
		
			
				
				
				
						<li class="gnb02">
							<a href="/jynSpc/jynSpcList.do"
							>청년공간</a>
			
		
			
		
	
		
			
			
		
			
		
			
				
							<ul>
				
								<li><a href="/jynSpc/jynSpcList.do"
															   
								>청년공간검색</a></li>
				
			
		
	
		
			
							</ul>
			
			
						</li>
			
		
			
				
				
				
						<li class="gnb03">
							<a href="/jobConslt/jobConsltMain.do"
							>청년상담실</a>
			
		
			
		
	
		
			
			
		
			
		
			
				
							<ul>
				
								<li><a href="/jobConslt/jobConsltMain.do"
															   
								>청년상담실은?</a></li>
				
			
		
	
		
			
			
		
			
		
			
				
								<li><a href="/kakao/kakao.html" target="_blank"
															    title="새창열림"
								>카카오톡 상담</a></li>
				
			
		
	
		
			
			
		
			
		
			
				
								<li><a href="/board/boardList.do?bbsNo=4&pageUrl=board/board"
															   
								>자주묻는질문(FAQ)</a></li>
				
			
		
	
		
			
							</ul>
			
			
						</li>
			
		
			
				
				
				
						<li class="gnb04">
							<a href="/board/boardList.do?bbsNo=3&pageUrl=board/board"
							>청년뉴스</a>
			
		
			
		
	
		
			
			
		
			
		
			
				
							<ul>
				
								<li><a href="/board/boardList.do?bbsNo=3&pageUrl=board/board"
															   
								>공지사항</a></li>
				
			
		
	
		
			
							</ul>
			
			
						</li>
			
		
			
				
				
				
						<li class="gnb05">
							<a href="/seekActvSptfndAppl/aboutThis.do"
							>청년구직활동지원금</a>
			
		
			
		
	
		
			
			
		
			
		
			
				
							<ul>
				
								<li><a href="/seekActvSptfndAppl/aboutThis.do"
															   
								>청년구직활동지원금이란?</a></li>
				
			
		
	
		
			
			
		
			
		
			
				
								<li><a href="/seekActvSptfndAppl/idifClctAgreForm.do"
															   
								>지원금 신청</a></li>
				
			
		
	
		
			
							</ul>
			
			
						</li>
			
		
			
				
				
				
						<li class="gnb06">
							<a href="/intro/centerIntro.do"
							>소개</a>
			
		
			
		
	
		
			
			
		
			
		
			
				
							<ul>
				
								<li><a href="/intro/centerIntro.do"
															   
								>온라인청년센터는?</a></li>
				
			
		
	
		
			
			
		
			
		
			
				
								<li><a href="/intro/deptIntro.do"
															   
								>업무별 담당자 안내</a></li>
				
			
		
	
		
	
		
	
	
	
							</ul>
	
								</li>
							</ul>
						</div>
	
						<button type="button" class="btn_allmenu_close">전체메뉴닫기</button>
					</div>
				</div>
			</div>
		</div>
		<!-- pc에서 보여지는 gnb -->
	
		<!-- m에서 보여지는 gnb -->
		<div class="m_gnb_wrap">
			<div class="gnb_wrap">
				<div id="m_gnb" class="gnb">
					<div class="gnb_top">
					
						<a href="/member/bodyLogin.do" class="btn_login">로그인</a>
						
						<a href="/member/custJoin/retrieveIndivCustClauseAgree.do?memType=member" class="btn_join">회원가입</a>
					
					
					
					</div>
					<ul class="gnb_list">
	
	
	
		
			
			
		
			
				
				
				
						<li class="gnb01">
							<a href="#n">청년정책</a>
			
		
			
		
	
		
			
			
		
			
		
			
				
							<ul class="dep2">
				
								<li><a href="/jynEmpSptNew/jynEmpSptList.do">청년정책통합검색</a></li>
				
			
		
	
		
			
			
		
			
		
			
				
								<li><a href="/jynEmpCmpr/jynEmpCmprList.do">정책비교</a></li>
				
			
		
	
		
			
							</ul>
			
			
						</li>
			
		
			
				
				
				
						<li class="gnb02">
							<a href="#n">청년공간</a>
			
		
			
		
	
		
			
			
		
			
		
			
				
							<ul class="dep2">
				
								<li><a href="/jynSpc/jynSpcList.do">청년공간검색</a></li>
				
			
		
	
		
			
							</ul>
			
			
						</li>
			
		
			
				
				
				
						<li class="gnb03">
							<a href="#n">청년상담실</a>
			
		
			
		
	
		
			
			
		
			
		
			
				
							<ul class="dep2">
				
								<li><a href="/jobConslt/jobConsltMain.do">청년상담실은?</a></li>
				
			
		
	
		
			
			
		
			
		
			
				
								<li><a href="/kakao/kakao.html" target="_blank">카카오톡 상담</a></li>
				
			
		
	
		
			
			
		
			
		
			
				
								<li><a href="/board/boardList.do?bbsNo=4&pageUrl=board/board">자주묻는질문(FAQ)</a></li>
				
			
		
	
		
			
							</ul>
			
			
						</li>
			
		
			
				
				
				
						<li class="gnb04">
							<a href="#n">청년뉴스</a>
			
		
			
		
	
		
			
			
		
			
		
			
				
							<ul class="dep2">
				
								<li><a href="/board/boardList.do?bbsNo=3&pageUrl=board/board">공지사항</a></li>
				
			
		
	
		
			
							</ul>
			
			
						</li>
			
		
			
				
				
				
						<li class="gnb05">
							<a href="#n">청년구직활동지원금</a>
			
		
			
		
	
		
			
			
		
			
		
			
				
							<ul class="dep2">
				
								<li><a href="/seekActvSptfndAppl/aboutThis.do">청년구직활동지원금이란?</a></li>
				
			
		
	
		
			
			
		
			
		
			
				
								<li><a href="/seekActvSptfndAppl/idifClctAgreForm.do">지원금 신청</a></li>
				
			
		
	
		
			
							</ul>
			
			
						</li>
			
		
			
				
				
				
						<li class="gnb06">
							<a href="#n">소개</a>
			
		
			
		
	
		
			
			
		
			
		
			
				
							<ul class="dep2">
				
								<li><a href="/intro/centerIntro.do">온라인청년센터는?</a></li>
				
			
		
	
		
			
			
		
			
		
			
				
								<li><a href="/intro/deptIntro.do">업무별 담당자 안내</a></li>
				
			
		
	
		
	
		
	
	
	
							</ul>
	
						</li>
					</ul>
				</div>
			</div>
			<button type="button" class="btn_close">메인메뉴닫기</button>
		</div>
		<!-- //m에서 보여지는 gnb -->
	</div>
	<!-- //header -->
	
	<script>
		//쿠키생성
		function setCookie( name, value, expiredays ) {
			var todayDate = new Date();
				todayDate.setDate( todayDate.getDate() + expiredays );
				document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
		}
	
		function closeWin() {
			if (document.ban_form.chkbox.checked){
				setCookie( "maindiv", "done", 1 );
	
			}
			$(".top_banner").hide();
		}
	
		cookiedata = document.cookie;
		if(cookiedata. indexOf("maindiv=done") < 0 ){
			$(".top_banner").show();
		}else{
			$(".top_banner").hide();
		}
	
		$(".top_banner .btn_top_close").on("click", function(){
			$(".top_banner").hide(function() {
				var header_h = $(".header").height()
				$(".wrap").css("padding-top", header_h)
			});
	
		})
	</script>

		



	
    <!-- location -->
	<div class="location">
		<div class="inner">
			<p class="go_home"><a href="/">홈으로</a></p>
			<ul class="location_list">
				<li>
					<button type="button" title="메뉴열기">청년정책</button>
					<ul>
		
			
						<li><a href="/jynEmpSptNew/jynEmpSptList.do">청년정책</a></li>
			
		
			
						<li><a href="/jynSpc/jynSpcList.do">청년공간</a></li>
			
		
			
						<li><a href="/jobConslt/jobConsltMain.do">청년상담실</a></li>
			
		
			
						<li><a href="/board/boardList.do?bbsNo=3&pageUrl=board/board">청년뉴스</a></li>
			
		
			
						<li><a href="/seekActvSptfndAppl/aboutThis.do">청년구직활동지원금</a></li>
			
		
			
						<li><a href="/intro/centerIntro.do">소개</a></li>
			
		
					</ul>
				</li>
				<li>
					<button type="button" title="메뉴열기">청년정책통합검색</button>
					<ul>
		
			
						<li><a href="/jynEmpSptNew/jynEmpSptList.do">청년정책통합검색</a></li>
			
		
			
						<li><a href="/jynEmpCmpr/jynEmpCmprList.do">정책비교</a></li>
			
		
					</ul>
				</li>
			</ul>
		</div>
	</div>
	<!-- //location -->
	
	
		
		<div class="container">
			<div id="content" class="content">
				




				






   
   <script>

       $(document).ready(function () {
       	
       	// 숫자만 입력
       	$("#srchAge").on("keyup",function(){
       		$(this).val($(this).val().replace(/[^0-9]/g, ""));
       	});
       	
       	// 상세조건은 default값이 전체 체크
       	function detailCheck(){
       		$(".detail_search input[type='checkbox']").each(function(index){
               	if($(this).prop("checked") && $(this).attr('tmp') != '전체'){
               		return false;	
               	}else{
               		if(index==$(".detail_search input[type='checkbox']").length-1){
               			$(".detail_search input[type='checkbox']").each(function(){
                       		$(this).prop("checked",true);
                       	});	
               		}
               	}
               });	
       	}
       	detailCheck();

       	// 누적 영역 설정
   		function setSelectArea(){
   			$('.select_area').empty();
   	    	var tmp = '';
   	   		$(".detail_search input[type='checkbox']").each(function(){
   	   			if($(this).prop("checked") && $(this).attr('tmp') != '전체'){
   	   				var dtlName = $(this).attr('tmp');
   					tmp += '<span tmp="' + dtlName +'">' + dtlName + '<button type="button" class="btn_del" tmp="' + dtlName + '">';
   					tmp += '<span class="blind">' + dtlName + ' 삭제</span>';
   					tmp += '</button></span>';
   				} 
   	   		});
   	   		tmp += '<script>';
			tmp += '$(".btn_del").on("click",function(){';
			tmp += '$(".detail_search input[tmp="+$(this).attr("tmp")+"]").prop("checked",false);';
			tmp += '$("span[tmp="+$(this).attr("tmp")+"]").remove();';
			tmp += '});';
			tmp += '<'+'/'+'script>';

   	   		$('.select_area').html(tmp);
   		}
       	setSelectArea();

       	$(".detail_search input[type='checkbox']").on("change",function(){
       		setSelectArea();	
       	});
       	
		var busiNos=[];
		/* var jynEmpSptMyZzimList = '';
		 */
		
		$("#btnSearchTxt").focus();
		$("#btnSearchTxt").keypress(function(event) {
			if(event.which == 13) {
				f_srch();
			}
		});
		
		//체크된 유형 표시 (정책유형) 
   		if($("#bizTycdSel").val()!="" && $("#bizTycdSel").val()!=null){
   			var bizTycd=$("#bizTycdSel").val().split(",");
   			for(var i=0;i<bizTycd.length;i++){
   				$("input[value="+bizTycd[i]+"]").prop("checked",true);
   			}
   		}

		//체크된 유형 표시 
		/* 
		if($("#plcySel").val()!="" && $("#plcySel").val()!=null){
			var plcySel=$("#plcySel").val().split(",");
			for(var i=0;i<plcySel.length;i++){
				$("input[value="+plcySel[i]+"]").prop("checked",true);
			}
		} 
		*/
		
		//정책 유형 전체 클릭시
		$("#plcyTpChkAll").on("click",function(){
			var chk=true;
			$("input[name=plcy]").each(function(){
				if($(this).prop("checked")){
					$(this).prop("checked",false);
					chk=false;
				}
			});
			if(chk){
				$("input[name=plcy]").prop("checked",true);
			}
		});
		
		//체크된 검색 표시
		if($("#chargerOrgCdSel").val()!="" && $("#chargerOrgCdSel").val()!=null){
			var chargerOrgCdSel=$("#chargerOrgCdSel").val().split(",");
			for(var i=0;i<chargerOrgCdSel.length;i++){
				$("input[value="+chargerOrgCdSel[i]+"]").prop("checked",true);
			}
		}
		
		//지역 검색 전체 클릭시
		$("#chargerOrgCdAll").on("click",function(){
			var chk=true;
			$("input[name=chargerOrgCd0]").each(function(){
				if($(this).prop("checked")){
					$(this).prop("checked",false);
					chk=false;
				}
			});
			if(chk){
				$("input[name=chargerOrgCd0]").prop("checked",true);
			}
		});
		
		$("input[name=chargerOrgCd0]").on("click",function(){
			$("#chargerOrgCdAll").prop("checked", false);
		});
		
		// 스크롤 지정 - 2019.05.20 hgj
		var scroll = '';
		if(scroll != '' && scroll != null){
			if(scroll == '1'){
				var offset = $('#jynEmpSptList1').offset();
			}else if(scroll == '2'){
				var offset = $('#jynEmpSptList2').offset();
			}
			$('html, body').animate({scrollTop : offset.top - $('.header').height()}, 400);
		}
		
       });
       
       function f_reset(){
       	if(confirm('설정 정보를 초기화 하겠습니까?')){
        	//$('[name=plcy]').prop("checked",false);
        	//$('[name=chargerOrgCd0]').prop("checked",false);
        	
        	/*
        	$("input[type='checkbox']").prop("checked",false);
        	$(".detail_search input[type='checkbox']").prop("checked", true);
        	$("#btnSearchTxt").val("");
        	$("input[name='srchAge']").val("");
        	*/
        	
        	location.href='/jynEmpSptNew/jynEmpSptList.do';
        	
       	}
       }
       
       function fn_move(currPageno){
       	var srchFrm = document.srchFrm;
       	$('#scroll').val(2);
   		srchFrm.pageIndex.value = currPageno;
   		srchFrm.sortField.value = $("#sortFieldParam").val();
   		srchFrm.action = "/jynEmpSptNew/jynEmpSptList.do";
   		srchFrm.submit();
   	}
       
       function f_srch(){

       	$(".detail_search input[type='checkbox']").each(function(){
			if($(this).prop("checked")){
				//$(this).val("Y");
				$('#'+$(this).attr("name")+'Sel').val("Y");
			}else{
				//$(this).val("N");
				$('#'+$(this).attr("name")+'Sel').val("N");
			}
		});
       	
   		var srchFrm = document.srchFrm;
   		srchFrm.pageIndex.value = 1;
   		srchFrm.currentPage.value = 1;
   		srchFrm.sortField.value = $("#sortFieldParam").val();
   		srchFrm.action = "/jynEmpSptNew/jynEmpSptList.do";
   		srchFrm.submit();
   	}
       
       /********************************************
   	* 상세페이지 이동
   	*/
   	function fnGoDetail(val) {
   		var srchFrm = document.srchFrm;
   		srchFrm.bizId.value = val;
   		srchFrm.sortField.value = $("#sortFieldParam").val();
   		srchFrm.action = "/jynEmpSptNew/jynEmpSptGuide.do";
   		srchFrm.submit();
   	}
       
       /********************************************
   	* 정렬 조회
   	*/
   	function f_order_search(){
   		var srchFrm = document.srchFrm;

   		srchFrm.pageIndex.value = 1;
   		srchFrm.currentPage.value = 1;
   		srchFrm.sortField.value = $("#sortFieldParam").val();
   		srchFrm.sortField2.value = $("#sortFieldParam2").val();
   		srchFrm.action = "/jynEmpSptNew/jynEmpSptList.do";
   		srchFrm.submit();
   	}
   	
   	function jynEmpPaging(pg){
   		var srchFrm = document.srchFrm;
   		$('#scroll').val(1);
   		srchFrm.currentPage.value = pg;
   		srchFrm.sortField.value = $("#sortFieldParam").val();
   		srchFrm.action = "/jynEmpSptNew/jynEmpSptList.do";
   		srchFrm.submit();
    }

   </script>

<h2 class="doc_tit01">청년정책통합검색</h2>

<div class="btn_wrap support_view_btn">
	<div class="fr">
		<a href="#n" class="btn_next">청년정책 상세검색 열기</a>
	</div>
</div>

<input type="hidden" id="bizTycdSel" name="bizTycdSel"   value=""/>

<!-- 검색 영역 -->
<div class="ply-srh-box explain-srh-box">
	<form id="srchFrm" name="srchFrm" action="/jynEmpSptNew/jynEmpSptList.do" method="get" onsubmit="f_srchKey();">
		<input type="hidden" id="pageIndex" name="pageIndex" value="1"/>
		<input type="hidden" id="currentPage" name="currentPage" value="1"/>
		<input type="hidden" id="sortField" name="sortField" value="exprRnkn" />
		<input type="hidden" name="setZzimBusiId"  id="setZzimBusiId"  value="" />
		
		<input type="hidden" id="bizId" name="bizId" value="" />
		<input type="hidden" id="plcySel" name="plcySel" value="" />
		<input type="hidden" id="chargerOrgCdSel" name="chargerOrgCdSel" value="" />
		<input type="hidden" id="sortField2" name="sortField2" value="exprRnkn" />
		
		<input type="hidden" id="higdBlowAccrYnSel" name="higdBlowAccrYnSel" value="" />
		<input type="hidden" id="hiscEnrlYnSel" name="hiscEnrlYnSel" value="" />
		<input type="hidden" id="hiscGrdnPrerYnSel" name="hiscGrdnPrerYnSel" value="" />
		<input type="hidden" id="higdAccrYnSel" name="higdAccrYnSel" value="" />
		<input type="hidden" id="univEnrlYnSel" name="univEnrlYnSel" value="" />
		<input type="hidden" id="univGrdnAccrYnSel" name="univGrdnAccrYnSel" value="" />
		<input type="hidden" id="drAccrYnSel" name="drAccrYnSel" value="" />
		
		<input type="hidden" id="majrSglSersYnSel" name="majrSglSersYnSel" value="" />
		<input type="hidden" id="majrSocySersYnSel" name="majrSocySersYnSel" value="" />
		<input type="hidden" id="majrBsflSersYnSel" name="majrBsflSersYnSel" value="" />
		<input type="hidden" id="majrNtssSersYnSel" name="majrNtssSersYnSel" value="" />
		<input type="hidden" id="majrEngrSersYnSel" name="majrEngrSersYnSel" value="" />
		<input type="hidden" id="majrEnspSersYnSel" name="majrEnspSersYnSel" value="" />
		
		<input type="hidden" id="splzRlmSmpzEmpmYnSel" name="splzRlmSmpzEmpmYnSel" value="" />
		<input type="hidden" id="splzRlmFmleYnSel" name="splzRlmFmleYnSel" value="" />
		<input type="hidden" id="splzRlmLigYnSel" name="splzRlmLigYnSel" value="" />
		<input type="hidden" id="splzRlmDspnYnSel" name="splzRlmDspnYnSel" value="" />
		<input type="hidden" id="splzRlmSdrYnSel" name="splzRlmSdrYnSel" value="" />
		<input type="hidden" id="splzRlmFrmlYnSel" name="splzRlmFrmlYnSel" value="" />
		
		<input type="hidden" id="empnHffcYnSel" name="empnHffcYnSel" value="" />
		<input type="hidden" id="empyBsmgYnSel" name="empyBsmgYnSel" value="" />
		<input type="hidden" id="empmUnpnYnSel" name="empmUnpnYnSel" value="" />
		
		<input type="hidden" id="scroll" name="scroll" value="" />
		
		<div class="policy-search">
			<div>
				<div class="l"><label for="btnSearchTxt">정책 검색</label></div>
				<div class="r"><input type="text" id="btnSearchTxt" name="btnSearchTxt" title="키워드를 입력" value="" placeholder="키워드를 입력하세요" class="input-text" /></div>
			</div>
			
			<div>
				<div class="l">정책 유형</div>
				<div class="r ply-op">
					<span class="all-ck">
						<input type="checkbox" id="policy01" class="blind">
						<label for="policy01">정책 유형 전체</label>
					</span>
					<ul>
						<li><span class="bn"><button type="button" class="off" data-list="list01" title="취업지원 선택 박스 열기">취업지원</button></span></li>
						<li><span class="bn"><button type="button" class="off" data-list="list02" title="창업지원 선택 박스 열기">창업지원</button></span></li>
						<li><span class="bn"><button type="button" class="off" data-list="list03" title="생활복지 선택 박스 열기">생활&middot;복지</button></span></li>
						<li><span class="bn"><button type="button" class="off" data-list="list04" title="주거금융 선택 박스 열기">주거&middot;금융</button></span></li>
					</ul>
				</div>
			</div>
			
			
			<div class="ins-box" tabindex="0" data-box="off" data-cont="list01">
				<div class="txt">
					<strong>취업지원 선택하세요 !</strong>
				</div>
				<div class="ply-op">
					<span class="all-ck">
						<input type="checkbox" id="policy01-0" class="blind">
						<label for="policy01-0">전체</label>
					</span>
					<ul>
						
							
								<li>
									<span class="srh-check ply-ck">
										<input type="checkbox" name="bizTycd" value="PLCYTP010001" id="policy01-1" class="blind">
										<label for="policy01-1">교육훈련·체험·인턴</label>
									</span>
								</li>
							
						
							
								<li>
									<span class="srh-check ply-ck">
										<input type="checkbox" name="bizTycd" value="PLCYTP010002" id="policy01-2" class="blind">
										<label for="policy01-2">전문분야 취업지원</label>
									</span>
								</li>
							
						
							
								<li>
									<span class="srh-check ply-ck">
										<input type="checkbox" name="bizTycd" value="PLCYTP010003" id="policy01-3" class="blind">
										<label for="policy01-3">중소기업 취업지원</label>
									</span>
								</li>
							
						
							
								<li>
									<span class="srh-check ply-ck">
										<input type="checkbox" name="bizTycd" value="PLCYTP010004" id="policy01-4" class="blind">
										<label for="policy01-4">해외진출</label>
									</span>
								</li>
							
						
							
						
							
						
							
						
							
						
							
						
							
						
							
						
							
						
					</ul>
				</div>
				<button type="button" class="close"><span class="blind">취업지원 선택 박스 닫기</span></button>
			</div>
			
			<div class="ins-box" tabindex="0" data-box="off" data-cont="list02">
				<div class="txt">
					<strong>창업 선택하세요 !</strong>
				</div>
				<div class="ply-op">
					<span class="all-ck">
						<input type="checkbox" id="policy02-0" class="blind">
						<label for="policy02-0">전체</label>
					</span>
					<ul>
						
							
						
							
						
							
						
							
						
							
								<li>
									<span class="srh-check ply-ck">
										<input type="checkbox" name="bizTycd" value="PLCYTP020001" id="policy02-5" class="blind">
										<label for="policy02-5">R&D 지원</label>
									</span>
								</li>
							
						
							
								<li>
									<span class="srh-check ply-ck">
										<input type="checkbox" name="bizTycd" value="PLCYTP020002" id="policy02-6" class="blind">
										<label for="policy02-6">경영 지원</label>
									</span>
								</li>
							
						
							
								<li>
									<span class="srh-check ply-ck">
										<input type="checkbox" name="bizTycd" value="PLCYTP020003" id="policy02-7" class="blind">
										<label for="policy02-7">자본금 지원</label>
									</span>
								</li>
							
						
							
						
							
						
							
						
							
						
							
						
					</ul>
				</div>
				<button type="button" class="close"><span class="blind">창업 선택 박스 닫기</span></button>
			</div>
			
			<div class="ins-box" tabindex="0" data-box="off" data-cont="list03">
				<div class="txt">
					<strong>생활·복지 선택하세요 !</strong>
				</div>
				<div class="ply-op">
					<span class="all-ck">
						<input type="checkbox" id="policy03-0" class="blind">
						<label for="policy03-0">전체</label>
					</span>
					<ul>
						
							
						
							
						
							
						
							
						
							
						
							
						
							
						
							
								<li>
									<span class="srh-check ply-ck">
										<input type="checkbox" name="bizTycd" value="PLCYTP030001" id="policy03-8" class="blind">
										<label for="policy03-8">건강</label>
									</span>
								</li>
							
						
							
								<li>
									<span class="srh-check ply-ck">
										<input type="checkbox" name="bizTycd" value="PLCYTP030002" id="policy03-9" class="blind">
										<label for="policy03-9">문화</label>
									</span>
								</li>
							
						
							
						
							
						
							
						
					</ul>
				</div>
				<button type="button" class="close"><span class="blind">생활·복지 선택 박스 닫기</span></button>
			</div>
			
			<div class="ins-box" tabindex="0" data-box="off" data-cont="list04">
				<div class="txt">
					<strong>주거·금융 선택하세요 !</strong>
				</div>
				<div class="ply-op">
					<span class="all-ck">
						<input type="checkbox" id="policy04-0" class="blind">
						<label for="policy04-0">전체</label>
					</span>
					<ul>
						
							
						
							
						
							
						
							
						
							
						
							
						
							
						
							
						
							
						
							
								<li>
									<span class="srh-check ply-ck">
										<input type="checkbox" name="bizTycd" value="PLCYTP040001" id="policy04-10" class="blind">
										<label for="policy04-10">생활비 지원 및 금융 혜택 </label>
									</span>
								</li>
							
						
							
								<li>
									<span class="srh-check ply-ck">
										<input type="checkbox" name="bizTycd" value="PLCYTP040002" id="policy04-11" class="blind">
										<label for="policy04-11">주거 지원</label>
									</span>
								</li>
							
						
							
								<li>
									<span class="srh-check ply-ck">
										<input type="checkbox" name="bizTycd" value="PLCYTP040003" id="policy04-12" class="blind">
										<label for="policy04-12">학자금 지원</label>
									</span>
								</li>
							
						
					</ul>
				</div>
				<button type="button" class="close"><span class="blind">주거·금융 선택 박스 닫기</span></button>
			</div>
			
			
			
			
			<div>
				<div class="l">지자체 정책<span>(중복선택 가능)</span></div>
				<div class="r lct-op">
					<span class="all-ck">
						<input type="checkbox" id="chargerOrgCdAll" name="chargerOrgCdAll" class="blind" value="LALL">
						<label for="chargerOrgCdAll">지자체 정책 전체</label>
					</span>
					<ul>
						<li>
							<span class="srh-check lct-ck">
								<input type="checkbox" class="blind" id="chargerOrgCd_1" name="chargerOrgCd0" value="L031" />
								<label for="chargerOrgCd_1">서울</label>
							</span>
						</li>
						<li>
							<span class="srh-check lct-ck">
								<input type="checkbox" class="blind" id="chargerOrgCd_2" name="chargerOrgCd0" value="L032" />
								<label for="chargerOrgCd_2">부산</label>
							</span>
						</li>
						<li>
							<span class="srh-check lct-ck">
								<input type="checkbox" class="blind" id="chargerOrgCd_3" name="chargerOrgCd0" value="L033" />
								<label for="chargerOrgCd_3">인천</label>
							</span>
						</li>
						<li>
							<span class="srh-check lct-ck">
								<input type="checkbox" class="blind" id="chargerOrgCd_4" name="chargerOrgCd0" value="L034" />
								<label for="chargerOrgCd_4">대구</label>
							</span>
						</li>
						<li>
							<span class="srh-check lct-ck">
								<input type="checkbox" class="blind" id="chargerOrgCd_5" name="chargerOrgCd0" value="L035" />
								<label for="chargerOrgCd_5">광주</label>
							</span>
						</li>
						<li>
							<span class="srh-check lct-ck">
								<input type="checkbox" class="blind" id="chargerOrgCd_6" name="chargerOrgCd0" value="L036" />
								<label for="chargerOrgCd_6">대전</label>
							</span>
						</li>
						<li>
							<span class="srh-check lct-ck">
								<input type="checkbox" class="blind" id="chargerOrgCd_7" name="chargerOrgCd0" value="L037" />
								<label for="chargerOrgCd_7">울산</label>
							</span>
						</li>
						<li>
							<span class="srh-check lct-ck">
								<input type="checkbox" class="blind" id="chargerOrgCd_8" name="chargerOrgCd0" value="L038" />
								<label for="chargerOrgCd_8">세종</label>
							</span>
						</li>
						<li>
							<span class="srh-check lct-ck">
								<input type="checkbox" class="blind" id="chargerOrgCd_9" name="chargerOrgCd0" value="L039" />
								<label for="chargerOrgCd_9">경기</label>
							</span>
						</li>
						<li>
							<span class="srh-check lct-ck">
								<input type="checkbox" class="blind" id="chargerOrgCd_10" name="chargerOrgCd0" value="L045" />
								<label for="chargerOrgCd_10">강원</label>
							</span>
						</li>
						<li>
							<span class="srh-check lct-ck">
								<input type="checkbox" class="blind" id="chargerOrgCd_11" name="chargerOrgCd0" value="L040" />
								<label for="chargerOrgCd_11">충북</label>
							</span>
						</li>
						<li>
							<span class="srh-check lct-ck">
								<input type="checkbox" class="blind" id="chargerOrgCd_12" name="chargerOrgCd0" value="L041" />
								<label for="chargerOrgCd_12">충남</label>
							</span>
						</li>
						<li>
							<span class="srh-check lct-ck">
								<input type="checkbox" class="blind" id="chargerOrgCd_13" name="chargerOrgCd0" value="L029" />
								<label for="chargerOrgCd_13">전북</label>
							</span>
						</li>
						<li>
							<span class="srh-check lct-ck">
								<input type="checkbox" class="blind" id="chargerOrgCd_14" name="chargerOrgCd0" value="L043" />
								<label for="chargerOrgCd_14">전남</label>
							</span>
						</li>
						<li>
							<span class="srh-check lct-ck">
								<input type="checkbox" class="blind" id="chargerOrgCd_15" name="chargerOrgCd0" value="L028" />
								<label for="chargerOrgCd_15">경북</label>
							</span>
						</li>
						<li>
							<span class="srh-check lct-ck">
								<input type="checkbox" class="blind" id="chargerOrgCd_16" name="chargerOrgCd0" value="L042" />
								<label for="chargerOrgCd_16">경남</label>
							</span>
						</li>
						<li>
							<span class="srh-check lct-ck">
								<input type="checkbox" class="blind" id="chargerOrgCd_17" name="chargerOrgCd0" value="L044" />
								<label for="chargerOrgCd_17">제주</label>
							</span>
						</li>
					</ul>
				</div>
			</div>
			
			<!-- 190503 상세검색 추가 -->
			<div class="detail_search">
				<div class="l">상세 검색<span>(중복 선택)</span></div>
				<div class="r detail-op">
					<ul class="normal_tab3">
						<li><a href="#n" class="active">연령</a></li>
						<li><a href="#n">학력</a></li>
						<li><a href="#n">전공</a></li>
						<li><a href="#n">특화분야</a></li>
						<li><a href="#n">취업상태</a></li>
					</ul>
					<div class="tab_view">
						<!-- 연령 -->
						<div class="view_cont txt_center">
							<p class="blind">연령</p>
							만 <input type="text" name="srchAge" id="srchAge" class="input_age" title="연령 검색 만 나이 숫자만 입력" value=""> 세
						</div>
						<!-- //연령 -->
						<!-- 학력 -->
						<div class="view_cont">
							<p class="blind">학력</p>
							<span class="all-ck">
								<input type="checkbox" id="detail02" class="blind" tmp="전체">
								<label for="detail02">학력 전체</label>
							</span>
							<ul>
								<li>
									<span class="srh-check detail-ck">
										<input type="checkbox" name="higdBlowAccrYn" id="detail02-1" class="blind" 
										 tmp="중졸이하">
										<label for="detail02-1">중졸이하</label>
									</span>
								</li>
								<li>
									<span class="srh-check detail-ck">
										<input type="checkbox" name="hiscEnrlYn" id="detail02-2" class="blind"
										 tmp="고교재학">
										<label for="detail02-2">고교재학</label>
									</span>
								</li>
								<li>
									<span class="srh-check detail-ck">
										<input type="checkbox" name="hiscGrdnPrerYn" id="detail02-3" class="blind"
										 tmp="고졸예정">
										<label for="detail02-3">고졸예정</label>
									</span>
								</li>
								<li>
									<span class="srh-check detail-ck">
										<input type="checkbox" name="higdAccrYn" id="detail02-4" class="blind"
										 tmp="고교졸업">
										<label for="detail02-4">고교졸업</label>
									</span>
								</li>
								<li>
									<span class="srh-check detail-ck">
										<input type="checkbox" name="univEnrlYn" id="detail02-5" class="blind"
										 tmp="대학재학">
										<label for="detail02-5">대학재학</label>
									</span>
								</li>
								<li>
									<span class="srh-check detail-ck">
										<input type="checkbox" name="univGrdnAccrYn" id="detail02-6" class="blind"
										 tmp="대학졸업">
										<label for="detail02-6">대학졸업</label>
									</span>
								</li>
								<li>
									<span class="srh-check detail-ck">
										<input type="checkbox" name="drAccrYn" id="detail02-7" class="blind"
										 tmp="석·박사">
										<label for="detail02-7">석·박사</label>
									</span>
								</li>
							</ul>
						</div>
						<!-- //학력 -->
						<!-- 전공 -->
						<div class="view_cont">
							<p class="blind">전공</p>
							<span class="all-ck">
								<input type="checkbox" id="detail03" class="blind" tmp="전체">
								<label for="detail03">전공 전체</label>
							</span>
							<ul>
								<li>
									<span class="srh-check detail-ck">
										<input type="checkbox" name="majrSglSersYn" id="detail03-1" class="blind"
										 tmp="인문계열">
										<label for="detail03-1">인문계열</label>
									</span>
								</li>
								<li>
									<span class="srh-check detail-ck">
										<input type="checkbox" name="majrSocySersYn" id="detail03-2" class="blind"
										 tmp="사회계열">
										<label for="detail03-2">사회계열</label>
									</span>
								</li>
								<li>
									<span class="srh-check detail-ck">
										<input type="checkbox" name="majrBsflSersYn" id="detail03-3" class="blind"
										 tmp="상경계열">
										<label for="detail03-3">상경계열</label>
									</span>
								</li>
								<li>
									<span class="srh-check detail-ck">
										<input type="checkbox" name="majrNtssSersYn" id="detail03-4" class="blind"
										 tmp="이학계열">
										<label for="detail03-4">이학계열</label>
									</span>
								</li>
								<li>
									<span class="srh-check detail-ck">
										<input type="checkbox" name="majrEngrSersYn" id="detail03-5" class="blind"
										 tmp="공학계열">
										<label for="detail03-5">공학계열</label>
									</span>
								</li>
								<li>
									<span class="srh-check detail-ck">
										<input type="checkbox" name="majrEnspSersYn" id="detail03-6" class="blind"
										 tmp="예체능계열">
										<label for="detail03-6">예체능계열</label>
									</span>
								</li>
							</ul>
						</div>
						<!-- //전공 -->
						<!-- 특화분야 -->
						<div class="view_cont">
							<p class="blind">특화분야</p>
							<span class="all-ck">
								<input type="checkbox" id="detail04" class="blind" tmp="전체">
								<label for="detail04">특화분야 전체</label>
							</span>
							<ul>
								<li>
									<span class="srh-check detail-ck">
										<input type="checkbox" name="splzRlmSmpzEmpmYn" id="detail04-1" class="blind"
										 tmp="중소·중견기업">
										<label for="detail04-1">중소·중견기업</label>
									</span>
								</li>
								<li>
									<span class="srh-check detail-ck">
										<input type="checkbox" name="splzRlmFmleYn" id="detail04-2" class="blind"
										 tmp="여성">
										<label for="detail04-2">여성</label>
									</span>
								</li>
								<li>
									<span class="srh-check detail-ck">
										<input type="checkbox" name="splzRlmLigYn" id="detail04-3" class="blind"
										 tmp="저소득층">
										<label for="detail04-3">저소득층</label>
									</span>
								</li>
								<li>
									<span class="srh-check detail-ck">
										<input type="checkbox" name="splzRlmDspnYn" id="detail04-4" class="blind"
										 tmp="장애인">
										<label for="detail04-4">장애인</label>
									</span>
								</li>
								<li>
									<span class="srh-check detail-ck">
										<input type="checkbox" name="splzRlmSdrYn" id="detail04-5" class="blind"
										 tmp="군인">
										<label for="detail04-5">군인</label>
									</span>
								</li>
								<li>
									<span class="srh-check detail-ck">
										<input type="checkbox" name="splzRlmFrmlYn" id="detail04-6" class="blind"
										 tmp="농업인">
										<label for="detail04-6">농업인</label>
									</span>
								</li>
							</ul>
						</div>
						<!-- //특화분야 -->
						<!-- 취업상태 -->
						<div class="view_cont">
							<p class="blind">취업상태</p>
							<span class="all-ck">
								<input type="checkbox" id="detail05" class="blind" tmp="전체">
								<label for="detail05">취업상태 전체</label>
							</span>
							<ul>
								<li>
									<span class="srh-check detail-ck">
										<input type="checkbox" name="empnHffcYn" id="detail05-1" class="blind"
										 tmp="재직자">
										<label for="detail05-1">재직자</label>
									</span>
								</li>
								<li>
									<span class="srh-check detail-ck">
										<input type="checkbox" name="empyBsmgYn" id="detail05-2" class="blind"
										 tmp="자영업자">
										<label for="detail05-2">자영업자</label>
									</span>
								</li>
								<li>
									<span class="srh-check detail-ck">
										<input type="checkbox" name="empmUnpnYn" id="detail05-3" class="blind"
										 tmp="미취업자">
										<label for="detail05-3">미취업자</label>
									</span>
								</li>
							</ul>
						</div>
						<!-- //취업상태 -->
					</div>

					<div class="select_area" id="select_area">
						<!-- <span>고교재학<button type="button" class="btn_del"><span class="blind">고교재학 삭제</span></button></span> -->
					</div>
				</div>
			</div>
			<!-- //190503 상세검색 -->
			<p class="ply-srh-box-txt"><span>※</span> ‘온라인 청년센터 청년정책’ 에서는 지자체에서 시행하는 다양한 청년정책을 탑재 하고 있습니다.<br>각 지자체의 2019년 청년정책이 발표되는대로 업데이트 중입니다.</p>
		</div>
		<div class="btn_wrap">
			<button type="button" onclick="javascript:f_reset();" class="btn_normal" id="reset">선택 초기화</button>
			<button type="button" onclick="javascript:f_srch();" class="btn_normal blue">검색</button>
		</div>
	<div>
</div></form>
</div>
<!-- // 검색 영역 -->

<script>
// 정책유형별 박스 On/Off
$(".explain-srh-box .bn button").on("click",function(){
	var num = $(this).attr("data-list")
	var data = $("[data-cont="+num+"]").attr("data-box");
	$(".explain-srh-box .bn button").removeClass("on").addClass("off")
	$(".ins-box").hide().attr("data-box","off")
	if(data == "off"){
		$("[data-cont="+num+"]").show().focus();
		$("[data-cont="+num+"]").attr("data-box","on");
		$(this).removeClass("off").addClass("on")
		if($(this).attr("data-list")=="list01"){
			$(this).attr("title","취업지원 선택 박스 닫기");
		} else if($(this).attr("data-list")=="list02"){
			$(this).attr("title","창업지원 선택 박스 닫기");
		} else if($(this).attr("data-list")=="list03"){
			$(this).attr("title","주거금융 선택 박스 닫기");
		} else {
			$(this).attr("title","생활복지 선택 박스 닫기");
		}

	}else{
		$("[data-cont="+num+"]").hide().attr("data-box","off");
		$(".explain-srh-box .bn button").focus().removeClass("on").addClass("off")
		if($(this).attr("data-list")=="list01"){
			$(this).attr("title","취업지원 선택 박스 열기");
		} else if($(this).attr("data-list")=="list02"){
			$(this).attr("title","창업지원 선택 박스 열기");
		} else if($(this).attr("data-list")=="list03"){
			$(this).attr("title","주거금융 선택 박스 열기");
		} else {
			$(this).attr("title","생활복지 선택 박스 열기");
		}
	}
});

$(".explain-srh-box .ins-box .close").on("click", function(){
	$(this).parents(".ins-box").hide().attr("data-box","off")
	var close = $(this).parents(".ins-box").attr("data-cont")
	$("[data-list="+close+"]").focus().removeClass("on").addClass("off")
});

// 정책 유형 전체 체크
$(".r.ply-op .all-ck input[type=checkbox]").change(function(){
	if($(".r.ply-op .all-ck").attr("data-check") != "y"){
		$(".ins-box .ply-op span input[type=checkbox]").prop('checked',true);
		$(".all-ck").attr("data-check","y");
	}else{
		$(".ins-box .ply-op span input[type=checkbox]").prop('checked',false);
		$(".all-ck").attr("data-check","n");
	}
});

$(".ins-box .ply-op .all-ck input[type=checkbox]").change(function(){
	if($(this).parent(".all-ck").attr("data-check") != "y"){
		$(this).parent(".all-ck").next("ul").find("input[type='checkbox']").prop('checked',true);
		$(this).parent(".all-ck").attr("data-check","y");
	}else{
		$(this).parent(".all-ck").next("ul").find("input[type='checkbox']").prop('checked',false);
		$(this).parent(".all-ck").attr("data-check","n");
	}
});

// 상세검색
$(".tab_view .all-ck input[type=checkbox]").change(function(){
	if($(this).parent(".all-ck").attr("data-check") != "y"){
		$(this).parents(".view_cont").find("ul span input[type=checkbox]").prop('checked',true);
		$(this).parent(".all-ck").attr("data-check","y");
	}else{
		$(this).parents(".view_cont").find("ul span input[type=checkbox]").prop('checked',false);
		$(this).parent(".all-ck").attr("data-check","n");
	}
});

$(".tab_view > div").eq(0).show();
$(".normal_tab3 li a").on("click", function(){
	var idx = $(this).parent("li").index();
	$(".normal_tab3 li a").removeClass("active")
	$(this).addClass("active")

	$(".tab_view > div").hide()
	$(".tab_view > div").eq(idx).show()
})

$(".support_view_btn .btn_next").on("click", function(){
	if($(this).hasClass("active")){
		$(this).text("청년정책 상세검색 열기").removeClass("active")
		$(".detail_search").hide()
	} else {
		$(this).text("청년정책 상세검색 닫기").addClass("active")
		$(".detail_search").show()
	}
})

</script>

<!-- 중앙정부 청년정책  -->

	<div class="py-result-list">
		<h3 class="doc_tit02">중앙정부 청년정책</h3>
		<div class="result-list-top">
			<div class="l">
				<strong>검색건수 <span>163</span> 건</strong>
			</div>
			<div class="r">
				<select id="sortFieldParam" title="게시물 정렬 선택">
					<option value="exprRnkn" selected="selected">추천순</option>
					<option value="rdct" >인기순</option>
					<option value="initWord" >가나다순</option>
					<option value="DATE" >최신순</option>
				</select>
				<button type="button" onclick="javascript:f_order_search();">정렬</button>
			</div>
		</div>
		<div class="result-list-box" id="jynEmpSptList1">
			<ul>
				
					<li>
						<a href="javascript:fnGoDetail('201808270007')">
							
								
								
								
									<div class="srh-cate" style="margin-right:0px;">취업
										
											<span>지원</span>
										
									</div>
								
							
							<strong>
								WFK-청년봉사단(Korean University Council for Social Service, KUCSS)
							</strong>
							<div class="badge">
								
									<span class="recom">추천</span>
								
								
							</div>
							<div class="txt">
								해외 봉사를 통한 대학생들의 타문화 이해 증대와 국제 친선 및 국가브랜드 이미지 향상에 기여
							</div>
						</a>
					</li>
				
					<li>
						<a href="javascript:fnGoDetail('201808160009')">
							
								
								
								
									<div class="srh-cate" style="margin-right:0px;">주거
										
											<span>금융</span>
										
									</div>
								
							
							<strong>
								국가근로장학금
							</strong>
							<div class="badge">
								
								
							</div>
							<div class="txt">
								전공과 연계한 근로경험을 통해 취업능력을 제고하고, 생활비 지원을 통한 취업 전 사회·직업체험 기회 제공 및 안정적인 학업여건 조성 합니다.
							</div>
						</a>
					</li>
				
					<li>
						<a href="javascript:fnGoDetail('201903140005')">
							
								
								
								
									<div class="srh-cate" style="margin-right:0px;">취업
										
											<span>지원</span>
										
									</div>
								
							
							<strong>
								청년구직활동지원금
							</strong>
							<div class="badge">
								
									<span class="recom">추천</span>
								
								
									<span class="hot">HOT</span>
								
							</div>
							<div class="txt">
								미취업 청년의 자기주도적 구직활동 지원 (월50만원×6개월)
							</div>
						</a>
					</li>
				
					<li>
						<a href="javascript:fnGoDetail('201902270001')">
							
								
								
								
									<div class="srh-cate" style="margin-right:0px;">취업
										
											<span>지원</span>
										
									</div>
								
							
							<strong>
								청년취업성공패키지
							</strong>
							<div class="badge">
								
								
							</div>
							<div class="txt">
								- 청년 참여자의 특성 진단(프로파일링)을 토대로 최장 1년간 ｢상담․진단․경로설정(1단계) → 직업훈련, 일경험 등 직업능력증진(2단계) → 취업알선(3단계)｣을 단계별 맞춤형으로 제공하는 종합 취업지원 프로그램
							</div>
						</a>
					</li>
				
					<li>
						<a href="javascript:fnGoDetail('201903140006')">
							
								
								
								
									<div class="srh-cate" style="margin-right:0px;">취업
										
											<span>지원</span>
										
									</div>
								
							
							<strong>
								내일배움카드(실업자ㆍ구직자)
							</strong>
							<div class="badge">
								
								
							</div>
							<div class="txt">
								- 취ㆍ창업을 위해 직무수행능력 습득이 필요한 실업자 등에게 직업능력개발훈련 참여기회를 제공하여 (재)취직ㆍ창업 촉진과 생활안정 도모
							</div>
						</a>
					</li>
				
					<li>
						<a href="javascript:fnGoDetail('201903140012')">
							
								
								
								
									<div class="srh-cate" style="margin-right:0px;">취업
										
											<span>지원</span>
										
									</div>
								
							
							<strong>
								내일배움카드(근로자)
							</strong>
							<div class="badge">
								
								
							</div>
							<div class="txt">
								- 고용보험에 가입한 근로자 등이 직업능력 개발 훈련 참여를 통해 직무 경쟁력을 강화하여 평생 고용이 가능하도록 지원합니다.
							</div>
						</a>
					</li>
				
					<li>
						<a href="javascript:fnGoDetail('201903170001')">
							
								
								
								
									<div class="srh-cate" style="margin-right:0px;">주거
										
											<span>금융</span>
										
									</div>
								
							
							<strong>
								청년 우대형 청약통장
							</strong>
							<div class="badge">
								
								
							</div>
							<div class="txt">
								기존 주택청약보다 이율이 약 1.5% 높은 청년우대금리 제공(2년 이상시 3.3%)
							</div>
						</a>
					</li>
				
					<li>
						<a href="javascript:fnGoDetail('201903140026')">
							
								
								
								
									<div class="srh-cate" style="margin-right:0px;">주거
										
											<span>금융</span>
										
									</div>
								
							
							<strong>
								청년 보증부 월세대출
							</strong>
							<div class="badge">
								
								
							</div>
							<div class="txt">
								신혼부부·청년에게 저금리 대출상품 제공<br/>(보증금 연 1.8%, 월세금 연 1.5%)
							</div>
						</a>
					</li>
				
			</ul>
		</div>
	</div>
	<!-- // 중앙정부 청년정책  -->
	<div class="paging"><a href='#' class='btn_first' onclick='jynEmpPaging(1)'><span class="blind">처음페이지로 이동</span></a><a href='#' class='btn_prev' onclick='jynEmpPaging(0)'><span class="blind">이전페이지로 이동</span></a><a href='#' class='active' onclick='jynEmpPaging(1)'>1</a><a href='#' onclick='jynEmpPaging(2)'>2</a><a href='#' onclick='jynEmpPaging(3)'>3</a><a href='#' onclick='jynEmpPaging(4)'>4</a><a href='#' onclick='jynEmpPaging(5)'>5</a><a href='#' class='btn_next' onclick='jynEmpPaging(6)'><span class="blind">다음페이지로 이동</span></a><a href='#' class='btn_last' onclick='jynEmpPaging(21)'><span class="blind">마지막페이지로 이동</span></a></div>
	


<!-- 지자체 청년정책  -->

	<div class="py-result-list">
		<h3 class="doc_tit02">지자체 청년정책</h3>
		<div class="result-list-top">
			<div class="l">
				<strong>검색건수 <span>924</span> 건</strong>
			</div>
			<div class="r">
				<select id="sortFieldParam2" title="게시물 정렬 선택">
					<option value="exprRnkn" selected="selected">추천순</option>
					<option value="rdct" >인기순</option>
					<option value="initWord" >가나다순</option>
					<option value="DATE" >최신순</option>
				</select>
				<button type="button" onclick="javascript:f_order_search();">정렬</button>
			</div>
		</div>
		<div class="result-list-box cate-n" id="jynEmpSptList2">
			<ul>
				
					<li>
						<a href="javascript:fnGoDetail('201906130002')">
							<strong>
								(서울특별시) 청년 정책 한눈에 보기
							</strong>
							<div class="badge">
								
								
							</div>
							<div class="txt">
								# 서울특별시에서 운영 중인 청년 정책을 소개합니다
							</div>
						</a>
					</li>
				
					<li>
						<a href="javascript:fnGoDetail('201906130010')">
							<strong>
								(부산광역시) 청년 정책 한눈에 보기
							</strong>
							<div class="badge">
								
								
							</div>
							<div class="txt">
								# 부산광역시에서 운영 중인 청년 정책을 소개합니다.
							</div>
						</a>
					</li>
				
					<li>
						<a href="javascript:fnGoDetail('201906130004')">
							<strong>
								(인천광역시) 청년 정책 한눈에 보기
							</strong>
							<div class="badge">
								
								
							</div>
							<div class="txt">
								# 인천광역시에서 운영 중인 청년 정책을 소개합니다.
							</div>
						</a>
					</li>
				
					<li>
						<a href="javascript:fnGoDetail('201906120002')">
							<strong>
								(대구광역시) 청년 정책 한눈에 보기
							</strong>
							<div class="badge">
								
								
							</div>
							<div class="txt">
								# 대구광역시에서 운영 중인 청년 정책을 소개합니다.
							</div>
						</a>
					</li>
				
					<li>
						<a href="javascript:fnGoDetail('201906170002')">
							<strong>
								(광주광역시) 청년 정책 한눈에 보기
							</strong>
							<div class="badge">
								
								
							</div>
							<div class="txt">
								# 광주광역시에서 운영 중인 청년 정책을 소개합니다.
							</div>
						</a>
					</li>
				
					<li>
						<a href="javascript:fnGoDetail('201906200041')">
							<strong>
								(대전광역시) 청년 정책 한눈에 보기
							</strong>
							<div class="badge">
								
								
							</div>
							<div class="txt">
								# 대전광역시에서 운영 중인 청년 정책을 소개합니다.
							</div>
						</a>
					</li>
				
					<li>
						<a href="javascript:fnGoDetail('201906170001')">
							<strong>
								(울산광역시)청년 정책 한눈에 보기
							</strong>
							<div class="badge">
								
								
							</div>
							<div class="txt">
								울산광역시에서 운영 중인 청년 정책을 소개합니다.
							</div>
						</a>
					</li>
				
					<li>
						<a href="javascript:fnGoDetail('201906130005')">
							<strong>
								(세종특별자치시)청년 정책 한눈에 보기
							</strong>
							<div class="badge">
								
								
							</div>
							<div class="txt">
								세종특별자치시에서 운영 중인 청년 정책을 소개합니다.
							</div>
						</a>
					</li>
				
			</ul>
		</div>
	</div>
	<!-- // 지자체 청년정책  -->
	<div class="paging">
		<a href="#" class="btn_first" onclick="fn_move(1); return false;"><span class="blind">처음페이지로 이동</span></a><a href="#" class="btn_prev" onclick="fn_move(1); return false;"><span class="blind">이전페이지로 이동</span></a><a href="#n" class="active" onclick="1({1}); return false;">1</a><a href="#" onclick="fn_move(2); return false;">2</a><a href="#" onclick="fn_move(3); return false;">3</a><a href="#" onclick="fn_move(4); return false;">4</a><a href="#" onclick="fn_move(5); return false;">5</a><a href="#" class="btn_next" onclick="fn_move(6); return false;"><span class="blind">다음페이지로 이동</span></a><a href="#" class="btn_last" onclick="fn_move(116); return false;"><span class="blind">마지막페이지로 이동</span></a>

	</div>



			</div>
		</div>
		
		


		<!-- footer -->
		<a href="#wrap" class="btn_page_top">페이지상단으로</a>
		<div class="footer">
			<div class="inner">
				<p class="f_logo"><img src="/images/common/logo_footer.png" alt="온라인청년센터"></p>
	
				<div class="f_box f_contact">
					<p class="f_tit">CONTACT US</p>
					<p class="txt pb">27740 충청북도 음성군 맹동면 태정로6<br class="pc_content">한국고용정보원</p>
	
					<p class="txt"><strong>온라인청년센터</strong> 시스템관련문의<br><a href="http://work.kr/kakaoyouths" target="_blank" title="새창열림">work.kr/kakaoyouths</a><br class="pc_content">
					</p>
				</div>
	
				<div class="f_box f_sns">
					<p class="f_tit">SNS</p>
					<ul>
						<li class="sns01"><a href="http://blog.naver.com/we_are_youth" target="_blank" title="새창열림">온라인청년센터 블로그 바로가기</a></li>
						<li class="sns02"><a href="http://www.Instagram.com/weareyouth2019" target="_blank" title="새창열림">온라인청년센터 인스타그램 바로가기</a></li>
						<li class="sns03"><a href="http://www.youtube.com/channel/UCJPKwEaRF5KTaHp2FPnQBvQ" target="_blank" title="새창열림">온라인청년센터 유튜브 바로가기</a></li>
						<li class="sns04"><a href="http://www.facebook.com/weayouth" target="_blank" title="새창열림">온라인청년센터 페이스북 바로가기</a></li>
					</ul>
	
<!-- 					<p class="open_api">Open API</p> -->
				</div>
	
				<div class="f_box f_utill">
					<ul>
						<li><a href="/intro/centerIntro.do">온라인청년센터 소개</a></li>
						<li><a href="/member/term/memberTerm.do">이용약관</a></li>
						<li><a href="/member/term/privateTerm.do">개인정보처리방침</a></li>
						<li><a href="http://www.keis.or.kr/main/subIndex/811.do" target="_blank" title="새창열림">찾아오시는길</a></li>
					</ul>
				</div>
	
				<div class="f_box family_site">
					<p class="f_tit">관련사이트</p>
					<select onchange="window.open(this.value);" class="dropdown_m" title="관련사이트">
						<option selected="selected">관련사이트</option>
						<option value="http://www.moel.go.kr/">고용노동부</option>
						<option value="http://www.keis.or.kr/">한국고용정보원</option>
						<option value="http://www.work.go.kr/">워크넷</option>
						<option value="http://www.ei.go.kr/">고용보험</option>
						<option value="http://www.hrd.go.kr/">HRD-Net</option>
					</select>
	
					<div class="dropdown_pc">
						<p><a href="#n">관련사이트</a></p>
						<ul>
							<li><a href="http://www.moel.go.kr/" target="_blank" title="고용노동부 홈페이지 새창열림">고용노동부</a></li>
							<li><a href="http://www.keis.or.kr/" target="_blank" title="한국고용정보원 홈페이지 새창열림">한국고용정보원</a></li>
							<li><a href="http://www.work.go.kr/" target="_blank" title="워크넷 홈페이지 새창열림">워크넷</a></li>
							<li><a href="http://www.ei.go.kr/" target="_blank" title="고용보험 홈페이지 새창열림">고용보험</a></li>
							<li><a href="http://www.hrd.go.kr/" target="_blank" title="HRD-Net 홈페이지 새창열림">HRD-Net</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<!-- //footer -->
		
		<script type="text/javascript" src="/js/makePCookie.js"></script>
		
	</div>
</body>
</html>