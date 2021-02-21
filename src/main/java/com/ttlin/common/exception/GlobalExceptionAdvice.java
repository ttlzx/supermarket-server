package com.ttlin.common.exception;

import com.ttlin.common.base.UnifyResponse;
import com.ttlin.common.configuration.ExceptionCodeConfiguration;
import com.ttlin.common.exception.http.HttpException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import javax.servlet.http.HttpServletRequest;

@ControllerAdvice
public class GlobalExceptionAdvice {

    @Autowired
    ExceptionCodeConfiguration exceptionCodeConfiguration;

    //未知异常处理
    @ExceptionHandler(Exception.class)
    @ResponseBody
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public UnifyResponse handleException(HttpServletRequest req, Exception e){

        String method = req.getMethod();
        String requestUrl = req.getRequestURI();
        System.out.println(e);
        UnifyResponse unifyResponse = new UnifyResponse(9999,"服务器错误",method+" "+requestUrl);
        return unifyResponse;
    }

    //已知http异常处理
    @ExceptionHandler(HttpException.class)
    public ResponseEntity<UnifyResponse> handleHttpException(HttpServletRequest req, HttpException e){
        String method = req.getMethod();
        String requestUrl = req.getRequestURI();
        System.out.println(e);

        UnifyResponse unifyResponse = new UnifyResponse(e.getCode(),exceptionCodeConfiguration.getMessage(e.getCode()),method+" "+requestUrl);

        //设置http status
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_JSON);
        HttpStatus httpStatus = HttpStatus.resolve(e.getHttpStatusCode());

        ResponseEntity<UnifyResponse> responseEntity = new ResponseEntity(unifyResponse,httpHeaders,httpStatus);
        return responseEntity;
    }
}
