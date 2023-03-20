package com.javalec.base.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.javalec.base.model.Join_PostUploadModel;
import com.javalec.base.model.Join_UserReviewModel;
import com.javalec.base.model.PostModel;
import com.javalec.base.model.UserModel;

@Mapper
public interface modelMapper {
	
	// SQL문 작성하고 =#{컬럼}
	// EX ) INSERT INTO user(userName) VALUES (#{userName})
	// Test
	// Test
	@Select("SELECT * FROM user")
	UserModel getuserModelInformation();
	
	@Select("SELECT poId,poHeart,poTitle,poContent,poPrice,poImage01,poImage02,poImage03,poViews,poState FROM post")
	List<PostModel> getpostModelInformation();
	
	@Select("SELECT poId,poHeart,poTitle,poContent,poPrice,poImage01,poImage02,poImage03,poViews,poState,poUser,U_userId,userAddress,userReliability, poUpDate, DATE_FORMAT(poUpDate, '%H:%i:%s') AS timeonly FROM post as p , upload as u, user as us where p.poId = u.P_poId and u.U_userId = us.userId and poDelDate is null order by poUpDate desc")
	List<Join_PostUploadModel> getboardModel();
	
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
	@Update("UPDATE post set poTitle = #{poTitle},poContent = #{poContent},poPrice = #{poPrice} WHERE poId = #{poId}")
	int modifyPost(@Param("poTitle") String poTitle,@Param("poContent") String poContent,@Param("poPrice") String poPrice,@Param("poId") int poId);
	
	// 게시글 작성
	@Insert("INSERT INTO post(poHeart,poTitle,poContent,poPrice,poImage01,poViews,poState,poUser) VALUES(#{poHeart},#{poTitle},#{poContent},#{poPrice},#{poImage01},#{poViews},#{poState},#{poUser})")
	int insertBoard(@Param("poHeart") String poHeart, @Param("poTitle") String poTitle, @Param("poContent") String poContent, @Param("poPrice") String poPrice, @Param("poImage01") String poImage01, @Param("poViews") String poViews, @Param("poState") String poState, @Param("poUser") String poUser );
	
	@Select("SELECT poId from post where poHeart=#{poHeart} and poTitle=#{poTitle} and poContent = #{poContent} and poPrice= #{poPrice} and poImage01= #{poImage01} and poViews= #{poViews} and poState= #{poState} and poUser=#{poUser}")
	int getpostId(@Param("poHeart") String poHeart, @Param("poTitle") String poTitle, @Param("poContent") String poContent, @Param("poPrice") String poPrice, @Param("poImage01") String poImage01, @Param("poViews") String poViews, @Param("poState") String poState, @Param("poUser") String poUser);
	// 작성일자 등록
	@Insert("INSERT INTO upload(P_poId,U_userId,poUpDate) VALUES(#{P_poId},#{U_userId},now())")
	int insertUpload(@Param("P_poId") String P_poId, @Param("U_userId") String U_userId);
	
	@Update("UPDATE upload set poMoDate = now() WHERE P_poId = #{P_poId} and U_userId = #{U_userId}")
	int modifyUpload(@Param("P_poId") String P_poId, @Param("U_userId") String U_userId);

	
}
