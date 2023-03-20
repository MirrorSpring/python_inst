package com.javalec.base.Controller;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import org.springframework.boot.autoconfigure.web.ServerProperties.Tomcat.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileSystemUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;





@RestController
@RequestMapping("/src/main/resources/static/images/")
public class Imagecontroller {

    @PatchMapping
    public ResponseEntity<String> updateProfileImage(@RequestParam("image") MultipartFile image) {
        try {
        	 String fileName = StringUtils.cleanPath(image.getOriginalFilename());
        	  saveImage(fileName, image);

            // 업로드 및 저장이 완료되면 성공적인 응답을 반환합니다.
            return ResponseEntity.ok().body(fileName);
//            return new ResponseEntity<Object>(resource, headers, HttpStatus.OK);
        } catch (Exception e) {
            // 예외가 발생하면 실패한 응답을 반환합니다.
            return ResponseEntity.badRequest().body("프로필 이미지 업로드에 실패했습니다.");
        }
    }

    private void saveImage(String fileName, MultipartFile file) throws IOException {
        Path uploadDir = Paths.get("./src/main/resources/static/images/");
        if (Files.exists(uploadDir)) {
            FileSystemUtils.deleteRecursively(uploadDir);
        }
        Files.createDirectories(uploadDir);

        try (InputStream inputStream = file.getInputStream()) {
            Path filePath = uploadDir.resolve(fileName);
            Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
            System.out.println(filePath);
        } catch (IOException e) {
            throw new IOException("Could not save image file: " + fileName, e);
        }
    }
    
    @GetMapping("/images/{filename:.+}")
    @ResponseBody
    public UrlResource getImage(@PathVariable String filename) {
        Path file = Paths.get("./src/main/resources/static/images/" + filename);
        UrlResource resource = null;
        try {
            resource = new UrlResource(file.toUri());
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
        return resource;
    }

}

