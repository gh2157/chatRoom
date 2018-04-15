CREATE TABLE `remote_general`.`t_group_chat_history` (
  `idx` INT NOT NULL AUTO_INCREMENT,
  `groupId` INT NOT NULL,
  `fromId` INT NULL,
  `fromName` VARCHAR(45) NULL,
  `content` VARCHAR(1024) NULL,
  `fromTime` TIMESTAMP NULL,
  PRIMARY KEY (`idx`));

CREATE TABLE `remote_general`.`t_user_chat_history` (
  `idx` INT NOT NULL AUTO_INCREMENT,
  `userId` INT NULL,
  `fromId` INT NULL,
  `fromName` VARCHAR(45) NULL,
  `content` VARCHAR(1024) NULL,
  `fromTime` TIMESTAMP NULL,
  PRIMARY KEY (`idx`));
