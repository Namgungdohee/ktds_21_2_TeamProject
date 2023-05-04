package com.kpms.knw.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kpms.atchfl.vo.AtchFlVO;
import com.kpms.emp.vo.EmpVO;
import com.kpms.knw.service.KnwService;
import com.kpms.knw.vo.KnwSearchVO;
import com.kpms.knw.vo.KnwVO;

@Controller
public class KnwController {

	@Autowired
	private KnwService knwService;
	
	@Value("${upload.attchmnt.path:/kpms/files/attchmnt}")
	private String atchmntPath;
	
	@GetMapping("/knw/list/{commonMode}")
	public String viewKnwListPage(KnwSearchVO knwSearchVO, Model model, @PathVariable boolean commonMode, @SessionAttribute("__USER__") EmpVO empVO) {
		knwSearchVO.setCommonMode(commonMode);
		knwSearchVO.setEmpId(empVO.getEmpId());
		List<KnwVO> knwList = knwService.readAllKnw(knwSearchVO);
		model.addAttribute("knwList", knwList);
		model.addAttribute("knwSearchVO", knwSearchVO);
		
		if(!knwList.isEmpty()) {
			model.addAttribute("lastPage", knwList.get(0).getLastPage());
		}
		
		model.addAttribute("pageNo", knwSearchVO.getPageNo());
		model.addAttribute("viewCnt", knwSearchVO.getViewCnt());
		model.addAttribute("pageCnt", knwSearchVO.getPageCnt());
		
		return "knw/list";
	}
	
	@GetMapping("/knw/create")
	public String viewKnwCreatePage(@RequestParam(required=false) String prjId, Model model) {
		model.addAttribute("prjId", prjId);
		return "knw/create";
	}
	
	@GetMapping("/knw/detail/{knwId}")
	public String viewKnwDetailPage(@PathVariable String knwId, Model model, @SessionAttribute("__USER__") EmpVO empVO) {
		KnwVO knwVO = knwService.readOneKnwByKnwId(knwId);
		List<AtchFlVO> atchFlList = knwVO.getAtchFlList();
		
		model.addAttribute("knwVO", knwVO);
		model.addAttribute("prjVO", knwVO.getPrjVO());
		model.addAttribute("atchFlList", atchFlList);
		model.addAttribute("atchmntPath", atchmntPath);
		
		return "knw/detail";
	}
	
	@GetMapping("/knw/update/{knwId}")
	public String viewKnwUpdatePage(@PathVariable String knwId, Model model, @SessionAttribute("__USER__") EmpVO empVO) {
		KnwVO knwVO = knwService.readOneKnwByKnwId(knwId);
		List<AtchFlVO> atchFlList = knwVO.getAtchFlList();
		
		model.addAttribute("knwVO", knwVO);
		model.addAttribute("prjVO", knwVO.getPrjVO());
		model.addAttribute("atchFlList", atchFlList);
		model.addAttribute("atchmntPath", atchmntPath);
		
		return "knw/update";
	}
	
	@GetMapping(value = "/knw/detail/getAttachList", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<AtchFlVO>> getAttachList(String frgnId) {
		return new ResponseEntity<>(knwService.readOneKnwByKnwId(frgnId).getAtchFlList(), HttpStatus.OK);
	}
	

}
