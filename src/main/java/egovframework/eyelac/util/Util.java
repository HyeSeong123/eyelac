package egovframework.eyelac.util;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public class Util {

	public static String msgAndBack(HttpServletRequest req, String msg) {
		req.setAttribute("historyBack", true);
		req.setAttribute("msg", msg);
		return "common/redirect";
	}

	public static String msgAndReplace(HttpServletRequest req, String msg, String redirectUrl) {
		req.setAttribute("redirectUrl", redirectUrl);
		req.setAttribute("msg", msg);
		return "common/redirect";
	}
	
	public static <T> T ifNull(T data, T defaultValue) {
		return data != null ? data : defaultValue;
	}

	public static <T> T reqAttr(HttpServletRequest req, String attrName, T defaultValue) {
		return (T) ifNull(req.getAttribute(attrName), defaultValue);
	}
	
	public static Map<String, Object> getParamMap(HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();

		Enumeration<String> parameterNames = request.getParameterNames();

		while (parameterNames.hasMoreElements()) {
			String paramName = parameterNames.nextElement();
			Object paramValue = request.getParameter(paramName);

			param.put(paramName, paramValue);
		}

		return param;
	}

	public static String replace(HttpServletRequest req, String redirectUrl) {
		req.setAttribute("redirectUrl", redirectUrl);
		return "common/redirect";
	}

	public static Map<String, Object> MapResultReturn(String resultCode, String resultMsg) {
		Map<String, Object> result = new HashMap<>();
		
		result.put("resultCode", resultCode);
		result.put("resultMsg", resultMsg);
		
		return result;
	}
	
	public static Map<String, Object> MapResultAlert(String resultCode, String alertTitle, String alertMsg, String alertIcon) {
		Map<String, Object> result = new HashMap<>();
		
		result.put("resultCode", resultCode);
		result.put("alertTitle", alertTitle);
		result.put("alertMsg", alertMsg);
		result.put("alertIcon", alertIcon);
		
		return result;
	}
	
}
