package egovframework.eyelac.board.service.impl;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("boardMapper")
public interface BoardMapper {

	List<BoardVO> getBoards();

	List<BoardVO> getBoardsByDepth(int depth);

	List<BoardVO> getBoardsChildrenCnt();
	
}
