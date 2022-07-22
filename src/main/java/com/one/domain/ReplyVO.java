package com.one.domain;

import java.util.Date;

import lombok.Data;

@Data //롬복이에게 시킴~
public class ReplyVO {
	private Long rno;
	private Long bno;

	private String reply;
	private String replyer;
	private Date replydate;
	private Date updatedate;
}
