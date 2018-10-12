
create database if not exists jjt_hospital_appointment;

	drop table if exists t_user;
	CREATE TABLE `t_user` (
	  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
		`alias` varchar(11) DEFAULT NULL comment '用户昵称',
		`name` varchar(11) DEFAULT NULL comment '用户名称',
		`sex` tinyint(1) DEFAULT NULL comment '1.男 2.女',
		`phone` varchar(15) DEFAULT NULL COMMENT '手机号',
		`inviter_id` int(11) DEFAULT 0 COMMENT '邀请人id',
	  `balance` int(11) NOT NULL DEFAULT 0 COMMENT '用户当前余额',
		`token` varchar(50) DEFAULT NULL COMMENT 'token验证',
		`wechat_open_id` varchar(50) DEFAULT NULL COMMENT '微信公众号使用openid,公众号支付操作必填',
		`wechat_union_id` varchar(50) DEFAULT NULL COMMENT '微信唯一ID',
	  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
		`update_time` datetime DEFAULT NULL COMMENT '修改时间',
		`status` int(1) NOT NULL DEFAULT '1' COMMENT '状态 1启用 2禁用',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COMMENT='用户基本信息表';
	
	DROP TABLE IF EXISTS `t_city`;
	/*!40101 SET @saved_cs_client     = @@character_set_client */;
	/*!40101 SET character_set_client = utf8 */;
	CREATE TABLE `t_city` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `name` varchar(20) DEFAULT NULL,
	  `is_show` tinyint(4) DEFAULT '1' comment '是否显示 1 显示 2 不显示 ',
	  `pinyin` varchar(70) DEFAULT NULL COMMENT '拼音',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COMMENT='城市';
	
	DROP TABLE IF EXISTS `t_role`;
	CREATE TABLE `t_role` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `name` varchar(20) DEFAULT NULL comment '角色名称',
	  `role_type` tinyint(1) default '1' comment '角色类型 1 首席体验官 2 城市合伙人 3 普通患者',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COMMENT='角色';
	
	DROP TABLE IF EXISTS `t_user_role_city`;
	CREATE TABLE `t_user_role_city` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `user_id` int(11) NOT NULL COMMENT '用户id',
		`role_id` int(11) NOT NULL COMMENT '角色id',
		`city_id` int(11) NOT NULL COMMENT '城市id',
	  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
		`update_time` datetime DEFAULT NULL COMMENT '修改时间',
	  PRIMARY KEY (`id`),
		KEY `user_id_index` (`user_id`) USING BTREE,
		KEY `role_id_index` (`role_id`) USING BTREE,
		KEY `city_id_index` (`city_id`) USING BTREE
	) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COMMENT='用户角色城市关联';
	
	DROP TABLE IF EXISTS `t_withdrawals`;
	/*!40101 SET @saved_cs_client     = @@character_set_client */;
	/*!40101 SET character_set_client = utf8 */;
	CREATE TABLE `t_withdrawals` (
	  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
		`user_id` int(11) NOT NULL COMMENT '用户id',
	  `bank_id` int(11) DEFAULT NULL COMMENT '银行卡ID(微信支付不需要)',
	  `money` bigint(20) DEFAULT NULL COMMENT '提现金额',
	  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
		`update_time` datetime DEFAULT NULL COMMENT '修改时间',
	  `status` int(1) DEFAULT '1' COMMENT '1:审核中 2：已提现 3:失败',
		`reason` varchar(30) default null comment '原因',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COMMENT='提现审核表';
	
	DROP TABLE IF EXISTS `t_hospital`;
	/*!40101 SET @saved_cs_client     = @@character_set_client */;
	/*!40101 SET character_set_client = utf8 */;
	CREATE TABLE `t_hospital` (
	  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
		`name` varchar(20) DEFAULT NULL comment '医院名称',
	  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
		`update_time` datetime DEFAULT NULL COMMENT '修改时间',
	  `status` int(1) NOT NULL DEFAULT '1' COMMENT '状态 1启用 2禁用',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COMMENT='医院表';
	
	DROP TABLE IF EXISTS `t_hospital_category`;
	CREATE TABLE `t_hospital_category` (
	  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
		`hospital_id` int(11) DEFAULT NULL COMMENT '医院ID',
		`category_name` varchar(20) DEFAULT NULL comment '医院治疗项目名称',
	  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
		`update_time` datetime DEFAULT NULL COMMENT '修改时间',
	  `status` int(1) NOT NULL DEFAULT '1' COMMENT '状态 1启用 2禁用',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COMMENT='医院治疗项目表';
	
	DROP TABLE IF EXISTS `t_hospital_category_money`;
	CREATE TABLE `t_hospital_category_money` (
	  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
		`category_id` varchar(20) DEFAULT NULL comment '医院治疗项目id',
		`money` int(11) NOT NULL DEFAULT 0 COMMENT '金额',
	  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
		`update_time` datetime DEFAULT NULL COMMENT '修改时间',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COMMENT='医院治疗项目价格表';
	
	DROP TABLE IF EXISTS `t_hospital_appointment`;
	/*!40101 SET @saved_cs_client     = @@character_set_client */;
	/*!40101 SET character_set_client = utf8 */;
	CREATE TABLE `t_hospital_appointment` (
	  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
		`user_id` int(11) NOT NULL COMMENT '用户id',
		`hospital_id` int(11) DEFAULT NULL COMMENT '医院ID',
		`name` varchar(20) DEFAULT NULL COMMENT '医院名称',
		`category_id` varchar(20) DEFAULT NULL COMMENT '医院治疗项目id',
		`category_name` varchar(20) DEFAULT NULL COMMENT '医院治疗项目名称',
		`location` varchar(50) DEFAULT NULL COMMENT '医院治疗具体地点',
		`money` int(11) NOT NULL DEFAULT 0 COMMENT '金额',
		`begin_time` datetime DEFAULT NULL COMMENT '计划预约开始时间',
		`end_time` datetime DEFAULT NULL COMMENT '计划预约结束时间',
	  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
		`update_time` datetime DEFAULT NULL COMMENT '修改时间',
	  `status` int(1) DEFAULT '1' COMMENT '预约记录状态: 1.等待确认 2.等待尾款 3.已支付 4.已取消 5.完成治疗 6.等待支付确认',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COMMENT='医院预约表';
	
	DROP TABLE IF EXISTS `t_hospital_appointment_record`;
	CREATE TABLE `t_hospital_appointment_record` (
	  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
		`hospital_appointment_id` int(11) NOT NULL COMMENT '医院预约id',
	  `status_before` int(1) DEFAULT '1' COMMENT '预约记录状态: 1.等待确认 2.等待尾款 3.已支付 4.已取消 5.完成治疗 6.等待支付确认',
		`status_after` int(1) DEFAULT '1' COMMENT '预约记录状态: 1.等待确认 2.等待尾款 3.已支付 4.已取消 5.完成治疗 6.等待支付确认',
		`create_time` datetime DEFAULT NULL COMMENT '创建时间',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COMMENT='医院预约记录表';
	
	DROP TABLE IF EXISTS `t_invite_record`;
	CREATE TABLE `t_invite_record` (
	  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
		`inviter_id` int(11) NOT NULL COMMENT '邀请人id',
		`invitee_id` int(11) NOT NULL COMMENT '被邀请人id',
	  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
		`update_time` datetime DEFAULT NULL COMMENT '修改时间',
		UNIQUE KEY `inviter_invitee_union_index` (`inviter_id`, `invitee_id`) USING BTREE,
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COMMENT='邀请记录表';
	
	DROP TABLE IF EXISTS `t_invite_capital_record`;
	CREATE TABLE `t_invite_capital_record` (
	  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
		`inviter_id` int(11) NOT NULL COMMENT '邀请人id',
		`invitee_id` int(11) NOT NULL COMMENT '被邀请人id',
		`inviter_capital` int(11) NOT NULL DEFAULT 0 COMMENT '邀请人所得资金',
	  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
		`update_time` datetime DEFAULT NULL COMMENT '修改时间',
		UNIQUE KEY `inviter_invitee_union_index` (`inviter_id`, `invitee_id`) USING BTREE,
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COMMENT='邀请资金流水记录表';
	
	DROP TABLE IF EXISTS `t_commission_capital_record`;
	CREATE TABLE `t_commission_capital_record` (
	  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
		`user_id` int(11) NOT NULL COMMENT '用户id',
		`capital` int(11) NOT NULL DEFAULT 0 COMMENT '所得资金',
	  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
		`update_time` datetime DEFAULT NULL COMMENT '修改时间',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COMMENT='提成资金流水记录表';
	
	DROP TABLE IF EXISTS `t_invite_statistics`;
	CREATE TABLE `t_invite_statistics` (
	  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
		`user_id` int(11) NOT NULL COMMENT '用户id',
		`city_id` int(11) NOT NULL COMMENT '城市id',
		`count` int(7) NOT NULL default 0 COMMENT '邀请数量',
		`create_time` datetime DEFAULT NULL COMMENT '创建时间',
		`update_time` datetime DEFAULT NULL COMMENT '修改时间',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COMMENT='邀请记录表';
	
	DROP TABLE IF EXISTS `t_validate_code`;
	/*!40101 SET @saved_cs_client     = @@character_set_client */;
	/*!40101 SET character_set_client = utf8 */;
	CREATE TABLE `t_validate_code` (
	  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
	  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
	  `validate_code` varchar(6) DEFAULT NULL COMMENT '验证码',
	  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
	  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
	  `operation_type` int(2) DEFAULT NULL COMMENT '0身份验证 1用户注册 2登录确认 3修改密码 4信息变更',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 COMMENT='验证码';
	