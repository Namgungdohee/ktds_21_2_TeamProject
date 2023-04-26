package com.kpms.issu.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.kpms.issu.service.IssuService;
import com.kpms.issu.vo.IssuVO;

@Controller
public class IssuController {

	@Autowired
	private IssuService issuService;
	
	@GetMapping("/issu/list")
	public String viewIssuListPage(Model model, IssuVO issuVO) {
		List<IssuVO> issuList = issuService.readIssuList(issuVO);
		model.addAttribute("issuList",issuList);
		if(!issuList.isEmpty()) {
			model.addAttribute("lastPage",issuList.get(0).getLastPage());
		}
		model.addAttribute("pageNo",issuVO.getPageNo());
		model.addAttribute("pageCnt",issuVO.getPageCnt());
		model.addAttribute("viewCnt",issuVO.getViewCnt());
		model.addAttribute("empVO",issuVO);
		return "issu/list";
	}
	
	@GetMapping("/issu/create")
	public String viewIssuCreatePage() {
		return "issu/create";
	}
	@GetMapping("/issu/detail/{issuId}")
	public String viewIssuDetailPage(Model model, @PathVariable String issuId) {
		IssuVO issuVO = issuService.readOneIssu(issuId);
		model.addAttribute("issuVO",issuVO);
		return "issu/detail";
	}
}
