function Nethru_getCookieVal(dc, offset)
{
	var endstr = dc.indexOf (";", offset);
	if (endstr == -1)
		endstr = dc.length;
	return unescape(dc.substring(offset, endstr));
}

function Nethru_SetCookie(name, value){
   var argv = Nethru_SetCookie.arguments;
   var argc = Nethru_SetCookie.arguments.length;
   var expires = (2 < argc) ? argv[2] : null;
   var path = (3 < argc) ? argv[3] : null;
   var domain = (4 < argc) ? argv[4] : null;
   var secure = (5 < argc) ? argv[5] : false;

   document.cookie = name + "=" + escape (value) +
        ((expires == null) ? "" : ("; expires="+expires.toGMTString())) +
     ((path == null) ? "" : ("; path=" + path)) +
     ((domain == null) ? "" : ("; domain=" + domain)) +
        ((secure == true) ? "; secure" : "");

}

function Nethru_GetCookie(name){
   var arg = name + "=";
   var alen = arg.length;
   var clen = document.cookie.length;
   var dc = document.cookie;
   var i = 0;
   while (i < clen)
      {
      var j = i + alen;
      if (dc.substring(i, j) == arg)
         return Nethru_getCookieVal(dc, j);
      i = dc.indexOf(" ", i) + 1;
      if (i == 0)
         break;
      }
  return null;
}

function Nethru_makePersistentCookie(name,length,path,domain)
{
    var today = new Date();
    var expiredDate = new Date(2100,1,1);
    var cookie;
	var value;

    cookie = Nethru_GetCookie(name);
    if ( cookie ) {
        return 1;
	}

	var values = new Array();
	for ( i=0; i < length ; i++ ) {
		values[i] = "" + Math.random();
	}

	value = today.getTime();
	for ( i=0; i < length ; i++ ) {
		value += values[i].charAt(2);
	}

    Nethru_SetCookie(name,value,expiredDate,path,domain);
}


function Nethru_makePersistentCookie1(name,length,path,domain)
{
	if ( domain == null ) return 1;						
        	var expiredDate = new Date(2100,1,1);

	
        	var vn_screenx = screen.width; 					
                var vn_screeny = screen.height; 					
	var vn_screenc = screen.colorDepth; 					
		
	var resolution_cookiename = name + "_RESOLUTION";			
	var color_cookiename = name + "_COLOR";				
	
	var resolution_value = screen.width + "*" + vn_screeny;
	var color_value = vn_screenc;
	
	var resolution_cookie;
	var color_cookie;

        	resolution_cookie = Nethru_GetCookie(resolution_cookiename);
        	color_cookie = Nethru_GetCookie(color_cookiename)

	
        if ( resolution_cookie ) {						
        		
        	if ( resolution_cookie != resolution_value ) {			
        		Nethru_SetCookie(resolution_cookiename,resolution_value,expiredDate,path,domain);  	
			
		}
	}
	else
	{	
        		Nethru_SetCookie(resolution_cookiename,resolution_value,expiredDate,path,domain);
        		
	}
	
        	if ( color_cookie ) {							
        		if ( color_cookie != color_value ) {			
        		Nethru_SetCookie(color_cookiename,color_value,expiredDate,path,domain);  	
			
			
		}
	}
	else
	{								
        		Nethru_SetCookie(color_cookiename,color_value,expiredDate,path,domain);
        		
	}

}

function n_isIpType(val) {
	if ( val.length != 4 ) return false;
	
	for ( var i=0; i < 4; i++) {
		if ( !n_isInteger(val[i]) ) {
			return false;
		}
	}
	
	return true;
}

function n_isInteger(val) {
	if (n_isBlank(val)) {
		return false;
	}
	
	for ( var i=0; i < val.length;i++) {
		if ( !n_isDigit(val.charAt(i))) {
			return false;
		}
	}
	
	return true;
}

function n_isDigit(num) {
	if ( num.length>1) {
		return false;
	}
	
	var string="1234567890";
	
	if ( string.indexOf(num) != -1) {
		return true;
	}
	
	return false;
}

function n_isBlank(val) {
	if (val == null) {
		return true;
	}
	
	for (var i=0; i < val.length; i++) {
		if ( (val.charAt(i) != ' ') && (val.charAt(i) != "\t")&&(val.charAt(i) != "\n") && (val.charAt(i)!= "\r")) {
			return false;
		}
	}
	
	return true;
}

function Nethru_getDomain()
{
	var _host   = document.domain;
	var so = _host.split('.');
	
	if ( n_isIpType(so)) {
		return ( so[0] + '.' + so[1] + '.' + so[2] + '.' + so[3]);
	}
	
	if ( so.length != 4 && so.length != 3 ) {
		return _host;
	}
	
	var dm  = so[so.length-2] + '.' + so[so.length-1];

	return (so[so.length-1].length == 2) ? so[so.length-3] + '.' + dm : dm;
}

var Nethru_domain  = Nethru_getDomain();

Nethru_makePersistentCookie("PCID",10,"/",Nethru_domain);
Nethru_makePersistentCookie1("RC",10,"/",Nethru_domain);