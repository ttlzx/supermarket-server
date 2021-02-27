SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `create_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  `update_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `delete_time` datetime(3) DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标识, 与id类似, 不要用id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '部分banner可能有标题',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '说明banner在前端的位置',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '部分banner可能有标题图片',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='轮播图';

DROP TABLE IF EXISTS `banner_item`;
CREATE TABLE `banner_item` (
    `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
    `create_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
    `update_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
    `delete_time` datetime(3) DEFAULT NULL,
    `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '标识, 与id类似, 不要用id',
    `banner_id` int(10) unsigned NOT NULL,
    `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
    `keyword` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '查看前端',
    `type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '跳转的目的地',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='轮播图中的元素';

--为什么没有name来标识一个商品
DROP TABLE IF EXISTS `spu`;
CREATE TABLE `spu` (
       `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
       `create_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
       `update_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
       `delete_time` datetime(3) DEFAULT NULL,
       `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
       `subtitle` varchar(800) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
       `category_id` int(10) unsigned NOT NULL COMMENT '二级分类id',
       `root_category_id` int(11) DEFAULT NULL COMMENT '一级分类id',
       `online` tinyint(3) unsigned NOT NULL DEFAULT '1',
       `price` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文本型价格，有时候SPU需要展示的是一个范围，或者自定义平均价格',
       `sketch_spec_id` int(10) unsigned DEFAULT NULL COMMENT '某种规格可以直接附加单品图片',
       `default_sku_id` int(11) DEFAULT NULL COMMENT '默认选中的sku',
       `discount_price` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '文本型折扣价格',
       `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
       `tags` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品的标签, 商品有多个标签, 可以考虑成一张表',
       `for_theme_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品在主题中的图片',
       PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='商品';

DROP TABLE IF EXISTS `spu_img`;
CREATE TABLE `spu_img` (
       `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
       `delete_time` datetime(3) DEFAULT NULL,
       `update_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
       `create_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
       `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
       `spu_id` int(10) unsigned DEFAULT NULL,
       PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='商品的顶部轮播图';

DROP TABLE IF EXISTS `spu_detail_img`;
CREATE TABLE `spu_detail_img` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      `create_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
      `update_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
      `delete_time` datetime(3) DEFAULT NULL,
      `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
      `spu_id` int(10) unsigned DEFAULT NULL,
      `index` int(10) unsigned NOT NULL COMMENT '排序字段',
      PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='商品底部的详细图';

DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
       `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
       `create_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
       `update_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
       `delete_time` datetime(3) DEFAULT NULL,
       `title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '中文限制6个，英文限制12个，由逻辑层控制',
       `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
       `highlight` tinyint(4) unsigned DEFAULT '0',
       `type` tinyint(3) unsigned DEFAULT '1',
       PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='商品的标签';

DROP TABLE IF EXISTS `spu_tag`;
CREATE TABLE `spu_tag` (
       `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
       `spu_id` int(10) unsigned NOT NULL,
       `tag_id` int(10) unsigned NOT NULL,
       PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='spu和tag的第三张表, 无实际意义';

DROP TABLE IF EXISTS `sku`;
CREATE TABLE `sku` (
       `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
       `create_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
       `update_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
       `delete_time` datetime(3) DEFAULT NULL,
       `price` decimal(10,2) unsigned NOT NULL COMMENT '单品的价格, 一定要用 decimal',
       `discount_price` decimal(10,2) unsigned DEFAULT NULL COMMENT '单品的折扣价格, 一定要用 decimal',
       `online` tinyint(3) unsigned NOT NULL DEFAULT '1',
       `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
       `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
       `spu_id` int(10) unsigned NOT NULL,
       `specs` json DEFAULT NULL COMMENT '对应的规格',
       `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
       `stock` int(10) unsigned NOT NULL DEFAULT '0',
       `category_id` int(10) unsigned DEFAULT NULL,
       `root_category_id` int(10) unsigned DEFAULT NULL,
       PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='单品';

DROP TABLE IF EXISTS `spec`;
CREATE TABLE `spec` (
        `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
        `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
        `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        `delete_time` datetime DEFAULT NULL,
        `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
        `unit` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
        `standard` tinyint(3) unsigned NOT NULL DEFAULT '0',
        `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
        PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='商品的规格: 如颜色, 尺寸, 数量';

DROP TABLE IF EXISTS `spec_value`;
CREATE TABLE `spec_value` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      `create_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
      `update_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
      `delete_time` datetime(3) DEFAULT NULL,
      `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
      `spec_id` int(10) unsigned NOT NULL,
      `extend` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
      PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='规格的值: 如颜色的红色, 蓝色, 黑色等';

DROP TABLE IF EXISTS `spu_spec`;
CREATE TABLE `spu_spec` (
       `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
       `spu_id` int(10) unsigned NOT NULL,
       `spec_id` int(10) unsigned NOT NULL,
       PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='spu和spec的第三张表, 无实际意义';

DROP TABLE IF EXISTS `sku_spec_value`;
CREATE TABLE `sku_spec_value` (
        `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
        `sku_id` int(10) unsigned NOT NULL,
        `spec_value_id` int(10) unsigned NOT NULL,
        `spu_id` int(10) unsigned NOT NULL COMMENT '冗余字段',
        `spec_id` int(10) unsigned NOT NULL COMMENT '冗余字段',
        PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='sku和spec_value的第三张表, 添加spu_id, spec_id两个字段';

DROP TABLE IF EXISTS `theme`;
CREATE TABLE `theme` (
     `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
     `create_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
     `update_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
     `delete_time` datetime(3) DEFAULT NULL,
     `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
     `title` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
     `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
     `tpl_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
     `entrance_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
     `extend` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
     `internal_top_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
     `title_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
     `online` tinyint(3) unsigned DEFAULT '1',
     PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='主题';

DROP TABLE IF EXISTS `theme_spu`;
CREATE TABLE `theme_spu` (
     `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
     `theme_id` int(10) unsigned NOT NULL,
     `spu_id` int(10) unsigned NOT NULL,
     PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='theme和spu的第三张表, 无实际意义';

CREATE TABLE `category` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `create_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
    `update_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
    `delete_time` datetime(3) DEFAULT NULL,
    `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
    `is_root` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否是根分类',
    `parent_id` int unsigned DEFAULT NULL COMMENT '上一级分类的id',
    `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
    `index` int unsigned DEFAULT NULL,
    `online` int unsigned DEFAULT '1',
    `level` int unsigned DEFAULT NULL COMMENT '第几级分类',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='分类表';

CREATE TABLE `grid_category` (
     `id` int unsigned NOT NULL AUTO_INCREMENT,
     `create_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
     `update_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
     `delete_time` datetime(3) DEFAULT NULL,
     `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
     `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
     `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
     `category_id` int DEFAULT NULL COMMENT '二级分类id',
     `root_category_id` int DEFAULT NULL COMMENT '对应根分类id',
     PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='网格分类表';

CREATE TABLE `user` (
        `id` int unsigned NOT NULL AUTO_INCREMENT,
        `create_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
        `update_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
        `delete_time` datetime(3) DEFAULT NULL,
        `openid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '微信返回的用户标识',
        `nickname` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
        `unify_uid` int DEFAULT NULL COMMENT '微信返回的用户标识',
        `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
        `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
        `mobile` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
        `wx_profile` json DEFAULT NULL COMMENT '微信返回的数据',
        `group` int unsigned DEFAULT '8' COMMENT '用户分组, 用于做会员系统的权限管理 8-普通用户, 16-会员, 32-超级会员',
        PRIMARY KEY (`id`),
        UNIQUE KEY `uni_openid` (`openid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='C端用户表';

DROP TABLE IF EXISTS `coupon`;
CREATE TABLE `coupon` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      `create_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
      `update_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
      `delete_time` datetime(3) DEFAULT NULL,
      `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
      `start_time` datetime DEFAULT NULL COMMENT '优惠券生效时间',
      `end_time` datetime DEFAULT NULL COMMENT '优惠券失效时间',
      `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
      `full_money` decimal(10,2) DEFAULT NULL COMMENT '满减券或满金额折扣券,满多少钱减, 满多少钱打折',
      `minus` decimal(10,2) DEFAULT NULL COMMENT '满减券, 减多少钱',
      `rate` decimal(10,2) DEFAULT NULL COMMENT '折扣券 打多少拆',
      `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '类似于描述, 如适用于女装',
      `whole_store` tinyint(3) unsigned DEFAULT '0' COMMENT '标明是否是全场券',
      `type` smallint(6) NOT NULL COMMENT '1. 满减券(满1000减200) 2.折扣券(直接打多少折) 3.无门槛券(无金额限制) 4.满金额折扣券(满1000才能打折 )',
      `activity_id` int(10) unsigned DEFAULT NULL,
      PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='优惠券表';

DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity` (
    `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
    `create_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
    `update_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
    `delete_time` datetime(3) DEFAULT NULL,
    `title` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
    `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
    `start_time` datetime(3) NOT NULL,
    `end_time` datetime(3) NOT NULL,
    `remark` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
    `online` tinyint(3) unsigned DEFAULT '1',
    `entrance_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
    `internal_top_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
    `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='优惠活动表, 用于投放和领取优惠券';

DROP TABLE IF EXISTS `activity_coupon`;
CREATE TABLE `activity_coupon` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
   `coupon_id` int(10) unsigned NOT NULL,
   `activity_id` int(11) unsigned NOT NULL,
   PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='活动和优惠券的第三张表';

DROP TABLE IF EXISTS `user_coupon`;
CREATE TABLE `user_coupon` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
   `update_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
   `create_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3) COMMENT '用户领取优惠券时间',
   `user_id` int(10) unsigned NOT NULL,
   `coupon_id` int(10) unsigned NOT NULL,
   `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '1:未使用，2：已使用， 3：已过期',
   `order_id` int(10) unsigned DEFAULT NULL COMMENT '哪个订单使用了优惠券',
   PRIMARY KEY (`id`),
   UNIQUE KEY `uni_user_coupon` (`user_id`,`coupon_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户的优惠券表, 有实际业务意义的第三张表';

DROP TABLE IF EXISTS `coupon_category`;
CREATE TABLE `coupon_category` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
   `category_id` int(10) unsigned NOT NULL,
   `coupon_id` int(11) unsigned NOT NULL,
   PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='优惠券和分类的第三张表, 无实际业务意义';

CREATE TABLE `order` (
     `id` int unsigned NOT NULL AUTO_INCREMENT,
     `create_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
     `delete_time` datetime(3) DEFAULT NULL,
     `update_time` datetime(3) DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
     `order_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '订单号',
     `user_id` int unsigned DEFAULT NULL COMMENT 'user表外键',
     `total_price` decimal(10,2) DEFAULT '0.00' COMMENT '订单总价, 原始价格',
     `total_count` int unsigned DEFAULT '0' COMMENT '订单有多少件sku',
     `snap_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品的图片快照',
     `snap_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '标题的快照',
     `snap_items` json DEFAULT NULL COMMENT 'sku的快照',
     `snap_address` json DEFAULT NULL COMMENT '地址的快照',
     `prepay_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用于微信支付, 预支付订单Id',
     `final_total_price` decimal(10,2) DEFAULT NULL COMMENT '最后除去优惠的总价',
     `status` tinyint unsigned DEFAULT '1' COMMENT '订单状态: 0-全部,1-待支付,2-已支付,3-待发货,4-已发货,5-已取消',
     PRIMARY KEY (`id`) USING BTREE,
     UNIQUE KEY `uni_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=272 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMNET='订单表';

