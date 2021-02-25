package com.ttlin.pojo.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Objects;

@Entity
@Getter
@Setter
public class SpuImg extends BaseEntity {
    @Id
    private Long id;
    private String img;
    private Long spuId;
}
