package com.one.controller;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.one.domain.Criteria;
import com.one.domain.ReplyVO;
import com.one.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml") // 괄호안에 경로 넣기!!!!!
@Log4j
public class ReplyMapperTests {

	private Long[] bnoArr = { 557039L, 557040L, 557041L, 557042L, 557043L }; // 아래 testCreate()메서드를 위해 만듬. 그 메서드에 5개니까
																				// 여기도 5개 넣기!!

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;

	@Test
	public void testMapper() {
		log.info(mapper);
	}

	@Test
	public void testCreate() {
		IntStream.rangeClosed(1, 10).forEach(i -> { // 1~5 6~10
			ReplyVO vo = new ReplyVO();

			vo.setBno(bnoArr[i % 5]); // 5로나눈 나머지
			vo.setReply("댓글 테스트입니다." + i);
			vo.setReplyer("replyer" + i);

			mapper.insert(vo); // insert문을 10번 날린 것이다.
		});
	}

	@Test
	public void testRead() {
		Long rno = 9L;
		ReplyVO vo = mapper.read(rno);
		log.info(vo);
	}

	@Test
	public void testDelete() {
		Long rno = 5L;
		int result = mapper.delete(rno);
		log.info("삭제 결과 : " + result);
	}

	@Test
	public void testUpdate() {
		Long rno = 4L;
		ReplyVO vo = mapper.read(rno);
		log.info("업데이트 전 replyVO : " + vo);
		vo.setReply("Update reply test...........");
		int result = mapper.update(vo);
		log.info("업데이트 결과 : " + result);
		vo = mapper.read(rno);
		log.info("업데이트 후 바뀐 replyVO : " + vo);
	}

	@Test
	public void testList() {
		Criteria cri = new Criteria();
		List<ReplyVO> replies = mapper.getListwithPaging(cri, bnoArr[3]); // 예시로 난 3번쨰 인덱스를 줄거야

		replies.forEach(reply -> log.info(reply));
	}

	@Test
	public void testList2() {
		Criteria cri = new Criteria();
		List<ReplyVO> replies = mapper.getListwithPaging(cri, 557106L);
		replies.forEach(reply -> log.info(reply));
	}
}