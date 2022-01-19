package egovframework.eyelac.email.web;

import java.io.PrintWriter;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.eyelac.member.service.MemberService;
import egovframework.eyelac.util.TempKey;

@Controller
public class EmailController {
	private static final Logger logger = LoggerFactory.getLogger(EmailController.class);
	@Autowired
	private JavaMailSenderImpl mailHandler;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Resource(name="memberService")
	private MemberService memberService;
	
	@RequestMapping(value="/user/email/emailCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public void mailSending(@RequestParam Map<String, Object> param, HttpServletResponse res) {
		ModelAndView mav = new ModelAndView();
		
		String setFrom = "banggu1997@gmail.com";
		String key = new TempKey().getKey(8);
		String toMail = (String) param.get("email");
		
		logger.debug("param=" + param);
		
		String title = "아일락 메일 인증 서비스 입니다.";
		String content = new StringBuffer().append("임시비밀번호 : ").append(key).toString();
		
		try {
			res.setContentType("UTF-8");
			
			PrintWriter writer = res.getWriter();
			
			writer.print(key);
			
			MimeMessage message = mailSender.createMimeMessage();
			
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
			messageHelper.setFrom(setFrom, "아일락");
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			messageHelper.setText(content);
			
			mailSender.send(message);
			
			param.put("key", key);
			memberService.changePassword(param);
			
		} catch(Exception e) {
			logger.info("에러=" + e);
		}
		
	}
}
