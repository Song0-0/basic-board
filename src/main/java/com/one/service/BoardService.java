package com.one.service;

import java.util.List;

import com.one.domain.BoardVO;
import com.one.domain.Criteria;

public interface BoardService {

	public Long register(BoardVO board); // insert하는 애

	public BoardVO get(Long bno); // 한 건 읽어오는애

	//public List<BoardVO> getList(); // 여러 건 읽어오는 애
	
	public List<BoardVO> getList(Criteria cri); // 여러 건 읽어오는 애

	public int modify(BoardVO board); // 뭐가 있어야지 수정하니까 매개변수를 BoardVO타입의 board를 준다.

	public boolean remove(Long bno);
	
	public int getTotalCount(Criteria cri);
}