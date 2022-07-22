package com.one.service;

import java.util.List;

import com.one.domain.Criteria;
import com.one.domain.ReplyPageDTO;
import com.one.domain.ReplyVO;

public interface ReplyService {

	public int register(ReplyVO vo);

	public ReplyVO get(Long rno);// 번호하나 줄테니까 VO하나 줘 라는 말.

	public int modify(ReplyVO vo);

	public int remove(Long rno);

	public List<ReplyVO> getList(Criteria cri, Long bno); // 목록을 읽어오는건 rno아니고 bno 게시판 넘버를 가져와야한다!!

	public ReplyPageDTO getListPage(Criteria cri, Long bno);
}
