/**
 * @作者 7七月
 * @微信公号 林间有风
 * @开源项目 $ http://talelin.com
 * @免费专栏 $ http://course.talelin.com
 * @我的课程 $ http://imooc.com/t/4294850
 * @创建时间 2020-03-22 13:49
 */
package com.ttlin.common.base;


import com.ttlin.common.exception.http.HttpException;

public class CreateSuccess extends HttpException {
    public CreateSuccess(int code){
        this.httpStatusCode = 201;
        this.code = code;
    }
}
