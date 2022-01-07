package egovframework.eyelac.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Component("needToLogoutIntercepter")
public class NeedToLogoutIntercepter extends HandlerInterceptorAdapter{
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object Handler) throws Exception{
		
		boolean isLogined = (boolean) req.getAttribute("isLogined");
		
		boolean isAjax = (boolean) req.getAttribute("isAjax");
		System.out.println("interAjax = " + isAjax);
		if (isLogined) {
			String resultCode = "F-LO";
			String resultMsg = "로그아웃 후 이용해주세요.";
			
			if (isAjax == false) {
				resp.setContentType("text/html; charset=UTF-8");
				resp.getWriter().append("<script>");
				resp.getWriter().append("alert('" + resultMsg +"');");
				resp.getWriter().append("location.replace('/user/index.do');");
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
