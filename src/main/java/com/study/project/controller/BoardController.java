package com.study.project.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.study.project.VO.PageVO;
import com.study.project.service.BoardService;

@Controller
public class BoardController {

	@Resource(name = "service")
	private BoardService boardService; 
	
	//리스트 조회 및 검색,페이징
	@RequestMapping("list")
	public String list(@RequestParam Map<String,Object> map, Model model) {
		
		if(map.isEmpty()) {
			map.put("pageNo", 1);
			map.put("listSize", 20);
		}
		
		int count = boardService.count(map);
		int curPage = Integer.parseInt(map.get("pageNo").toString());
		PageVO pageVO = new PageVO(count, curPage);
		
		
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		list = boardService.list(map);
		
	    model.addAttribute("pageVO",pageVO);
		model.addAttribute("list", list);
		return "board/list";
	}
	
	//글쓰기 페이지 이동
	@RequestMapping(value = "reg", method = RequestMethod.GET)
	public String regGET() {
		
		return "board/reg";
	}
	
	//글 등록+파일 업로드
	private static final String filePath = "D:/pic/";  
    @RequestMapping(value = "insert", method = RequestMethod.POST)
    public String insert(@RequestParam Map<String,Object> map, 
    		MultipartHttpServletRequest mReq) throws IllegalStateException, IOException {
    	
    	//임시로 select된 seq를 가져와서 이하 작업 진행
    	int seq = boardService.listSeq();
    	
    	Iterator<String> itr = mReq.getFileNames();
    	while(itr.hasNext()) {
    		MultipartFile mFile = mReq.getFile(itr.next());
    		
    		if(mFile.getSize() > 0) {
    		String realName = mFile.getOriginalFilename();
    		String saveName = UUID.randomUUID() + "_" + realName;
    		
    		mFile.transferTo(new File(filePath + saveName));
    	
	    	//파일정보MAP
	    	Map<String, Object> fileMap = new HashMap<String, Object>();
	    	fileMap.put("filePath", filePath);
	    	fileMap.put("realFile", realName);
	    	fileMap.put("saveFile", saveName);
	    	fileMap.put("listSeq", seq);
	    	
	    	boardService.fileInsert(fileMap); 
    		}
	    }
    	
    	map.put("seq",seq);
    	int insert = boardService.insert(map);
    	if(insert==0) {
    		return "redirect:reg";
    	}else {
            return "redirect:list";
    	}
    }
    
    //상세보기
 	@RequestMapping("detail")
 	public String read(@RequestParam("seq") int seq, Model model) {
 		
 		Map<String,Object> detailMap = boardService.detail(seq);
 		model.addAttribute("detailMap",detailMap);
 				
 		return "board/reg";
 	}
 	
	//글 수정
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public String update(@RequestParam Map<String,Object> map) {
    	
    	int update = boardService.update(map);
    	if(update==0) {
    		System.out.println("실패");
    	}else {
    		System.out.println("성공");
    	}

        return "redirect:list";
    }
 	
    //글 삭제
	//체크박스 네임 같을 때=서브밋을 받을 떄 배열로 받을 수 있음 (for each로 마이바티스)
    @RequestMapping(value = "delete", method = RequestMethod.POST)
    public String delete(@RequestParam("delChk") List<Integer> seq) {
 
    	int delete = boardService.delete(seq);
      	if(delete==0) {
    		System.out.println("실패");
    	}else {
    		System.out.println("성공");
    	}
    	
    	return "redirect:list";
    }

	//비동기 검색
	@RequestMapping("searchList")
	public String searchList(@RequestParam Map<String,Object> searchMap, Model model) {
		int count = boardService.count(searchMap);
		int curPage = Integer.parseInt(searchMap.get("pageNo").toString());
		PageVO pageVO = new PageVO(count, curPage);
		
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		list = boardService.list(searchMap);
		
	    model.addAttribute("pageVO",pageVO);
		model.addAttribute("list", list);
		return "board/searchList";
	}
    
	
	
}




