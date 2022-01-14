package egovframework.eyelac.email.web;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sun.mail.util.logging.MailHandler;

import egovframework.eyelac.email.service.MailService;

@Controller
public class EmailController {
	private static final Logger logger = LoggerFactory.getLogger(EmailController.class);
	@Autowired
	private JavaMailSenderImpl mailHandler;
	@Autowired
	private MailService mss;
	
	@RequestMapping(value="/user/email/emailCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public void mailSending(@RequestParam String email, HttpServletResponse res) {
		
	}
}
