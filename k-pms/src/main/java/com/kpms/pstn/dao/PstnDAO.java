package com.kpms.pstn.dao;

import java.util.List;

import com.kpms.pstn.vo.PstnVO;

public interface PstnDAO {

	public int createNewPstn(PstnVO pstnVO);
	public int readPstnByPstnId(String pstnId);
	public List<PstnVO> readAllPstn(PstnVO pstnVO);
	public int updateNewPstn(PstnVO pstnVO);
	public int deletePstnByPstnId(String pstnId);
}