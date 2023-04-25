package com.kpms.dep.dao;

import java.util.List;

import com.kpms.dep.vo.DepVO;
import com.kpms.dep.vo.DeptSearchVO;

public interface DepDAO {
	
	public List<DepVO> readAllDepVO(DeptSearchVO deptSearchVO);
	
	public List<DepVO> readAllDepVONopagination(String depNm);
	
	public DepVO readOneDepVOByDepId(String depId);
	
	public int createOneDep(DepVO depVO);
	
	public int updateOneDepByDepId(DepVO depVO);
	
	public int deleteOneDepByDepId(String depId);
	
	public int deleteDepBySelectedDepId(List<String> depId);
	
	public List<DepVO> readAllDepToTmMbr(DepVO depVO);
	
}
