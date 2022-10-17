package com.study.project.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.study.project.dao.BoardDao;
import com.study.project.service.BoardService;

@Service("service")
public class BoardServiceImpl implements BoardService{

	@Resource (name = "dao")
	private BoardDao boardDao;
	
	@Override
	public List<Map<String, Object>> list(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return boardDao.list(map);
	}

	@Override
	public int insert(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return boardDao.insert(map);
	}

	@Override
	public Map<String, Object> detail(int seq) {
		// TODO Auto-generated method stub
		return boardDao.detail(seq);
	}

	@Override
	public int update(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return boardDao.update(map);
	}

	@Override
	public int delete(List<Integer> seq) {
		// TODO Auto-generated method stub
		return boardDao.delete(seq);
	}
	
	@Override
	public int count(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return boardDao.count(map);
	}

	@Override
	public int listSeq() {
		// TODO Auto-generated method stub
		return boardDao.listSeq();
	}

	@Override
	public int fileInsert(Map<String, Object> fileMap) {
		// TODO Auto-generated method stub
		return boardDao.fileInsert(fileMap);
	}

	@Override
	public List<Map<String, Object>> fileDetail(int seq) {
		// TODO Auto-generated method stub
		return boardDao.fileDetail(seq);
	}


}
