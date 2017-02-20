/*CREATE DATABASE `gym` CHARACTER SET utf8 COLLATE utf8_general_ci;*/

SET FOREIGN_KEY_CHECKS = 0;

SET NAMES utf8;

/*TABLE `client`*/
DROP TABLE IF EXISTS `client`;
CREATE TABLE `client`
(
  `client_id` INT(11)      NOT NULL AUTO_INCREMENT,
  `name`      VARCHAR(255) NOT NULL,
  `surname`   VARCHAR(255) NOT NULL,
  `age`       INT(11)      NOT NULL,
  `phone`     VARCHAR(255) NOT NULL,
  PRIMARY KEY (`client_id`)
) DEFAULT CHARSET = utf8;

INSERT INTO `client` VALUES
('1', 'Иван', 'Иванов', '30', '88005553535'),
('2', 'Петр', 'Петров', '20', '89275543631'),
('3', 'Юлия', 'Сидорова', '35', '89873553225'),
('4', 'Алексей', 'Алексеев', '30', '89175763435'),
('5', 'Марина', 'Константинова', '18', '89023453443'),
('6', 'Петр', 'Иванов', '23', '89276663631'),
('7', 'Алексей', 'Петров', '22', '568975'),
('8', 'Михаил', 'Курочкин', '50', '89179963435'),
('9', 'Алексей', 'Швабрин', '40', '89873541225'),
('10', 'Иван', 'Медведев', '18', '89023451943');

/*TABLE `card`*/
DROP TABLE IF EXISTS `card`;
CREATE TABLE `card`
(
  `card_id` INT(11)               NOT NULL AUTO_INCREMENT,
  `active`  BOOLEAN DEFAULT false NOT NULL,
  PRIMARY KEY (`card_id`)
) DEFAULT CHARSET = utf8;

INSERT INTO `card` VALUES
('1', '1'),
('2', '1'),
('3', '1'),
('4', '0'),
('5', '1'),
('6', '1'),
('7', '1'),
('8', '0'),
('9', '1'),
('10', '0'),
('11', '1'),
('12', '1'),
('13', '1');

/*TABLE `сlient_card`*/
DROP TABLE IF EXISTS `client_card`;
CREATE TABLE `client_card`
(
  `client_id` INT(11) NOT NULL,
  `card_id`   INT(11) NOT NULL,
  PRIMARY KEY (`client_id`, `card_id`),
  FOREIGN KEY (`client_id`)
    REFERENCES `сlient` (`client_id`)
    ON DELETE CASCADE,
  FOREIGN KEY (`card_id`)
    REFERENCES `card` (`card_id`)
    ON DELETE CASCADE
) DEFAULT CHARSET = utf8;

INSERT INTO `client_card` VALUES
('1', '1'),
('2', '2'),
('3', '3'),
('4', '11'),
('5', '5'),
('6', '6'),
('7', '7'),
('8', '12'),
('9', '9'),
('10', '13');

/*TABLE `service`*/
DROP TABLE IF EXISTS `service`;
CREATE TABLE `service`
(
  `service_id` INT(11)      NOT NULL AUTO_INCREMENT,
  `name`       VARCHAR(255) NOT NULL,
  PRIMARY KEY (`service_id`)
) DEFAULT CHARSET = utf8;

INSERT INTO `service` VALUES
('1', 'Тренажерный зал'),
('2', 'Сайкл'),
('3', 'Пилатес'),
('4', 'Йога'),
('5', 'Зумба'),
('6', 'Персональные тренировки');

/*TABLE `service_rate`*/
DROP TABLE IF EXISTS `service_rate`;
CREATE TABLE `service_rate`
(
  `service_rate_id` INT(11)      NOT NULL AUTO_INCREMENT,
  `name`            VARCHAR(255) NOT NULL,
  `service_id`      INT(11)      NOT NULL,
  `price`           INT(11)      NOT NULL,
  `count_visits`    INT(11)      NOT NULL,
  PRIMARY KEY (`service_rate_id`)
) DEFAULT CHARSET = utf8;

INSERT INTO `service_rate` VALUES
('1', 'Стандартный', '1', '1000', '8'),
('2', 'Продвинутый', '1', '1350', '12'),
('3', 'Профессиональный', '1', '1800', '16'),
('4', 'Сайкл стандартный', '2', '1500', '8'),
('5', 'Пилатес стандартный', '3', '1200', '6'),
('6', 'Йога стандартный', '4', '1350', '12'),
('7', 'Зумба стандартный', '5', '1350', '9'),
('8', 'Стандартный', '6', '5000', '12');

/*TABLE `card_service`*/
DROP TABLE IF EXISTS `card_service_rate`;
CREATE TABLE `card_service_rate`
(
  `card_id`    INT(11) NOT NULL,
  `service_rate_id` INT(11) NOT NULL,
  PRIMARY KEY (`card_id`, `service_rate_id`),
  FOREIGN KEY (`card_id`)
    REFERENCES `card` (`card_id`)
    ON DELETE CASCADE,
  FOREIGN KEY (`service_rate_id`)
    REFERENCES `service_rate` (`service_rate_id`)
    ON DELETE CASCADE
) DEFAULT CHARSET = utf8;

INSERT INTO `card_service_rate` VALUES
('1', '2'),
('2', '1'),
('3', '2'),
('5', '3'),
('6', '8'),
('7', '1'),
('9', '4'),
('11', '3'),
('12', '1'),
('13', '7');

/*TABLE `coach`*/
DROP TABLE IF EXISTS `coach`;
CREATE TABLE `coach`
(
  `coach_id` INT(11)      NOT NULL AUTO_INCREMENT,
  `name`     VARCHAR(255) NOT NULL,
  `surname`  VARCHAR(255) NOT NULL,
  `age`      INT(11)      NOT NULL,
  `address`  VARCHAR(255) NOT NULL,
  `phone`    VARCHAR(255) NOT NULL,
  PRIMARY KEY(`coach_id`)
) DEFAULT CHARSET = utf8;

INSERT INTO `coach` VALUES
('1', 'Сергей', 'Сергеев', '30', 'г. Йошкар-Ола', '88005553535'),
('2', 'Петр', 'Михайлов', '20', 'г. Йошкар-Ола', '89275543631'),
('3', 'Татьяна', 'Комарова', '35', 'г. Йошкар-Ола', '89873553225'),
('4', 'Александр', 'Борода', '30', 'г. Йошкар-Ола', '89175763435'),
('5', 'Марина', 'Пугачева', '18', 'г. Йошкар-Ола', '89023453443'),
('6', 'Илья', 'Васильев', '23', 'г. Йошкар-Ола', '89276663631');

/*TABLE `service_coach`*/
DROP TABLE IF EXISTS `service_coach`;
CREATE TABLE `service_coach`
(
  `service_id` INT(11) NOT NULL,
  `coach_id`   INT(11) NOT NULL,
  PRIMARY KEY (`service_id`, `coach_id`),
  FOREIGN KEY (`service_id`)
    REFERENCES `service` (`service_id`)
    ON DELETE CASCADE,
  FOREIGN KEY (`coach_id`)
    REFERENCES `coach` (`coach_id`)
    ON DELETE CASCADE
) DEFAULT CHARSET = utf8;

INSERT INTO `service_coach` VALUES
('1', '1'),
('2', '1'),
('3', '2'),
('4', '3'),
('5', '1'),
('2', '6'),
('3', '3'),
('4', '4'),
('5', '5'),
('6', '1');

/*TABLE `visit`*/
DROP TABLE IF EXISTS `visit`;
CREATE TABLE `visit`
(
  `visit_id`   INT(11) NOT NULL AUTO_INCREMENT,
  `card_id`    INT(11) NOT NULL,
  `service_id` INT(11) NOT NULL,
  `date`       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(`visit_id`)
) DEFAULT CHARSET = utf8;

INSERT INTO `visit` VALUES
('1', '1', '1', '2017-01-07 18:20:00'),
('2', '2', '1', '2017-01-07 18:20:01'),
('3', '3', '1', '2017-01-07 18:20:02'),
('4', '4', '1', '2017-01-10 17:20:00'),
('5', '5', '1', '2017-02-05 17:20:10'),
('6', '6', '1', '2017-02-05 18:20:11'),
('7', '7', '1', '2017-02-10 16:20:00'),
('8', '8', '1', '2017-02-10 16:20:01'),
('9', '9', '1', '2017-02-10 17:45:00'),
('10', '10', '1', '2017-02-18 18:30:00'),
('11', '11', '1', '2017-02-18 18:25:00');

SET FOREIGN_KEY_CHECKS = 1;