package com.javalec.base.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.javalec.base.model.Join_PostUploadModel;
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
	


	
}
