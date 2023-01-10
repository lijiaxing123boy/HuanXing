package com.huanxing.cloud.upms.common.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

/**
 * 文件上传 DTO
 *
 * @author lijx
 * @date 2022/7/30
 */
@Data
public class UploadFileDTO {

	@ApiModelProperty(value = "文件")
	private MultipartFile file;

	@ApiModelProperty(value = "文件存储类型")
	private String fileType;

}
