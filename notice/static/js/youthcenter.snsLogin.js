youthcenter.snsLogin = {
	loginUrl 			: '',
	processUrl 			: '',
	//실운영키
	kakaoApiKey 		: '9395af74385e92777d82c386e741f1dd',
	kakaoRestApiKey 	: 'ad99de70219e1f6127849ca86cb52316',
	//테스트서버
	snsDomin : '',
	//통합테스트
	//kakaoApiKey 		: '92291bcf63c0c3acc51223bc6460c382',
	//kakaoRestApiKey 	: '8112aa6d186bde516f4b1f19cad38006',
	googleApiKey 		: '428464360447-55taar8j1n6sd6cm8gcb3212r3uuo81o.apps.googleusercontent.com',
	popupYN				: 'N',

	// 소셜로그인을 초기화 합니다.
	init : function(loginUrl, processUrl, popupYN) {
		youthcenter.snsLogin.loginUrl = loginUrl;
		youthcenter.snsLogin.processUrl = processUrl;
		youthcenter.snsLogin.popupYN = popupYN;

		if (youthcenter.snsLogin.getQueryString("redirectEncodeYn") != undefined) {
			cookies = "loginRedirectEncodeYn=" + escape(youthcenter.snsLogin.getQueryString("redirectEncodeYn")) +"; path=/";
			document.cookie = cookies;
		} else {
			cookies = "loginRedirectEncodeYn=; path=/";
			document.cookie = cookies;
		}

		// 리다이렉트URL이 있으면 쿠키에 저장해 둡니다.
		if (youthcenter.snsLogin.getQueryString("redirectUrl") != undefined) {
			cookies = "loginRedirectUrl=" + escape(youthcenter.snsLogin.getQueryString("redirectUrl")) +"; path=/";
			document.cookie = cookies;
		} else {
			cookies = "loginRedirectUrl=; path=/";
			document.cookie = cookies;
		}

		// 리로드폼ID가 있으면 쿠키에 저장해 둡니다.
		if (youthcenter.snsLogin.getQueryString("reloadFormId") != undefined) {
			cookies = "loginReloadFormId=" + escape(youthcenter.snsLogin.getQueryString("reloadFormId")) +"; path=/";
			document.cookie = cookies;
		} else {
			cookies = "loginReloadFormId=; path=/";
			document.cookie = cookies;
		}

		// 콜시스템 있으면 쿠키에 저장해 둡니다.
		if (youthcenter.snsLogin.getQueryString("callSystem") != undefined) {
			cookies = "loginCallSystem=" + escape(youthcenter.snsLogin.getQueryString("callSystem")) +"; path=/";
			document.cookie = cookies;
		} else {
			cookies = "loginCallSystem=; path=/";
			document.cookie = cookies;
		}

		// 팝업여부를 쿠키에 저장해 둡니다.
		cookies = "popupYN=" + escape(youthcenter.snsLogin.popupYN) + "; path=/";
		document.cookie = cookies;

		// 문서에 폼추가
		var snsLoginFrm = $("#snsLoginFrm");

/*		if ($("#snsLoginFrm").length == 0) {
			$("body").append("<form:form commandName='snsLoginVO' id='snsLoginFrm' method='post' action='" + youthcenter.snsLogin.processUrl + "'><input type='hidden' name='snsType' id='snsType' value=''/><input type='hidden' name='accessToken' id='accessToken' value=''/><input type='hidden' name='redirectUrl' value='" + processUrl + "'/></form:form>");
			//$("body").append("<form id='snsLoginFrm' method='post' action='" + youthcenter.snsLogin.processUrl + "'><input type='hidden' name='snsType' id='snsType' value=''/><input type='hidden' name='accessToken' id='accessToken' value=''/><input type='hidden' name='redirectUrl' value='" + youthcenter.snsLogin.snsDomin+youthcenter.snsLogin.processUrl + "'/></form>");
		}*/
	},
	kakaoLogin : function() {
		$.ajax({
			type: 'GET',
			url: '/member/snsLoginReturnDomain.do',
			dataType: 'json',
			async: false,
			beforeSend: function(request){
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				if(token != null && token != 'undefinded'){
					request.setRequestHeader(header, token);
				}else if(oThis.header != null && oThis.token != null ){
					request.setRequestHeader(oThis.header, oThis.token);
				}
			},
			error: function(request, status, error){
				alert("서버주소를 가지고 올 수 없습니다." + error);
			},
			success: function(ret) {
				youthcenter.snsLogin.snsDomin = ret.ajaxResult;

				if (youthcenter.snsLogin.popupYN == "Y") {
					var url = "https://kauth.kakao.com/oauth/authorize?client_id=" + youthcenter.snsLogin.kakaoRestApiKey + "&redirect_uri=" + encodeURIComponent(youthcenter.snsLogin.snsDomin+youthcenter.snsLogin.processUrl+"?snsType=kakao") + "&response_type=code";
					window.location.href = url;
				} else {

					// kakao sns login module과 requirejs 충돌 문제 해결
					var _Kakao;
					var afterLoadKakaoSnsLoginModule = function() {
						_Kakao.cleanup();
						_Kakao.init(youthcenter.snsLogin.kakaoApiKey);
						_Kakao.Auth.loginForm({
							success: function(authObj) {
								$("#snsLoginFrm #snsType").val("kakao");
								$("#snsLoginFrm #accessToken").val(authObj.access_token);
								$("#snsLoginFrm #redirectUrl").val(youthcenter.snsLogin.snsDomin+youthcenter.snsLogin.processUrl);
								$("#snsLoginFrm").submit();
							},fail: function(err) {
								alert("카카오 로그인에 실패하였습니다...");
							}
						});
					};

					if ( typeof(requirejs) == 'function' ) {
						requirejs(["//developers.kakao.com/sdk/js/kakao.min.js"], function(kakao){
							_Kakao = kakao;
							afterLoadKakaoSnsLoginModule();
						});
					} else {
						youthcenter.snsLogin.loadScript("//developers.kakao.com/sdk/js/kakao.min.js", function() {
							_Kakao = Kakao;
							afterLoadKakaoSnsLoginModule()
						});
					}

				}
			}
		});
	},
	naverLogin: function() {
		var random = new Date();

		var url = "/member/naverLoginSession.do?processUrl=" + encodeURIComponent(youthcenter.snsLogin.processUrl+"?snsType=naver")  + "&" + random.getTime();

		$.ajax({
			type: 'GET',
			url: url,
			dataType: 'json',
			async: false,
			beforeSend: function(request){
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				if(token != null && token != 'undefinded'){
					request.setRequestHeader(header, token);
				}else if(oThis.header != null && oThis.token != null ){
					request.setRequestHeader(oThis.header, oThis.token);
				}
			},
			error: function(request, status, error){
				alert("네이버 로그인에 실패하였습니다...");
			},
			success: function(ret) {
				var  url = ret.ajaxResult;
				if (youthcenter.snsLogin.popupYN == "Y") {
					window.location = url;
				} else {
					console.log(url);
					keis.window.newWindow(url, 'popLogin', 510, 420, 'yes');
				}
			}
		});
	},
	facebookLogin : function() {
		if (youthcenter.snsLogin.popupYN == "Y") {
			if (opener.youthcenter.snsLogin != null && opener.youthcenter.snsLogin != undefined) {
				cookies = "popupYN=N; path=/";
				document.cookie = cookies;
				opener.youthcenter.snsLogin.facebookLogin();
				self.close();
			} else {
				FB.login(function(response) {
					if (response.authResponse != null) {
						window.location = youthcenter.snsLogin.processUrl + "?snsType=facebook&accessToken=" + response.authResponse.accessToken;
					}
				});
			}
		} else {
			FB.login(function(response) {
				if (response.authResponse != null) {
					window.location = youthcenter.snsLogin.processUrl + "?snsType=facebook&accessToken=" + response.authResponse.accessToken;
				}
			});
		}
	},
	googleLogin : function() {
		var url = "https://accounts.google.com/o/oauth2/auth";
		url += "?access_type=offline";
		url += "&client_id=" + youthcenter.snsLogin.googleApiKey;
		url += "&redirect_uri=" + encodeURIComponent(youthcenter.snsLogin.processUrl + "?snsType=google");
		url += "&response_type=code";
		url += "&scope=email%20profile";
		url += "&approval_prompt=force";

		if (youthcenter.snsLogin.popupYN == "Y") {
			window.location.href = url;
		} else {
			keis.window.newWindow(url, 'popLogin', 600, 600, 'yes');
		}
	},

	logout : function(snsType, url, alterMsgYn) {//2018.08.20 alterMsgYn add 김문수
		if ($("#snsLogoutFrame").length == 0) {
			$("body").append("<iframe id='snsLogoutFrame' src='' style='display:none' title='데이터 처리용 프레임'></iframe>");
		}

		if (snsType == "naver") {
			$("#snsLogoutFrame").bind("load", function(event) {
				if(alterMsgYn != 'N' && alterMsgYn != 'NC' ) {
					alert("로그아웃 되었습니다...");
					location.href = url;
				} else if (alterMsgYn == 'NC'){
					opener.location.href = url;
					self.close();
				} else {
					opener.location.href = url;
					self.close();
				}
			});

			document.getElementById("snsLogoutFrame").src = 'https://nid.naver.com/nidlogin.logout';
		} else if (snsType == "google") {
			$("#snsLogoutFrame").bind("load", function(event) {
				if(alterMsgYn != 'N' && alterMsgYn != 'NC' ) {
					alert("로그아웃 되었습니다.");
					location.href = url;
				} else if (alterMsgYn == 'NC'){
					opener.location.href = url;
					self.close();
				} else {
					opener.location.href = url;
					self.close();
				}
			});

			document.getElementById("snsLogoutFrame").src = 'https://accounts.google.com/logout';
		} else if (snsType == "kakao") {

			// kakao sns login module과 requirejs 충돌 문제 해결
			var _Kakao;
			var afterLoadKakaoSnsLoginModule_Logout = function() {
				Kakao.cleanup();
				Kakao.init(youthcenter.snsLogin.kakaoApiKey);
				console.log("youthcenter.snsLogin.kakaoApiKey : " + youthcenter.snsLogin.kakaoApiKey);
				Kakao.Auth.logout(function(result) {
					if(alterMsgYn != 'N' && alterMsgYn != 'NC' ) {
						alert("로그아웃 되었습니다.");
						location.href = url;
					} else if (alterMsgYn == 'NC'){
						opener.location.href = url;
						self.close();
					} else {
						opener.location.href = url;
						self.close();
					}
				});
			};

			if ( typeof(requirejs) == 'function' ) {
				requirejs(["//developers.kakao.com/sdk/js/kakao.min.js"], function(kakao){
					_Kakao = kakao;
					afterLoadKakaoSnsLoginModule_Logout();
				});
			} else {
				youthcenter.snsLogin.loadScript("//developers.kakao.com/sdk/js/kakao.min.js", function() {
					_Kakao = Kakao;
					afterLoadKakaoSnsLoginModule_Logout()
				});
			}
		} else if (snsType == "facebook") {
			FB.getLoginStatus(function(response) {
				if (response && response.status == 'connected') {
					FB.logout(function(response) {
						if(alterMsgYn != 'N' && alterMsgYn != 'NC' ) {
							alert("로그아웃 되었습니다...");
							location.href = url;
						} else if (alterMsgYn == 'NC'){
							opener.location.href = url;
							self.close();
						} else {
							opener.location.href = url;
							self.close();
						}
					});
				} else {
					location.href = url;
				}
			});
		}
	},
	loadScript : function(url, callback) {
		var script = document.createElement("script");
		script.type = "text/javascript";

		 if (script.readyState) {
			 script.onreadystatechange = function() {
				 if (script.readyState == "loaded" || script.readyState == "complete") {
					 script.onreadystatechange = null;
					 callback();
				 }
			 };
		 } else {
			 script.onload = function() {
				 callback();
			 };
		 }

		 script.src = url;
		 document.getElementsByTagName("head")[0].appendChild(script);
	},
	getQueryString: function(paramName) {
		var _tempUrl = window.location.search.substring(1);
		var _tempArray = _tempUrl.split("&");

		for (var i=0; i<_tempArray.length; i++) {
			/*var _keyValuePair = _tempArray[i].split("=");


			if (_keyValuePair[0] == paramName) {
				return _keyValuePair[1];
			}*/


			var _keyPair = _tempArray[i].substring(0, _tempArray[i].indexOf('='));
			var _valPair = _tempArray[i].substring(_tempArray[i].indexOf('=')+1, _tempArray[i].length);

			if (_keyPair == paramName) {
				return _valPair;
			}
		}
	}



};
