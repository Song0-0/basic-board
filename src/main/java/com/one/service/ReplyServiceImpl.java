package com.one.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.one.domain.Criteria;
import com.one.domain.ReplyPageDTO;
import com.one.domain.ReplyVO;
import com.one.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;

	@Override
	public int register(ReplyVO vo) {
		log.info("댓글 등록 작업-->" + vo);
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		// 댓글 한건 읽어오니까 rno가져옴,
		log.info("댓글 상세 조회 --> " + rno);
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		log.info("댓글 수정하기--> " + vo);
		return mapper.update(vo);
	}

	@Override
	public int remove(Long rno) {
		log.info("댓글 삭제 작업 -->" + rno);
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		log.info("댓글 목록 가져오기--->" + cri + ", " + bno);
		return mapper.getListwithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		return new ReplyPageDTO(mapper.getCountByBno(bno), mapper.getListwithPaging(cri, bno));
	}

}
