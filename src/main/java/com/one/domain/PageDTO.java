package com.one.domain;

import lombok.Data;

@Data
public class PageDTO { //페이지네이션에 표현할 것들은 pageDTO가 담고 있다
	
	//필드선언
	private int startPage;
	private int endPage;
	private boolean prev, next;
	private int total;
	private Criteria cri; // pageNum이랑 amount 들고 있음.

	//생성자선언
	// 두개에대한 생성자 생성 (source들어가서 가져옴)
	public PageDTO(int total, Criteria cri) {
		this.total = total;
		this.cri = cri;

		this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0) * 10);
		// System.out.println(endPage); endPage 콘솔창에 확인하려면 이렇게 하는거아닌가!!

		this.startPage = this.endPage - 9; // 한번 볼때 1~10까지 표시하겠단 말.
		int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount())); // 곱하기1하는건 실수로 바꾸기 위해. 그리고나서 소수점을 올림할라고.
																			// total부터 getAmount까지 괄호로 한번더 묶어줘야한다.
		// realEnd 계산 방법
		// total 게시글 151건
		// 페이지넘버는 5페이지
		// 한페이지당 10개씩 보여줌
		// 151.0 /10 = 15.1이고 그걸 올려 16
		if (realEnd < this.endPage) {
			this.endPage = realEnd;
		}

		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;

		// 이외 나머지는 롬복이 처리해줌,,,
	}
}