package com.ttlin.pojo.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jdk.nashorn.internal.ir.annotations.Ignore;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import java.util.Date;

@Getter
@Setter
@MappedSuperclass
public class BaseEntity {

    @JsonIgnore
    @Column(insertable=false, updatable=false)
    private Date createTime;

    @JsonIgnore
    @Column(insertable=false, updatable=false)
    private Date updateTime;

    @JsonIgnore
    private Date deleteTime;
}
