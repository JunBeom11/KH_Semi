package com.mvc.status.model.vo;

import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Status {
	private int resultCode;		/* 결과코드 */
	private String resultMsg;	/* 결과메세지 */
	private String stateDt;		/* 기준일 */
	private String stateTime;	/* 기준시간 */
	private int seq;			/* 게시글번호(감염현황 고유값) */
	private String createDt;	/* 등록일시분초 */
	private String updateDt;	/* 수정일시분초 */	
	private int decideCnt;		/* 확진자 수 */	
	private int careCnt;		/* 치료중 환자 수 */
	private int deathCnt;		/* 사망자 수 */
	private int clearCnt;		/* 격리해제 수 */
	private float accDefRate;	/* 누적 확진률 */		
	private int accExamCnt;		/* 누적 검사수 */
	private int accExamCompCnt;	/* 누적 검사 완료수 */
	private int examCnt;		/* 검사진행 수 */
	private int resultNegCnt;	/* 결과 음성 수 */
	
	public Status(int resultCode, String resultMsg) {
		this.resultCode = resultCode;
		this.resultMsg = resultMsg;
	}
}
