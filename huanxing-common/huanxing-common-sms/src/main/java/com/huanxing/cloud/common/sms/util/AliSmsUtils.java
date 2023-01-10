package com.huanxing.cloud.common.sms.util;

import com.aliyun.dysmsapi20170525.models.SendSmsRequest;
import com.aliyun.dysmsapi20170525.models.SendSmsResponse;
import com.aliyun.tea.TeaException;
import com.aliyun.teaopenapi.models.Config;
import com.aliyun.teautil.models.RuntimeOptions;
import com.huanxing.cloud.common.sms.properties.AliSmsProperties;
import lombok.AllArgsConstructor;

/**
 * 阿里云发送短信
 *
 * @author lijx
 * @date 2022/7/4
 */
@AllArgsConstructor
public class AliSmsUtils {

	private final AliSmsProperties aliSmsProperties;

	/**
	 * 使用AK&SK初始化账号Client
	 *
	 * @author lijx
	 * @date 2022/7/4
	 * @param accessKeyId
	 * @param accessKeySecret
	 * @return: com.aliyun.dysmsapi20170525.Client
	 */
	public static com.aliyun.dysmsapi20170525.Client createClient(String accessKeyId, String accessKeySecret)
			throws Exception {
		Config config = new Config()
				// 您的 AccessKey ID
				.setAccessKeyId(accessKeyId)
				// 您的 AccessKey Secret
				.setAccessKeySecret(accessKeySecret);
		// 访问的域名
		config.endpoint = "dysmsapi.aliyuncs.com";
		return new com.aliyun.dysmsapi20170525.Client(config);
	}

	public void sendSms(String phoneNumber, String templateParam) throws Exception {
		com.aliyun.dysmsapi20170525.Client client = createClient(aliSmsProperties.getAccessKeyId(),
				aliSmsProperties.getAccessKeySecret());
		SendSmsRequest sendSmsRequest = new SendSmsRequest().setSignName(aliSmsProperties.getLoginSignName())
				.setTemplateCode(aliSmsProperties.getLoginTemplateCode()).setPhoneNumbers(phoneNumber)
				.setTemplateParam(templateParam);
		RuntimeOptions runtime = new RuntimeOptions();
		try {
			SendSmsResponse sendSmsResponse = client.sendSmsWithOptions(sendSmsRequest, runtime);
			if (!sendSmsResponse.getBody().code.equals("OK")) {
				throw new RuntimeException(sendSmsResponse.getBody().message);
			}
		}
		catch (TeaException error) {
			// 如有需要，请打印 error
			throw new RuntimeException(error.message);
		}
		catch (Exception _error) {
			throw new RuntimeException(_error.getMessage());
		}
	}

}
