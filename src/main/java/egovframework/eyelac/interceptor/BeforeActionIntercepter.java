package egovframework.eyelac.interceptor;

import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.eyelac.board.service.BoardService;
import egovframework.eyelac.board.service.impl.BoardVO;
import egovframework.eyelac.member.service.MemberService;
import egovframework.eyelac.member.service.impl.MemberVO;
import egovframework.eyelac.util.Util;

@Component("beforeActionIntercepter")
public class BeforeActionIntercepter extends HandlerInterceptorAdapter{
	
	private static final Logger logger = LoggerFactory.getLogger(BeforeActionIntercepter.class);
	
	@Resource(name="boardService")
	private BoardService boardService;
	
	@Resource(name="memberService")
	private MemberService memberService;
	
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object Handler) throws Exception{
		
		String requestURI = req.getRequestURI();
		
		logger.debug("requestURI= " + requestURI);
		
		if ( requestURI == null ) {
			Util.replace(req, "/index.do");
		}
		
		HttpSession session = req.getSession();
		MemberVO loginedMember = (MemberVO) session.getAttribute("loginedMember");
	
		boolean isLogined = false;
		boolean isAjax = requestURI.endsWith("Ajax");
		Map<String, Object> param = Util.getParamMap(req);
		Enumeration<String> parameterNames = req.getParameterNames();
		
		if (isAjax == false) {
			if (param.containsKey("ajax") && param.get("ajax").equals("Y")) {
				isAjax = true;
			}
		}
		
		while (parameterNames.hasMoreElements()) {
			String paramName = parameterNames.nextElement();
			Object paramValue = req.getParameter(paramName);

			param.put(paramName, paramValue);
		}
		
		if(loginedMember != null) {
			isLogined = true;
		}
		
		List<BoardVO> boards1 = boardService.getBoardsByDepth(1);
		List<BoardVO> boards2 = boardService.getBoardsByDepth(2);
		List<BoardVO> boards3 = boardService.getBoardsChildrenCnt();
		
		req.setAttribute("boards", boards1);
		req.setAttribute("boards2", boards2);
		req.setAttribute("boards3", boards3);
		req.setAttribute("isLogined", isLogined);
		req.setAttribute("isAjax", isAjax);
		req.setAttribute("requestURI", requestURI);
		req.setAttribute("loginedMember", loginedMember);
		
		return true;
	}
}
