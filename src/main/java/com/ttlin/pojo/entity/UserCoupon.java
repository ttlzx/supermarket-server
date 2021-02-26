package com.ttlin.pojo.entity;

import lombok.*;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Objects;

import static javax.persistence.GenerationType.IDENTITY;

@Entity
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserCoupon {
    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Long id;
    private Long userId;
    private Long couponId;
    private Integer status;
    private Date createTime;
    private Long orderId;
    private Date updateTime;
}
