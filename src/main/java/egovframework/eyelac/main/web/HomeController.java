package egovframework.eyelac.main.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
	
	@RequestMapping("/user/index.do")
	public ModelAndView ShowIndex(ModelAndView mav) {
		
		mav.setViewName("/user/index.user");
		
		return mav;
	}
}
