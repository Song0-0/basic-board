package com.one.mapper;

import java.util.List;

import com.one.domain.BoardVO;
import com.one.domain.Criteria;

public interface BoardMapper {
	// 어노테이션을 이용한 방법이다. update같은건 약간 복잡하기도해. 그래서 얘를 이렇개 쓰기도 하지만, xml방식을 활용하기도한다.
	// 우리는 xml방식을 활용해볼거니까 지금 select 어노테이션은 주석처리한다!! src/main/resources - com - one - mapper 이렇게 각각
	// 폴더를 생성해주고, BoardMapper.xml에 다 넣을거야.
	//@Select("select * from t_board where bno > 0") // developersql에서 잘 나오는지 확인을 하고 작업을 하는게 좋음.그리고세미콜론빼고 여기에 붙여넣자
		public List<BoardVO> getList(); // BoardVO가 배열에 들어있네! DAO역할을 얘가 다 하는 것이야.
		
		public List<BoardVO> getListWithPaging(Criteria cri); //
		
		public void insert(BoardVO board);
		
		public void insertSelectKey(BoardVO board);
		
		public BoardVO read(Long bno);
		
		public int delete(Long bno);
		
		public int update(BoardVO board); //얘는 우리가 담아둬야하니까 delete와 달리 VO로 주는거야.

		public int getTotalCount(Criteria cri); //매개변수를 아무것도 안써도 되지만, 나중에 활용하려고 넣음.
}