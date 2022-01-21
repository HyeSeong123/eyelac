package egovframework.eyelac.area.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import egovframework.eyelac.area.service.AreaService;
import egovframework.eyelac.area.service.impl.AreaVO;

@Controller
public class AreaController {
	private static final Logger logger = LoggerFactory.getLogger(AreaController.class);
	
	@Resource(name="areaService")
	private AreaService areaService;
	
	@Autowired
	MappingJackson2JsonView jsonView;
	
	@RequestMapping(value="/user/area/getSiGunGu.do", method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView getArea(HttpServletRequest req, @RequestParam Map<String, Object> param) {
		
		ModelAndView mav = new ModelAndView();
		
		List<AreaVO> area = areaService.getSiGunGu(param);
		
		mav.setView(jsonView);
		
		mav.addObject("result", area);
		
		return mav;
	}
	
	@RequestMapping(value="/user/area/getDetailArea.do", method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView getDetailArea(HttpServletRequest req, @RequestParam Map<String, Object> param) {
		
		ModelAndView mav = new ModelAndView();
		
		List<AreaVO> detailArea = areaService.getDetailArea(param);
		
		mav.setView(jsonView);
		
		mav.addObject("result", detailArea);
		
		return mav;
	}
}
