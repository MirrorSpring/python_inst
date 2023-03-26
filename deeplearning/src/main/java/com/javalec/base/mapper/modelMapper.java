package com.javalec.base.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.javalec.base.model.Join_PostUploadModel;
import com.javalec.base.model.Join_PostUploadUserWishModel;
import com.javalec.base.model.Join_UserReviewModel;
import com.javalec.base.model.PostModel;
import com.javalec.base.model.UserInfoModel;
import com.javalec.base.model.UserModel;

@Mapper
public interface modelMapper {
	
	// SQL문 작성하고 =#{컬럼}
	// EX ) INSERT INTO user(userName) VALUES (#{userName})
	// Test
	// Test
	
	// insert user
	@Insert("insert into deeplearning.user(userId, userName, userPw, userAddress, userInDate, userReliability) values (#{userId}, #{userName}, #{userPw}, #{userAddress}, now(), 50)")
	int insertUser(@Param("userId")String userId, @Param("userName")String userName, @Param("userPw")String userPw, @Param("userAddress")String userAddress);
	
	@Select("SELECT * FROM user")
	UserModel getuserModelInformation();
	
	@Select("SELECT poId,poHeart,poTitle,poContent,poPrice,poImage01,poImage02,poInstrument,poViews,poState FROM deeplearning.post")
	List<PostModel> getpostModelInformation();
	
	@Select("SELECT poId,poHeart,poTitle,poContent,poPrice,poImage01,poInstrument,poInstrument,poViews,poState,poUser,U_userId,userAddress,userReliability, poUpDate, DATE_FORMAT(poUpDate, '%H:%i:%s') AS timeonly FROM deeplearning.post as p , deeplearning.upload as u, deeplearning.user as us where p.poId = u.P_poId and u.U_userId = us.userId and poDelDate is null order by poUpDate desc")
	List<Join_PostUploadModel> getboardModel();
	
	@Select("select * from deeplearning.post where poId = #{poId}")
	List<PostModel> getPostOne(@Param("poId")int poId);
	
	@Insert("INSERT INTO deeplearning.review (reText, reInDate, reStarRating, to_userId, from_userId1) VALUES (#{reText}, now(), #{reStarRating}, #{to_userId}, #{from_userId1})")
	int insertReview(@Param("to_userId")String to_userId, @Param("from_userId1")String from_userId1, @Param("reText")String reText, @Param("reStarRating")int reStarRating);
	
	@Select("SELECT reId, reText,reStarRating, to_userId, from_userId1, userName, userPw, userAddress, userReliability, reInDate\n"
			+ "FROM deeplearning.review rv, deeplearning.user u \n"
			+ "WHERE rv.from_userId1 = u.userId and rv.to_userId = #{to_userId} ORDER BY reInDate desc;")
	List<Join_UserReviewModel> getJoinUserReviewModel(@Param("to_userId")String to_userId);
	
	// reliability update를 위해 row수 select
	@Select("select count(*) from deeplearning.review where to_userId = #{to_userId}")
	int getReviewCount(@Param("to_userId")String to_userId);
	
	// reliablity select
	@Select("select userReliability from deeplearning.user where userId = #{to_userId}")
	int getUserReliability(@Param("to_userId")String to_userId);
	
	//update reliability
	@Update("update deeplearning.user set userReliability = #{userReliability} where userId = #{to_userId}")
	void updateReliability(@Param("to_userId")String to_userId, @Param("userReliability")int userReliability);

	
	// --- board //
	
	@Update("UPDATE upload set poDelDate = now() WHERE P_poId = #{P_poId}")
	int updatePostDelDate(@Param("P_poId") String Id);
	
	@Update("UPDATE post set poViews = poViews+1 WHERE poId = #{poId}")
	int updatePostViews(@Param("poId") String Id);
	// 게시글 수정
	@Update("UPDATE post set poTitle = #{poTitle},poContent = #{poContent},poPrice = #{poPrice}, poImage01 = #{poImage01}, poInstrument = #{poInstrument} WHERE poId = #{poId}")
	int modifyPost(@Param("poTitle") String poTitle,@Param("poContent") String poContent,@Param("poPrice") String poPrice,@Param("poImage01") String poImage01,@Param("poInstrument") String poInstrument,@Param("poId") int poId);
	
	// 게시글 작성
	@Insert("INSERT INTO post(poHeart,poTitle,poContent,poPrice,poImage01,poInstrument,poViews,poState,poUser) VALUES(#{poHeart},#{poTitle},#{poContent},#{poPrice},#{poImage01},#{poInstrument},#{poViews},#{poState},#{poUser})")
	int insertBoard(@Param("poHeart") String poHeart, @Param("poTitle") String poTitle, @Param("poContent") String poContent, @Param("poPrice") String poPrice, @Param("poImage01") String poImage01,@Param("poInstrument") String poInstrument, @Param("poViews") String poViews, @Param("poState") String poState, @Param("poUser") String poUser );
	
	@Select("SELECT poId from post where poHeart=#{poHeart} and poTitle=#{poTitle} and poContent = #{poContent} and poPrice= #{poPrice} and poImage01= #{poImage01} and poInstrument = #{poInstrument} and poViews= #{poViews} and poState= #{poState} and poUser=#{poUser}")
	int getpostId(@Param("poHeart") String poHeart, @Param("poTitle") String poTitle, @Param("poContent") String poContent, @Param("poPrice") String poPrice, @Param("poImage01") String poImage01,@Param("poInstrument") String poInstrument ,@Param("poViews") String poViews, @Param("poState") String poState, @Param("poUser") String poUser);
	// 작성일자 등록
	@Insert("INSERT INTO upload(P_poId,U_userId,poUpDate) VALUES(#{P_poId},#{U_userId},now())")
	int insertUpload(@Param("P_poId") String P_poId, @Param("U_userId") String U_userId);
	
	@Update("UPDATE upload set poMoDate = now() WHERE P_poId = #{P_poId} and U_userId = #{U_userId}")
	int modifyUpload(@Param("P_poId") String P_poId, @Param("U_userId") String U_userId);

	@Select("SELECT poId,poHeart,poTitle,poContent,poPrice,poImage01,poImage02,poInstrument,poViews,poState,poUser,U_userId,userAddress,userReliability, poUpDate, DATE_FORMAT(poUpDate, '%H:%i:%s') AS timeonly FROM post as p , upload as u, user as us where p.poId = u.P_poId and u.U_userId = us.userId and poDelDate is null and poTitle REGEXP #{Search} order by poUpDate desc")
	List<Join_PostUploadModel> searchBoard(@Param("Search") String Search);

	@Update("UPDATE post set poHeart = poHeart+1 WHERE poId = #{poId}")
	int updatePoHeart(@Param("poId") String Id);
	
	@Update("UPDATE post set poHeart = poHeart-1 WHERE poId = #{poId}")
	int downPoHeart(@Param("poId") String Id);
	
	@Insert("INSERT INTO wish(U_userId,P_poId,WishDate) VALUES(#{U_userId},#{P_poId},now())")
	int insertWish(@Param("U_userId") String U_userId, @Param("P_poId") String P_poId);
	
	@Select("SELECT Count(poId) From deeplearning.post as p, deeplearning.wish as w WHERE p.poId = w.P_poId and poId = #{poId};")
	int selectWishlist(@Param("poId")String poId);
	
	@Select("SELECT Count(U_userId) From deeplearning.post as p, deeplearning.wish as w WHERE p.poId = w.P_poId and U_userId = #{U_userId};")
	int checkWishlist(@Param("U_userId")String U_userId);
	
	@Update("Update post set poState = poState +1 where poId = #{poId}")
	int postateUpdate(@Param("poId") String Id);
	
	
	// --- My Page ---

	// 찜 목록
	@Select("select poId, poHeart, poTitle, poPrice, poImage01, poState from deeplearning.post p, deeplearning.user u, deeplearning.wish w, deeplearning.upload up\n"
			+ "where w.P_poId = p.poId and w.U_userId = u.userId and up.P_poId = p.poId and up.U_userId = u.userId\n"
			+ "and w.U_userId = #{user} and w.WishDate is not null and up.poDelDate is null;")
	List<Join_PostUploadUserWishModel> wishlistSelect(String user);

	// 판매 내역
	@Select("select poHeart, poTitle, poPrice, poImage01 from deeplearning.post p, deeplearning.upload up, deeplearning.user u, deeplearning.buy b\n"
			+ "where b.P_poId = p.poId and b.U_userId = u.userId and b.U_userId = up.U_userId and b.P_poId = up.P_poId\n"
			+ "and b.U_userId = #{user} and b.buydate is not null and up.poDelDate is null;")
	List<Join_PostUploadUserWishModel> buylistSelect(String user);

	// 찜 목록 지우기
	@Delete("delete from wish where U_userId = #{userId} and P_poId = #{poId};")
	void deleteWish(@Param("userId") String userId, @Param("poId") int poId);

	// 회원 탈퇴
	@Update("UPDATE user set userDelDate = now() WHERE userId = #{userId};")
	void deleteUser(@Param("userId") String userId);

	// 찜 목록 삭제 시 하트 수 -1
	@Update("UPDATE post SET poHeart = poHeart-1 WHERE poId = #{poId}")
	void wishDownpoHeart(@Param("poId") int poId);

	// 회원 정보 가져오기
	@Select("SELECT userId, userName, userPw, userAddress FROM user where userId = #{user}")
	@org.springframework.lang.Nullable
	public List<UserInfoModel> userInfo(String user);

	// 회원 정보 수정하기
	@Update("UPDATE user set userPw = #{userPw}, userName = #{userName}, userAddress = #{userAddress} WHERE userId = #{userId};")
	void updateUser(@Param("userId") String userId, @Param("userPw") String userPw, @Param("userName") String userName, @Param("userAddress") String userAddress);
}
