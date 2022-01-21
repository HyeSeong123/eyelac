package egovframework.eyelac.area.service;

import java.util.List;
import java.util.Map;

import egovframework.eyelac.area.service.impl.AreaVO;

public interface AreaService {

	List<AreaVO> getSiGunGu(Map<String, Object> param);

	List<AreaVO> getDetailArea(Map<String, Object> param);

}
