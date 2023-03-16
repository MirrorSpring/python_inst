package com.javalec.base.Controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.javalec.base.mapper.modelMapper;
import com.javalec.base.model.Join_PostUploadModel;
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

}
