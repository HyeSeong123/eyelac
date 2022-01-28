package egovframework.eyelac.member.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import egovframework.eyelac.member.service.MemberService;
import egovframework.eyelac.member.service.impl.MemberVO;
import egovframework.eyelac.util.Util;

@Controller
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	MappingJackson2JsonView jsonView;
	
	@Resource(name="memberService")
	private MemberService memberService;
	
	@RequestMapping("/user/member/join_policy.do")
    public ModelAndView showJoinPolicy(ModelAndView mav, @RequestParam Map<String, Object> param) throws Exception {
		String afterLoginURI = (String) param.get("requestURI");
		
		mav.addObject("afterLoginURI", afterLoginURI);
		mav.addObject("param", param);
		 
        mav.setViewName("/user/member/join_policy.user");
        return mav;
    }
	
	@RequestMapping("/user/member/join_policyCheck.do")
    public ModelAndView checkJoinPolicy(HttpServletRequest req, @RequestParam Map<String, Object> param) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		Map<String, Object> result = new HashMap<>();
		
		result = memberService.checkJoinPolicy(param);
		
		mav.addObject("result", result);
		
		mav.setView(jsonView);
		
		return mav;
    }
	
	@RequestMapping("/user/member/join.do")
    public ModelAndView showJoin(HttpServletRequest req,  ModelAndView mav, @RequestParam Map<String, Object> param) throws Exception {
		
		String marketing = req.getParameter("marketing");
		
		if( marketing != null) {
			if( marketing.equals("on") ) {
				mav.addObject("SMSAgree", "on");
				mav.addObject("emailAgree", "on");
			}
		}
		
		mav.addObject("param",param);
		
		mav.setViewName("/user/member/join.user");
		
        return mav;
    }
	
	@RequestMapping("/user/member/doJoin.do")
    public ModelAndView doJoin(HttpServletRequest req, @RequestParam Map<String,Object> param) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		String smsAgree = (String) param.get("SMSAgree");
		
		if(smsAgree == null) {
			smsAgree = "N";
			param.put("smsAgree", smsAgree);
		}
		
		Map<String, Object> result = new HashMap<>();
		
		result = memberService.checkJoinMember(param);
		
		String msg = (String) result.get("resultCode");
		
		logger.debug("param= " + param);
		
		if( msg.contains("S-1") == false ) {
			
			mav.setView(jsonView);
			mav.addObject("result", result);
			
			return mav;
		}
		
		memberService.doJoin(param);
		String redirectUrl = "/user/member/login.do";
		
		mav.setView(jsonView);
		
		mav.addObject("redirectURI" , redirectUrl);
		mav.addObject("result", result);
		
		return mav;
    }
	
	@RequestMapping("/user/member/login.do")
    public ModelAndView showLogin(ModelAndView mav, @RequestParam Map<String, Object> param) throws Exception {
        
		String afterLoginURI = (String) param.get("requestURI");
		if(afterLoginURI != null) {
			mav.addObject("afterLoginURI", afterLoginURI);
		}
        mav.setViewName("/user/member/login.user");
        return mav;
    }
	
	@RequestMapping("/user/member/logout.do")
    public String showLogout(HttpServletRequest req,HttpSession session, String redirectURI) throws Exception {
        
		session.removeAttribute("loginedMember");
		
		redirectURI =  Util.ifNull(redirectURI, "/user/index.do");
		
        return Util.msgAndReplace(req, "로그아웃 되었습니다.", redirectURI);
    }
	
	@RequestMapping("/user/member/doLogin.do")
	@ResponseBody
    public ModelAndView doLogin(HttpServletRequest req, HttpSession session, @RequestParam Map<String,Object> param) throws Exception {
    	
		Map<String, Object> result = memberService.doLoginCheck(param);
		
		ModelAndView mav = new ModelAndView();
		
		String msg = (String) result.get("resultCode");
		
		if( ! msg.contains("S-") ) {
			mav.addObject("result", result);
			mav.setView(jsonView);
			
			return mav;
		}
		
		String memberName = (String) param.get("memberName");
		
		MemberVO member = memberService.getMemberByMemberName(memberName);
		
		String afterLoginURI = (String) param.get("afterLoginURI");
        
        if(afterLoginURI == null || afterLoginURI == "") {
        	afterLoginURI = "/user/index.do";
        }
        
        if(afterLoginURI.contains("member")) {
        	afterLoginURI = null;
        }
        
        result.put("afterLoginURI", afterLoginURI);
        
		mav.addObject("result", result);
		
		session.setAttribute("loginedMember", member);
		
		mav.setView(jsonView);
		
		return mav;
    }
	
	@RequestMapping("/user/member/memberFindPw.do")
    public ModelAndView showMemberFindPw(HttpServletRequest req, HttpSession session, @RequestParam Map<String,Object> param, String afterLoginURI) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("/user/member/memberFindPw.user");
		
		return mav; 
    }
	@RequestMapping("/user/member/doFindPw.do")
	public ModelAndView doFindPw(HttpServletRequest req, HttpSession session, @RequestParam Map<String, Object> param) {
		
		ModelAndView mav = new ModelAndView();
		
		Map<String, Object> result = new HashMap<>();
		
		result = memberService.ChangePw(param);
		
		mav.addObject("result", result);
		
		logger.debug("result= " + result);
		
		mav.setView(jsonView);
		return mav;
	}
	
	@RequestMapping("/user/member/identification.do")
    public ModelAndView showMyInforBeforePage(HttpServletRequest req, HttpSession session, @RequestParam Map<String,Object> param, String afterLoginURI) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("/user/member/identification.user");
		return mav; 
    }	
}
