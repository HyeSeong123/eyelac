package egovframework.eyelac.board.service;

import java.util.List;
import java.util.Map;

import egovframework.eyelac.board.service.impl.BoardVO;

public interface BoardService {
	List<BoardVO> getBoards() throws Exception;

	List<BoardVO> getBoardsByDepth(int depth);

	List<BoardVO> getBoardsChildrenCnt();
}
