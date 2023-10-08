CREATE DATABASE IF NOT EXISTS `khalid` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
GO
USE `khalid`;
GO
CREATE TABLE IF NOT EXISTS `tests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `results` varchar(30) NOT NULL,
  `no_tests` int(11) NOT NULL,
   PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
GO
INSERT INTO `tests` (name, results, no_tests) VALUES ('test1', 'positive', '1'), ('test2', 'positive', '3'), ('test3', 'negative', '5'), ('test4', 'neutral', '10');

