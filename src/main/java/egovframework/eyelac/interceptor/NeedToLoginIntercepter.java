package egovframework.eyelac.interceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.eyelac.member.service.MemberService;
import egovframework.eyelac.util.Util;

@Component("needToLoginIntercepter")
public class NeedToLoginIntercepter extends HandlerInterceptorAdapter{
	
	@Resource(name="memberService")
	private MemberService memberService;
	
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object Handler) throws Exception{
		
		boolean isLogined = (boolean) req.getAttribute("isLogined");
		
		boolean isAjax = (boolean) req.getAttribute("isAjax");
		
		if (isLogined == false) {
			String resultCode = "F-L";
			String resultMsg = "로그인 후 이용해주세요.";
			
			if (isAjax == false) {
				resp.setContentType("text/html; charset=UTF-8");
				resp.getWriter().append("<script>");
				resp.getWriter().append("alert('" + resultMsg +"');");
				resp.getWriter().append("location.replace('/user/member/login.do?afterLoginUrl=" + Util.reqAttr(req, "afterLoginURI", "/user/index.do") + "');");
				resp.getWriter().append("</script>");
			} else {
				resp.setContentType("application/json; charset=UTF-8");
				resp.getWriter().append("{\"resultCode\":\"" + resultCode + "\",\"msg\":\"" + resultMsg + "\"}");
			}
			
			return false;
		}
		
		return true;
	}
}
