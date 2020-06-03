package com.mycompany.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.domain.CustomerVO;
import com.mycompany.domain.ReviewVO;
import com.mycompany.service.ReviewServiceImpl;

@Controller
public class ReviewController {

	
	@Autowired
	ReviewServiceImpl reviewService;
	

	//리뷰 입력 (***리뷰조건 필요)
	@RequestMapping("/productReview.do")
	public ModelAndView reviewInsert(ReviewVO vo, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		CustomerVO customer = (CustomerVO)session.getAttribute("customer");
		vo.setCustomerId(customer.getCustomerId());
		int result = reviewService.insertReview(vo);

		if(result==0) {
			mv.setViewName("/login");
		}
		ReviewVO vo1 = new ReviewVO();
		int result2=vo.getBookId();
		System.out.println(result2);
		vo1.setBookId(result2);
		mv.setViewName("/productView");
		List<ReviewVO> reviewList= (List<ReviewVO>) reviewService.selectReview(vo1);
		mv.addObject("review", reviewList);
		return mv;
	}
	

	
	
}
