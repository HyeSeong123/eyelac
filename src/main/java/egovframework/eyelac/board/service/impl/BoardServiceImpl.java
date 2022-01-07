package egovframework.eyelac.board.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.eyelac.board.service.BoardService;

@Service("boardService")
public class BoardServiceImpl implements BoardService{
	
	@Resource(name="boardMapper")
	private BoardMapper boardMapper;
	
	@Override
	public List<BoardVO> getBoards() throws Exception {
		return boardMapper.getBoards();
	}

	@Override
	public List<BoardVO> getBoardsByDepth(int depth) {
		return boardMapper.getBoardsByDepth(depth);
	}

	@Override
	public List<BoardVO> getBoardsChildrenCnt() {
		return boardMapper.getBoardsChildrenCnt();
	}

}
