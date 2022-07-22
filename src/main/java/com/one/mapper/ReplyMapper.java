package com.one.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.one.domain.Criteria;
import com.one.domain.ReplyVO;

public interface ReplyMapper { // 인터페이스를 만드는 이유는 변경이 생길 때 이 클래스만 수정해도 다 적용되도록 하기 위해서!!
	public int insert(ReplyVO vo); //마이바티스가 insert를 받는다?!

	public ReplyVO read(Long bno);

	public int delete(Long rno); // delete에는 pk 꼭 넣어줘야함!

	public int update(ReplyVO reply); // 한무더기를 보내줘야지 거기서 수정이 되던가 하겠지?

	public List<ReplyVO> getListwithPaging(@Param("cri") Criteria cri, @Param("bno") Long bno);

	public int getCountByBno(Long bno); //게시글 번호에 있는 댓글을 읽어서 총 댓글이 몇개인지를 가져오는 추상메서드
}
