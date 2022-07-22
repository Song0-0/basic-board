package com.one.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data //롬복에게 시키기 (getter setter toString 들 다 만들어줘라~)
@AllArgsConstructor //모든 인스턴스 변수를 포함하는 생성자를 자동완성하는 어노테이션
@NoArgsConstructor //어떠한 변수도 사용하지 않는 기본 생성자를 자동완성하는 어노테이션
public class SampleVO {
	private Integer Mno;
	private String firstName;
	private String lastName;	
}