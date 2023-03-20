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
	
	@Select("SELECT poId,poHeart,poTitle,poContent,poPrice,poImage01,poImage02,poImage03,poViews,poState,U_userId,poUpDate, DATE_FORMAT(poUpDate, '%H:%i:%s') AS timeonly FROM post as p , upload as u where p.poId = u.P_poId and poDelDate is null;")
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

	
}
