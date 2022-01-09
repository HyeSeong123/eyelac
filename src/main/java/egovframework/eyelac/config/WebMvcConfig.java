package egovframework.eyelac.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import egovframework.eyelac.member.web.MemberController;

@Configuration
@EnableWebMvc
public class WebMvcConfig extends WebMvcConfigurerAdapter{
	private static final Logger logger = LoggerFactory.getLogger(WebMvcConfig.class);
	@Override
	public void addCorsMappings(CorsRegistry registry) {
		registry.addMapping("/**");
	}
	
	@Autowired
	@Qualifier("beforeActionIntercepter")
	HandlerInterceptor beforeActionIntercepter;
	
	@Autowired
	@Qualifier("needToLoginIntercepter")
	HandlerInterceptor needToLoginIntercepter;
	
	@Autowired
	@Qualifier("needToLogoutIntercepter")
	HandlerInterceptor needToLogoutIntercepter;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		logger.debug("registry= " + registry);
		registry.addInterceptor(beforeActionIntercepter).addPathPatterns("/**").excludePathPatterns("/resource/**");
		
		registry.addInterceptor(needToLoginIntercepter)
		.addPathPatterns("/**")
		.excludePathPatterns("/")
		.excludePathPatterns("/user/index.do")
		.excludePathPatterns("/user/member/join_policy.do")
		.excludePathPatterns("/user/member/join_policyCheck.do")
		.excludePathPatterns("/user/member/join.do")
		.excludePathPatterns("/user/member/memberIdDupliCheck.do")
		.excludePathPatterns("/user/member/doJoin.do")
		.excludePathPatterns("/user/member/doLogin.do")
		.excludePathPatterns("/user/member/login.do")
		.excludePathPatterns("/user/login/accessDenine.do")
		.excludePathPatterns("/user/member/memberFindId.do")
		.excludePathPatterns("/user/member/memberFindPw.do")
		.excludePathPatterns("/user/member/doFindId.do")
		.excludePathPatterns("/user/member/doFindPw.do")
		.excludePathPatterns("/user/member/resultFindId.do")
		.excludePathPatterns("/user/member/myInfor.do");
		
		registry.addInterceptor(needToLogoutIntercepter)
		.addPathPatterns("/user/member/login.do")
		.addPathPatterns("/user/member/doLogin.do")
		.addPathPatterns("/user/member/join_policy.do")
		.addPathPatterns("/user/member/join.do")
		.addPathPatterns("/user/member/doJoin.do")
		.addPathPatterns("/user/member/find.do");
	}
}
