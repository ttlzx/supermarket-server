package com.ttlin.pojo.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Objects;

@Entity
@Getter
@Setter
public class Theme extends BaseEntity {
    @Id
    private Long id;
    private String name;
    private String title;
    private String description;
    private String tplName;
    private String entranceImg;
    private String extend;
    private String internalTopImg;
    private String titleImg;
    private Boolean online;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name="theme_spu", joinColumns = @JoinColumn(name="theme_id")
            , inverseJoinColumns = @JoinColumn(name="spu_id"))
    private List<Spu> spuList;
}
