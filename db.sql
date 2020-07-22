-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: mysql:3306
-- 생성 시간: 20-07-22 00:19
-- 서버 버전: 5.7.31
-- PHP 버전: 7.2.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 데이터베이스: `test_db`
--

-- --------------------------------------------------------

--
-- 테이블 구조 `tbl_member`
--

CREATE TABLE `tbl_member` (
  `mid` int(11) NOT NULL,
  `id` varchar(30) NOT NULL,
  `pass` varchar(30) NOT NULL,
  `name` varchar(20) NOT NULL,
  `tel` varchar(12) NOT NULL,
  `email` varchar(100) NOT NULL,
  `sex` enum('m','f') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 테이블의 덤프 데이터 `tbl_member`
--

INSERT INTO `tbl_member` (`mid`, `id`, `pass`, `name`, `tel`, `email`, `sex`) VALUES
(3, 'abcde', 'abc@12345', '장윤경', '01072878047', 'mipsang3@gmail.com', 'f'),
(4, 'abcded', 'abc@12345', '테스트', '01012345678', 'test@test.com', NULL),
(5, 'test1', 'test1@12345', '김철철', '01024258786', 'test1@test1.com', NULL),
(6, 'test2', 'test2@12345', '박팔팔', '01073246987', 'test2@test2.com', NULL),
(7, 'test3', 'test3@12345', '멋진단체', '0636504587', 'test3@test3.com', NULL),
(8, 'test4', 'test4@12345', '이철접', '01057578984', 'test4@test4.com', NULL),
(9, 'test5', 'test5@12345', '나성용', '01087324189', 'test5@test5.com', NULL),
(10, 'test6', 'test6@12345', '남해바다횟집', '0558647787', 'test6@test6.com', NULL),
(11, 'test7', 'test7@12345', '전주순대국밥', '0635728940', 'test7@test7.com', NULL),
(12, 'test8', 'test8@12345', '부산등킨', '0513547961', 'test8@test8.com', NULL),
(13, 'test9', 'test9@12345', '송말차', '01058223311', 'test9@test9.com', NULL),
(14, 'test10', 'test10@12345', '윤민초', '01076210346', 'test10@test10.com', NULL),
(15, 'test11', 'test11@12345', '기창섭', '01087321545', 'test11@test11.com', NULL),
(16, 'test12', 'test12@12345', '김수한무', '01067841235', 'test12@test12.com', NULL),
(17, 'test13', 'test13@12345', '정랄랄', '01045427890', 'test13@test13.com', NULL),
(18, 'test14', 'test14@12345', '전유주', '01015762789', 'test14@test14.com', NULL),
(19, 'test15', 'test15@12345', '천정석', '01012487965', 'test15@test15.com', NULL),
(20, 'test16', 'test16@12345', '김별이', '01072497321', 'test16@test16.com', NULL),
(21, 'test17', 'test17@12345', '정혜진', '01072495454', 'test17@test17.com', NULL),
(22, 'test18', 'test18@12345', '안용선', '01021675124', 'test18@test18.com', NULL),
(23, 'test19', 'test19@12345', '성동호', '01072148945', 'test19@test19.com', NULL),
(24, 'test20', 'test20@12345', '채동하', '01012189314', 'test20@test20.com', NULL),
(25, 'test21', 'test21@12345', '최희찬', '01075149747', 'test21@test21.com', NULL),
(26, 'test22', 'test22@12345', '김정식', '01010231119', 'test22@test22.com', NULL),
(27, 'test23', 'en1**2555545', '홍기안', '01011233119', 'test23@test23.com', NULL),
(28, 'ded', 'abc$3Fddddd', '대취타', '01000001111', 'jointest@ddd.cc.co', 'm');

-- --------------------------------------------------------

--
-- 테이블 구조 `tbl_order`
--

CREATE TABLE `tbl_order` (
  `order_id` varchar(12) NOT NULL,
  `prod_id` int(11) NOT NULL,
  `prod_name` varchar(100) NOT NULL,
  `id` varchar(30) CHARACTER SET utf8 NOT NULL,
  `paytime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 테이블의 덤프 데이터 `tbl_order`
--

INSERT INTO `tbl_order` (`order_id`, `prod_id`, `prod_name`, `id`, `paytime`) VALUES
('03ADB2EEE4C1', 4, '가죽 펜 케이스+로즈우드 만년필', 'test10', '2020-07-21 08:06:38'),
('18798F950D87', 3, '생신,환갑,칠순 케이크토퍼(매화)', 'test1', '2020-07-21 07:38:43'),
('18D375A2B2A3', 3, '코이버펑크 샤르도네 세미용 와인 2018', 'test6', '2020-07-21 07:25:38'),
('19BFD2C1BAA6', 8, '💛입점할인 진행중‼️💛 황금추어탕 750g', 'test12', '2020-07-21 07:20:29'),
('22E3181A62D2', 2, '코이버펑크 샤르도네 세미용 와인 2018', 'test10', '2020-07-21 07:15:29'),
('246D4D44F553', 5, '나만의 커스텀 토이 피규어💑(m)', 'test11', '2020-07-21 07:02:14'),
('257A62AC0E29', 4, '가죽 펜 케이스+로즈우드 만년필', 'test6', '2020-07-21 06:51:59'),
('2ADAB9163F63', 2, '코이버펑크 샤르도네 세미용 와인 2018', 'test4', '2020-07-21 06:42:46'),
('3F6F50ABD899', 4, '가죽 펜 케이스+로즈우드 만년필', 'test1', '2020-07-21 06:39:29'),
('4EE36C91877C', 2, '코이버펑크 샤르도네 세미용 와인 2018', 'test11', '2020-07-21 06:28:10'),
('612BCEC0FAE1', 3, '생신,환갑,칠순 케이크토퍼(매화)', 'test7', '2020-07-21 06:16:46'),
('631F102CD350', 7, '나만의 커스텀 토이 키링(s)👍', 'test16', '2020-07-21 06:06:35'),
('73A778E04508', 5, '나만의 커스텀 토이 피규어💑(m)', 'test21', '2020-07-21 05:59:03'),
('908898585ABF', 1, '강아지 고양이 생일 파티 케이프 스카프 빕 RED', 'test13', '2020-07-21 05:47:47'),
('9178BFF25694', 1, '강아지 고양이 생일 파티 케이프 스카프 빕 RED', 'test13', '2020-07-21 05:32:40'),
('93C21E06B21A', 2, '코이버펑크 샤르도네 세미용 와인 2018', 'test2', '2020-07-21 05:16:43'),
('997FFC37E857', 1, '강아지 고양이 생일 파티 케이프 스카프 빕 RED', 'test20', '2020-07-21 05:06:29'),
('9C9C8CB10434', 5, '나만의 커스텀 토이 피규어💑(m)', 'test1', '2020-07-21 04:39:49'),
('A7C2782DE137', 7, '나만의 커스텀 토이 키링(s)👍', 'test8', '2020-07-21 04:27:39'),
('AABE65E3F8B9', 4, '가죽 펜 케이스+로즈우드 만년필', 'test5', '2020-07-21 04:21:23'),
('B13F3736A58E', 6, '나만의 커스텀 토이 합격, 입학, 졸업 축하선물', 'test16', '2020-07-21 03:42:19'),
('BE5AF2620642', 6, '나만의 커스텀 토이 합격, 입학, 졸업 축하선물', 'test4', '2020-07-21 03:14:42'),
('CE54D30316BB', 6, '나만의 커스텀 토이 합격, 입학, 졸업 축하선물', 'test7', '2020-07-21 03:00:40'),
('D39C719AAB78', 3, '생신,환갑,칠순 케이크토퍼(매화)', 'test6', '2020-07-21 02:55:58'),
('D4E20A381FCD', 1, '강아지 고양이 생일 파티 케이프 스카프 빕 RED', 'test11', '2020-07-21 02:30:29'),
('DB0F1AAA71D0', 5, '나만의 커스텀 토이 피규어💑(m)', 'test3', '2020-07-21 02:15:47'),
('DD503B889D3D', 8, '💛입점할인 진행중‼️💛 황금추어탕 750g', 'test19', '2020-07-21 01:55:50'),
('E7415B955593', 7, '나만의 커스텀 토이 키링(s)👍', 'test13', '2020-07-21 01:33:29'),
('EB6B048C0B27', 5, '나만의 커스텀 토이 피규어💑(m)', 'test2', '2020-07-21 01:11:45'),
('F214DB4FB95C', 3, '생신,환갑,칠순 케이크토퍼(매화)', 'test19', '2020-07-21 00:43:42'),
('FBC2675C1CA0', 3, '생신,환갑,칠순 케이크토퍼(매화)', 'test20', '2020-07-21 00:10:19');

--
-- 덤프된 테이블의 인덱스
--

--
-- 테이블의 인덱스 `tbl_member`
--
ALTER TABLE `tbl_member`
  ADD PRIMARY KEY (`mid`);

--
-- 테이블의 인덱스 `tbl_order`
--
ALTER TABLE `tbl_order`
  ADD PRIMARY KEY (`order_id`);

--
-- 덤프된 테이블의 AUTO_INCREMENT
--

--
-- 테이블의 AUTO_INCREMENT `tbl_member`
--
ALTER TABLE `tbl_member`
  MODIFY `mid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
