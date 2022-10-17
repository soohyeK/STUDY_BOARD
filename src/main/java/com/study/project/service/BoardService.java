package com.study.project.service;

import java.util.List;
import java.util.Map;

public interface BoardService {

	List<Map<String, Object>> list(Map<String, Object> map);

	int insert(Map<String, Object> map);

	Map<String, Object> detail(int seq);

	int update(Map<String, Object> map);

	int delete(List<Integer> seq);

	int count(Map<String, Object> map);

	int listSeq();

	int fileInsert(Map<String, Object> fileMap);

	List<Map<String, Object>> fileDetail(int seq);

}
