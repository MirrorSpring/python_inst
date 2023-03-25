package com.javalec.base.Controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.javalec.base.mapper.modelMapper;
import com.javalec.base.model.Join_PostUploadModel;
import com.javalec.base.model.Join_PostUploadUserWishModel;
import com.javalec.base.model.Join_UserReviewModel;
import com.javalec.base.model.PostModel;
import com.javalec.base.model.UserModel;

import jakarta.servlet.http.HttpServletRequest;

@RestController
public class controller {
	
	private modelMapper mapper;
	
	public controller(modelMapper mapper) {
		this.mapper = mapper;
	}
	
	// user insert
	@GetMapping("/user/insert/{userId}")
	public void insertUser(@PathVariable("userId")String userId, @RequestParam("userName")String userName, @RequestParam("userPw")String userPw, @RequestParam("userAddress")String userAddress) {
		mapper.insertUser(userId, userName, userPw, userAddress);
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

	// --- My Page ---

	// 찜 목록
	@GetMapping("/wishlistSelect")
	public List<Join_PostUploadUserWishModel> wishlistSelect(HttpServletRequest request) {
		String user = request.getParameter("userId");		
		return mapper.wishlistSelect(user);
	}

	// 판매 내역
	@GetMapping("/buylistSelect")
	public List<Join_PostUploadUserWishModel> buylistSelect(HttpServletRequest request) {
		String user = request.getParameter("userId");		
		return mapper.buylistSelect(user);
	}

	// 찜 목록 지우기
	@GetMapping("/deleteWish/{userId}/{poId}")
	public void deleteWish(@PathVariable("userId")String userId, @PathVariable("poId")int poId) {
		mapper.deleteWish(userId, poId);
	}
	// 회원 탈퇴
	@GetMapping("/deleteUser/{userId}")
	public void deleteUser(@PathVariable("userId") String userId) {
		mapper.deleteUser(userId);
	}

	// 찜 목록 삭제시 하트 수 -1 내리기
	@GetMapping("/wishdown/{poId}")
	public void wiishDownpoHeart(@PathVariable("poId") int poId) {
		mapper.wishDownpoHeart(poId);
	}

	// 회원 정보 가져오기
	@GetMapping("/userInfo")
	@org.springframework.lang.Nullable
	public List<UserInfoModel> userInfo(HttpServletRequest request) {
		String user = request.getParameter("userId");
		return mapper.userInfo(user);
	}

	// 회원 정보 수정하기
	@GetMapping("/updateUser/{userId}/{userPw}/{userName}/{userAddress}")
	public void updateUser(@PathVariable("userId") String userId, @PathVariable("userPw") String userPw, @PathVariable("userName") String userName, @PathVariable("userAddress") String userAddress) {
		mapper.updateUser(userId, userPw, userName, userAddress);
	}
	
}
