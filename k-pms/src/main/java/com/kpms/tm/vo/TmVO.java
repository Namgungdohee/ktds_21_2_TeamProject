package com.kpms.tm.vo;

import com.kpms.common.vo.AbstractPagingVO;
import com.kpms.dep.vo.DepVO;

/**
 * TM
 */
public class TmVO extends AbstractPagingVO {

	private String tmId;
	private String tmNm;
	private String tmCrtDt;
	private String depId;
	private String tmHdId;
	
	private DepVO depIdDepVO;
	
	public String getTmId() {
		return tmId;
	}
	public void setTmId(String tmId) {
		this.tmId = tmId;
	}
	public String getTmNm() {
		return tmNm;
	}
	public void setTmNm(String tmNm) {
		this.tmNm = tmNm;
	}
	public String getTmCrtDt() {
		return tmCrtDt;
	}
	public void setTmCrtDt(String tmCrtDt) {
		this.tmCrtDt = tmCrtDt;
	}
	public String getDepId() {
		return depId;
	}
	public void setDepId(String depId) {
		this.depId = depId;
	}
	public String getTmHdId() {
		return tmHdId;
	}
	public void setTmHdId(String tmHdId) {
		this.tmHdId = tmHdId;
	}
	public DepVO getDepIdDepVO() {
		return depIdDepVO;
	}
	public void setDepIdDepVO(DepVO depIdDepVO) {
		this.depIdDepVO = depIdDepVO;
	}

}