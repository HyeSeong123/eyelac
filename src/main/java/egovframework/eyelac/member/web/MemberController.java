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
    public String checkJoinPolicy(HttpServletRequest req, @RequestParam Map<String, Object> param) throws Exception {
		logger.debug("param= " + param);
		
		String policyUse = (String) param.get("policyUse");
		String privacyPolicy = (String) param.get("privacyPolicy");
		String marketing = (String) param.get("marketPolicy");
		
		if( policyUse == null || policyUse.trim().equals("on") == false ) {
			return Util.msgAndReplace(req, "이용약관에 동의 해주셔야 회원가입이 가능합니다", "/user/member/join_policy.user");
		}
		
		if( privacyPolicy == null || privacyPolicy.trim().equals("on") == false ) {
			return Util.msgAndReplace(req, "개인정보 처리방침에 동의 해주셔야 회원가입이 가능합니다", "/user/member/join_policy.user");
		}
		
		String url = "/user/member/join.do";
		
		if( marketing != null ) {
			url= url + "?marketing=" + marketing;
		}
		
		logger.debug("url= " + url);
		
		return Util.replace(req, url);
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
	
	@RequestMapping("/user/member/memberIdDupliCheck.do")
    public ModelAndView doMemberIdDupliCheck(HttpServletRequest req, @RequestParam("memberId") String memberId) throws Exception {
		
		ModelAndView mav = new ModelAndView();

		Map<String, Object> dupIdValidation = memberService.memberIdDuplicateResult(memberId); 
		
		mav.addObject("result", dupIdValidation);
		
		mav.setView(jsonView);
		return mav; 
	}
	@RequestMapping("/user/member/doJoin.do")
    public ModelAndView doJoin(HttpServletRequest req, @RequestParam Map<String,Object> param) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		String smsAgree = (String) param.get("SMSAgree");
		String emailAgree = (String) param.get("emailAgree");
		
		if(smsAgree == null) {
			smsAgree = "N";
			param.put("smsAgree", smsAgree);
		}
		
		if(emailAgree == null) {
			emailAgree = "N";
			param.put("emailAgree", emailAgree);
		}
		
		Map<String, Object> result = new HashMap<>();
		
		result = memberService.checkJoinMember(param);
		
		String msg = (String) result.get("resultCode");
		
		if( msg.contains("S-1") == false ) {
			
			mav.setView(jsonView);
			mav.addObject("result", result);
			
			return mav;
		}
		
		memberService.doJoin(param);
		
		mav.setView(jsonView);
		mav.addObject("result", result);
		
		String redirectUrl = "/user/member/login.do";
		
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
    public ModelAndView doLogin(HttpServletRequest req, HttpSession session, @RequestParam Map<String,Object> param) throws Exception {
    	
		ModelAndView mav = new ModelAndView();
		
		Map<String, Object> result = memberService.getLoginMsg(param); 
		
		String msg = (String) result.get("resultCode"); 
		
		MemberVO member = (MemberVO) result.get("member");
		
		if( ! "통과".equals(msg) ) {
			mav.addObject("result", result);
			mav.setView(jsonView);
			
			return mav;
		}
		
        msg = String.format("%s님의 로그인을 환영합니다.", member.getMemberName() );
        
        String afterLoginURI = (String) param.get("afterLoginURI");
        
        if(afterLoginURI.contains("member")) {
        	afterLoginURI = null;
        }
        
        if(afterLoginURI == null || afterLoginURI == "") {
        	afterLoginURI = "/user/index.do";
        }
        
        result.put("afterLoginURI", afterLoginURI);
        
		mav.setView(jsonView);
		
		session.setAttribute("loginedMember", member);
		mav.addObject("result", result);
		
		return mav;
    }
	
	@RequestMapping("/user/member/memberFindId.do")
    public ModelAndView showMemberFindId(HttpServletRequest req, HttpSession session, @RequestParam Map<String,Object> param, String afterLoginURI) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("/user/member/memberFindId.user");
		
		return mav; 
    }
	
	@RequestMapping("/user/member/memberFindPw.do")
    public ModelAndView showMemberFindPw(HttpServletRequest req, HttpSession session, @RequestParam Map<String,Object> param, String afterLoginURI) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("/user/member/memberFindPw.user");
		
		return mav; 
    }
	@RequestMapping("/user/member/doFindId.do")
	public ModelAndView doFindId(HttpServletRequest req, HttpSession session, @RequestParam Map<String, Object> param) {
		
		ModelAndView mav = new ModelAndView();
		
		MemberVO member = memberService.getMemberByMemberNameAndEmail(param);
		
		if(member == null) {
			mav.addObject("resultCode", "F-1 입력하신 정보와 일치하는 아이디가 없습니다.");
			
			mav.setView(jsonView);
			
			return mav;
		}
		
		String memberId = (String) member.getMemberId();
		mav.addObject("resultCode" , "S-1 회원님의 아이디는 " + memberId + " 입니다.");
		
		mav.setView(jsonView);
		return mav;
	}
	
	@RequestMapping("/user/member/doFindPw.do")
	public ModelAndView doFindPw(HttpServletRequest req, HttpSession session, @RequestParam Map<String, Object> param) {
		
		ModelAndView mav = new ModelAndView();
		
		MemberVO member = memberService.getMemberByIdAndEmailAndBirth(param);
		
		if(member == null) {
			mav.addObject("resultCode", "F-1 입력하신 정보와 일치하는 계정이 없습니다.");
		}
		
		mav.setView(jsonView);
		return mav;
	}
	
	@RequestMapping("/user/member/myInforBeforePage.do")
    public ModelAndView showMyInforBeforePage(HttpServletRequest req, HttpSession session, @RequestParam Map<String,Object> param, String afterLoginURI) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("/member/myInforBeforePage");
		
		return mav; 
    }
	
	@RequestMapping("/user/member/myInfor.do")
    public ModelAndView myInfor(HttpServletRequest req, HttpSession session, @RequestParam Map<String,Object> param, String afterLoginURI) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		String memberId = (String) param.get("memberId");
		Integer changeMemberId = Integer.parseInt(memberId);
		
		if(memberId != null) {
			MemberVO member = memberService.getMemberById(changeMemberId);
			
			if ( member != null ) {
				mav.addObject("member", member);
			}
		}
		
		mav.setView(jsonView);
		
		mav.setViewName("/member/myInfor");
		
		return mav; 
    }

}
