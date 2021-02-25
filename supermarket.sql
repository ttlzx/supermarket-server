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
       `category_id` int(10) unsigned NOT NULL,
       `root_category_id` int(11) DEFAULT NULL,
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

