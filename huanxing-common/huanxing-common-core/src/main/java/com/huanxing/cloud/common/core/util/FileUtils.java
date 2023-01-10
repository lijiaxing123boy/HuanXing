package com.huanxing.cloud.common.core.util;

import cn.hutool.core.lang.UUID;
import cn.hutool.core.util.StrUtil;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;

/**
 * file工具类 http://www.manongjc.com/detail/24-cmrqotjccdvsmdf.html
 *
 * @author lijx
 * @date 2022/6/10
 */
public class FileUtils {

	/**
	 * 将MultipartFile转为File
	 *
	 * @author lijx
	 * @date 2022/6/10
	 * @param mulFile
	 * @return: java.io.File
	 */
	public static File multipartFileToFile(MultipartFile mulFile) throws IOException {
		InputStream ins = null;
		File file = null;
		OutputStream os = null;
		try {
			ins = mulFile.getInputStream();
			// 获得原始⽂件名;
			String fileName = mulFile.getOriginalFilename();
			String prefix = getFileNameNoEx(fileName) + UUID.fastUUID();
			String suffix = "." + getExtensionName(fileName);
			file = File.createTempFile(prefix, suffix);
			os = new FileOutputStream(file);
			int bytesRead = 0;
			byte[] buffer = new byte[8192];
			while ((bytesRead = ins.read(buffer, 0, 8192)) != -1) {
				os.write(buffer, 0, bytesRead);
			}
		}
		finally {
			if (os != null) {
				os.close();
			}
			if (ins != null) {
				ins.close();
			}
		}
		return file;
	}

	/**
	 * 获取文件扩展名
	 *
	 * @author lijx
	 * @date 2022/6/10
	 * @param filename
	 * @return: java.lang.String
	 */
	public static String getExtensionName(String filename) {
		if (StrUtil.isNotEmpty(filename)) {
			int dot = filename.lastIndexOf('.');
			if (dot > -1 && dot < (filename.length() - 1)) {
				return filename.substring(dot + 1);
			}
		}
		return filename;
	}

	/**
	 * 获取文件名前缀
	 *
	 * @author lijx
	 * @date 2022/6/10
	 * @param filename
	 * @return: java.lang.String
	 */
	public static String getFileNameNoEx(String filename) {
		if (StrUtil.isNotEmpty(filename)) {
			int dot = filename.lastIndexOf('.');
			if (dot > -1 && dot < (filename.length())) {
				return filename.substring(0, dot);
			}
		}
		return filename;
	}

	/**
	 * 删除本地临时文件
	 *
	 * @author lijx
	 * @date 2022/6/10
	 * @param file
	 * @return: void
	 */
	public static void deleteTempFile(File file) {
		if (file != null) {
			File del = new File(file.toURI());
			del.delete();
		}
	}

}
