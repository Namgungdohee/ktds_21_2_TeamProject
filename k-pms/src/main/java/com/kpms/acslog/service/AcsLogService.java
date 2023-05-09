package com.kpms.acslog.service;

import java.util.List;

import com.kpms.acslog.vo.AcsLogExcelVO;
import com.kpms.acslog.vo.AcsLogVO;

public interface AcsLogService {

	public boolean createAcsLog(AcsLogVO acsLog);

	public List<AcsLogVO> readAllAcsLog(AcsLogVO acsLog);

	public List<AcsLogExcelVO> readAllAcsLogToExcel(AcsLogVO acsLogVO);
}
