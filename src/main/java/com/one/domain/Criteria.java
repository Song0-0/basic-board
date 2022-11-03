package com.one.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class Criteria { //PageVo역할

	private int pageNum;
	private int amount;

	private String type; // T title, C content, W write, TC title contemt , TCW title content writer, CW
							// content writer 검색유형들
	private String keyword;

	public Criteria() {
		this(1, 10); // 기본적으로 1페이지에 10개씩 보여주게 하겠다.는 말.
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}

	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}

	public String getListLink() { // 그냥써도되고 amount처럼 get으로 받아 메서드로 쓸 수도 있다.
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("").queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount()).queryParam("type", this.type)
				.queryParam("keyword", this.keyword);

		return builder.toUriString();
	}
}