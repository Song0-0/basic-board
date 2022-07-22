package com.one.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.one.domain.BoardVO;
import com.one.domain.Criteria;
import com.one.mapper.BoardMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {

	private final BoardMapper mapper; // 객체를 새로 new로 생성안하고, Bean중에 BoardMapper라는애 있어 스프링아? 그럼 주입이 되도록 설정해줘라고 하는거임.

	@Override
	public Long register(BoardVO board) {

		log.info("register-------" + board);
		mapper.insertSelectKey(board);

		return board.getBno();

	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get...........");
		return mapper.read(bno);
	}

//	@Override
//	public List<BoardVO> getList() {
//		log.info("getList..................");
//		return mapper.getList();
//	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("getList with criteria ==> "+cri);
		
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int modify(BoardVO board) { // update
		log.info("modify........." + board);

		return mapper.update(board); //1이면 true 아니면 false (int로 반환타입을 바꿔야함)
	}

	@Override
	public boolean remove(Long bno) { // delete
		log.info("remove...........");
		return mapper.delete(bno) == 1;
	}

	@Override
	public int getTotalCount(Criteria cri) {
		log.info("get total count........");
		return mapper.getTotalCount(cri);
	}


}
