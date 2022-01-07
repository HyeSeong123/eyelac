-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.6.5-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- test1 데이터베이스 구조 내보내기
DROP DATABASE IF EXISTS `test1`;
CREATE DATABASE IF NOT EXISTS `test1` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `test1`;

-- 테이블 test1.board 구조 내보내기
DROP TABLE IF EXISTS `board`;
CREATE TABLE IF NOT EXISTS `board` (
  `num` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `boardName` char(20) NOT NULL,
  `boardCode` char(20) NOT NULL,
  `depth` int(3) unsigned NOT NULL DEFAULT 1,
  `parentCode` char(20) DEFAULT NULL,
  `boardUrl` varchar(200) NOT NULL,
  `menuOrder` int(3) NOT NULL DEFAULT 1,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- 테이블 데이터 test1.board:~8 rows (대략적) 내보내기
DELETE FROM `board`;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` (`num`, `regDate`, `updateDate`, `boardName`, `boardCode`, `depth`, `parentCode`, `boardUrl`, `menuOrder`) VALUES
	(1, '2021-12-07 16:58:39', '2021-12-07 16:58:41', '소개', 'about', 1, NULL, 'javascript:smooth_scroll(\'main_section2\')', 2),
	(2, '2021-12-07 17:00:03', '2021-12-07 17:00:04', '안내', 'service', 1, NULL, '/service.do', 3),
	(3, '2021-12-07 17:00:03', '2021-12-07 17:00:04', '갤러리', 'gallary', 1, NULL, 'javascript:smooth_scroll(\'main_section4\')', 4),
	(4, '2021-12-07 17:00:03', '2021-12-07 17:00:03', '문의', 'contact', 1, NULL, '/contact.do', 5),
	(5, '2021-12-07 17:00:03', '2021-12-07 17:00:03', '게시판', 'board', 1, NULL, '/notice.do', 6),
	(7, '2021-12-14 18:21:46', '2021-12-14 18:21:48', '공지사항', 'notice', 2, 'board', '/notice.do', 1),
	(8, '2021-12-14 18:22:08', '2021-12-14 18:22:10', '리뷰', 'review', 2, 'board', '/review.do', 2),
	(9, '2021-12-14 18:22:08', '2021-12-14 18:22:08', '이벤트', 'event', 2, 'board', '/event.do', 3);
/*!40000 ALTER TABLE `board` ENABLE KEYS */;

-- 테이블 test1.member 구조 내보내기
DROP TABLE IF EXISTS `member`;
CREATE TABLE IF NOT EXISTS `member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `memberName` char(15) NOT NULL,
  `memberId` char(20) NOT NULL,
  `memberPw` varchar(200) NOT NULL,
  `memberBirth` datetime DEFAULT NULL,
  `memberPostcode` char(20) NOT NULL,
  `memberAddress` char(100) NOT NULL,
  `memberNickname` char(20) DEFAULT NULL,
  `memberEmail` varchar(40) NOT NULL,
  `memberPhNum` char(20) NOT NULL,
  `memberLevel` int(1) unsigned NOT NULL DEFAULT 1,
  `mailAgree` char(10) NOT NULL DEFAULT 'N',
  `emailAgree` char(10) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  UNIQUE KEY `member_id` (`memberId`) USING BTREE,
  UNIQUE KEY `member_nickname` (`memberNickname`) USING BTREE,
  KEY `member_index` (`memberName`,`memberId`,`memberNickname`,`memberLevel`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- 테이블 데이터 test1.member:~0 rows (대략적) 내보내기
DELETE FROM `member`;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` (`id`, `regDate`, `updateDate`, `memberName`, `memberId`, `memberPw`, `memberBirth`, `memberPostcode`, `memberAddress`, `memberNickname`, `memberEmail`, `memberPhNum`, `memberLevel`, `mailAgree`, `emailAgree`) VALUES
	(1, '2021-12-29 15:00:12', '2021-12-29 15:00:12', '방혜성', 'baobab612', '$2a$10$r/JqvOOva1oAKcCja/fQMu9foKrfpHOZh4yxtRn6Yx/Vz45NrwqJG', '2021-12-07 00:00:00', '34677', '대전 동구 옥천로180번길 47-2', NULL, 'banggu1997@naver.com', '01083700420', 1, 'N', 'N');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
