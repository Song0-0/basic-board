package com.one.domain;

import java.util.Date;

import lombok.Data;

@Data //어노테이션 달면 롬복이 이걸 처리해줌 getter, setter, toString 메서드 생성
public class BoardVO {
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updatedate;
}