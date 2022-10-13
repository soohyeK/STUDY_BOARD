package com.study.project.dao.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.study.project.dao.BoardDao;

@Repository("dao")
public class BoardDaoImpl implements BoardDao{

	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	@Override
	public List<Map<String, Object>> list(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.list", map);
	}


	@Override
	public int insert(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.insert("mapper.insert", map);
	}


	@Override
	public Map<String, Object> detail(int seq) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.detail", seq);
	}


	@Override
	public int update(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.update("mapper.update", map);
	}


	@Override
	public int delete(List<Integer> seq) {
		// TODO Auto-generated method stub
		return sqlSession.delete("mapper.delete", seq);
	}


	@Override
	public int count(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.count", map);
	}


	@Override
	public int listSeq() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.listSeq");
	}

	@Override
	public int fileInsert(Map<String, Object> fileMap) {
		// TODO Auto-generated method stub
		return sqlSession.insert("mapper.fileInsert", fileMap);
	}


}
