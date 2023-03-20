package com.javalec.base.Controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.javalec.base.mapper.modelMapper;
import com.javalec.base.model.Join_PostUploadModel;
import com.javalec.base.model.Join_UserReviewModel;
import com.javalec.base.model.PostModel;
import com.javalec.base.model.UserModel;

@RestController
public class controller {
	
	private modelMapper mapper;
	
	public controller(modelMapper mapper) {
		this.mapper = mapper;
	}
	@GetMapping("/post/all")
	public List<PostModel> getpostModelInformation() {
		return mapper.getpostModelInformation();
	}
	
	@GetMapping("/post/alljoin_upload")
	public List<Join_PostUploadModel> getboardModel() {
		return mapper.getboardModel();
	}
	
	@GetMapping("/user/all")
	public UserModel getuserModelInformation() {
		return mapper.getuserModelInformation();
	}
	
	@GetMapping("/review/write/{to_userId}/{from_userId1}")
	public void insertReview(@PathVariable("to_userId")String to_userId, @PathVariable("from_userId1")String from_userId1, @RequestParam("reText")String reText, @RequestParam("reStarRating")int reStarRating) {
		mapper.insertReview(to_userId, from_userId1, reText, reStarRating);
	}
	
	@GetMapping("/review/all/{to_userId}")
	public List<Join_UserReviewModel> getReviewModelInformation(@PathVariable("to_userId")String to_userId) {
		return mapper.getJoinUserReviewModel(to_userId);
	}
	
	//row count
	@GetMapping("/review/count/{to_userId}")
	public int getReviewCount(@PathVariable("to_userId")String to_userId) {
		return mapper.getReviewCount(to_userId);
	}
	
	//reliability select
	@GetMapping("/user/reliability/{to_userId}")
	public int getUserReliability(@PathVariable("to_userId")String to_userId) {
		return mapper.getUserReliability(to_userId);
	}
	
	//update reliability 
	@GetMapping("/user/reliability/update/{to_userId}")
	public void updateReliability(@PathVariable("to_userId")String to_userId, @RequestParam("userReliability")int userReliability) {
		mapper.updateReliability(to_userId, userReliability);
	}

}
