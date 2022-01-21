package egovframework.eyelac.area.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.eyelac.area.service.AreaService;

@Service("areaService")
public class AreaServiceImpl implements AreaService {

	@Resource(name="areaMapper")
	private AreaMapper areaMapper;
	
	@Override
	public List<AreaVO> getSiGunGu(Map<String, Object> param) {
		return areaMapper.getSiGunGu(param);
	}

	@Override
	public List<AreaVO> getDetailArea(Map<String, Object> param) {
		return areaMapper.getDetailArea(param);
	}

}
