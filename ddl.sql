drop table if exists connect_info;
drop table if exists model_info;
drop table if exists user_info;

-- -----------------------------------------------------
-- Table `user_info`
-- -----------------------------------------------------
CREATE TABLE `user_info` (
    `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '유저 id',
    `user_login_id` VARCHAR(100) NULL DEFAULT NULL COMMENT '로그인 id',
    `user_login_pw` VARCHAR(100) NULL DEFAULT NULL COMMENT '로그인 password',
    `user_name` VARCHAR(100) NULL DEFAULT NULL COMMENT '유저 이름',
    PRIMARY KEY (`id`)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- Table `model_info`
-- -----------------------------------------------------
CREATE TABLE `model_info` (
    `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '모델 id',
    `master_user_info_id` INT(11) NULL DEFAULT NULL COMMENT '마스터 유저 id',
    `model_code` VARCHAR(100) NULL DEFAULT NULL COMMENT '모델 고유 코드',
    `model_name` VARCHAR(100) NULL DEFAULT NULL COMMENT '설정된 모델 이름',
    `model_key_value` VARCHAR(100) NULL DEFAULT NULL COMMENT '모델 키 값',
    PRIMARY KEY (`id`),
    FOREIGN KEY (`master_user_info_id`) REFERENCES `user_info` (`id`)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- -----------------------------------------------------
-- Table `connect_info`
-- -----------------------------------------------------
CREATE TABLE `connect_info` (
    `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '연결 id',
    `user_info_id` INT(11) NOT NULL COMMENT '연결할 유저 id',
    `model_info_id` INT(11) NOT NULL COMMENT '연결할 모델 id',
    `connect_flag` INT(1) NOT NULL DEFAULT '0' COMMENT '유저와 모델이 연결되어있는지 여부',
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_info_id`) REFERENCES `user_info` (`id`),
    FOREIGN KEY (`model_info_id`) REFERENCES `model_info` (`id`)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8;