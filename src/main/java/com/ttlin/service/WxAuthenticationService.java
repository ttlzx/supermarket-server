/**
 * @作者 7七月
 * @微信公号 林间有风
 * @开源项目 $ http://7yue.pro
 * @免费专栏 $ http://course.7yue.pro
 * @我的课程 $ http://imooc.com/t/4294850
 * @创建时间 2020-03-12 21:09
 */
package com.ttlin.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ttlin.common.exception.http.ParameterException;
import com.ttlin.common.utils.JwtToken;
import com.ttlin.pojo.entity.User;
import com.ttlin.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.text.MessageFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Service
public class WxAuthenticationService {

    @Autowired
    private ObjectMapper mapper;

    @Autowired
    private UserRepository userRepository;

    @Value("${wx.code2session}")
    private String code2SessionUrl;
    @Value("${wx.appid}")
    private String appid;
    @Value("${wx.appsecret}")
    private String appsecret;

    public String code2Session(String code) {
        String url = MessageFormat.format(this.code2SessionUrl, this.appid, this.appsecret, code);
        RestTemplate rest = new RestTemplate();
        String sessionText = rest.getForObject(url, String.class);

        Map<String, Object> session = new HashMap<>();
        try {
            session = mapper.readValue(sessionText, Map.class);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return this.registerUser(session);
    }

    private String registerUser(Map<String, Object> session) {
        String openid = (String)session.get("openid");
        if (openid == null){
            throw new ParameterException(20004);
        }
        Optional<User> userOptional = this.userRepository.findByOpenid(openid);
        if(userOptional.isPresent()){
            Long uid = userOptional.get().getId();
            return JwtToken.makeToken(uid);
        }

        User user = User.builder()
                .openid(openid)
                .build();
        userRepository.save(user);

        //直接使用自增长的用户id????
        Long uid = user.getId();
        return JwtToken.makeToken(uid);
    }
}
