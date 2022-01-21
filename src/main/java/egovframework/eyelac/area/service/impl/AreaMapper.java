package egovframework.eyelac.area.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("areaMapper")
public interface AreaMapper {

	List<AreaVO> getSiGunGu(Map<String, Object> param);

	List<AreaVO> getDetailArea(Map<String, Object> param);
	
}
