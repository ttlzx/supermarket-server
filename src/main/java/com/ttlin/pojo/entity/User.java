package com.ttlin.pojo.entity;

import lombok.*;
import org.hibernate.annotations.Where;

import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;

@Entity
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Where(clause = "delete_time is null")
public class User extends BaseEntity{
    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Long id;
    private String openid;
    private String nickname;
    private Long unifyUid;
    private String email;
    private String password;
    private String mobile;
    private String wxProfile;
}
