package com.javalec.base.Controller;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.javalec.base.mapper.modelMapper;
import com.javalec.base.model.Join_PostUploadModel;
import com.javalec.base.model.PostModel;
import com.javalec.base.model.UserModel;
@RestController
public class boardController {
	
	private modelMapper mapper;
	
	public boardController(modelMapper mapper) {
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
	
	@GetMapping("/post/views/{poId}")
	public int updatePostViews(@PathVariable("poId")String Id) {
		return mapper.updatePostViews(Id);
	}
	// 게시글삭제 
	@GetMapping("/post/deldate/{P_poId}")
	public int updatePostDelDate(@PathVariable("P_poId")String Id) {
		return mapper.updatePostDelDate(Id);
	}
	// 게시글수정
	@GetMapping("/post/modify")
		public int modifyPost(@RequestParam("poTitle") String poTitle,@RequestParam("poContent") String poContent,@RequestParam("poPrice") String poPrice,@RequestParam("poImage01") String poImage01,@RequestParam("poId") int poId) {
		System.out.println(poImage01);	
		return mapper.modifyPost(poTitle, poContent, poPrice,poImage01,poId);
	}
	
	// 게시글 작성
	@GetMapping("/post/insert")
	public int insertBoard(@RequestParam("poHeart") String poHeart, @RequestParam("poTitle") String poTitle,@RequestParam("poContent") String poContent,@RequestParam("poPrice") String poPrice,@RequestParam("poImage01") String poImage01,@RequestParam("poViews") String poViews,@RequestParam("poState") String poState, @RequestParam("poUser")String poUser) {
		return mapper.insertBoard(poHeart,poTitle,poContent,poPrice,poImage01,poViews,poState,poUser);
	}
	
	@GetMapping("/post/select/postId")
	public int getpostId(@RequestParam("poHeart") String poHeart, @RequestParam("poTitle") String poTitle,@RequestParam("poContent") String poContent,@RequestParam("poPrice") String poPrice,@RequestParam("poImage01") String poImage01,@RequestParam("poViews") String poViews,@RequestParam("poState") String poState, @RequestParam("poUser")String poUser) {
		return mapper.getpostId(poHeart,poTitle,poContent,poPrice,poImage01,poViews,poState,poUser);
	}
	// 게시글 작성시간
	@GetMapping("/post/views/{P_poId}/{U_userId}")
	public int insertUpload(@PathVariable("P_poId")String P_poId,@PathVariable("U_userId") String U_userId) {
		return mapper.insertUpload(P_poId, U_userId);
	}
	// 게시글 수정시간
	@GetMapping("/post/modifyboard/{P_poId}/{U_userId}")
	public int modifyUpload(@PathVariable("P_poId")String P_poId,@PathVariable("U_userId") String U_userId) {
		return mapper.modifyUpload(P_poId, U_userId);
	}
	// 게시물 제목 검색 
	@GetMapping("/post/searchBoard")
	public List<Join_PostUploadModel> searchBoard(@RequestParam("Search") String Search) {
		return mapper.searchBoard(Search);
	}
	
	// 좋아요 +1 올리기 
	@GetMapping("/post/heartPlus")
	public int updatePoHeart(@RequestParam("poId") String Id) {
		return mapper.updatePoHeart(Id);
	}
	
	// 좋아요 -1 내리기 
	@GetMapping("/post/heartDiv")
	public int downPoHeart(@RequestParam("poId") String Id) {
		return mapper.downPoHeart(Id);
	}
	
	// 좋아요 명단 추가 
	@GetMapping("/post/WishInsert")
	public int insertWish(@RequestParam("U_userId") String U_userId,@RequestParam("P_poId") String P_poId) {
		return mapper.insertWish(U_userId,P_poId);
	}
	
	// 즐겨찾기 등록한 게시물인지 체크 
	@GetMapping("/post/selectWishlist")
	public int selectWishlist(@RequestParam("poId") String Id) {
		return mapper.selectWishlist(Id);
	}
	
	// 즐겨찾기 등록한 게시물인지 체크 (게시글 목록페이지에서) 
	@GetMapping("/post/checkWishlist")
	public int checkWishlist(@RequestParam("U_userId") String U_userId) {
		return mapper.checkWishlist(U_userId);
	}
	//SELECT Count(U_userId) From deeplearning.post as p, deeplearning.wish as w WHERE p.poId = w.P_poId and U_userId = "korea";


//	searchBoard(@Param("search") String Search);
}
