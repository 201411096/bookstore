package com.mycompany.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mycompany.domain.CustomerVO;

@Repository("tendencyDAO")
public class TendencyDAOImpl implements TendencyDAO{
	@Autowired
	private SqlSessionTemplate mybatis;
	
	@Override
	public int insertTendency(CustomerVO vo) {
		int result = mybatis.insert("TendencyDAO.insertTendency", vo);
		return result;
	}
	
}
