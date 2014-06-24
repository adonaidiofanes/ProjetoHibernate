# Host: localhost  (Version: 5.6.17)
# Date: 2014-06-24 15:33:28
# Generator: MySQL-Front 5.3  (Build 2.28)

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE */;
/*!40101 SET SQL_MODE='NO_ENGINE_SUBSTITUTION' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES */;
/*!40103 SET SQL_NOTES='ON' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

DROP DATABASE IF EXISTS `db_sge`;
CREATE DATABASE `db_sge` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `db_sge`;

#
# Source for table "tb_alm_kit"
#

DROP TABLE IF EXISTS `tb_alm_kit`;
CREATE TABLE `tb_alm_kit` (
  `id_servico` int(11) NOT NULL,
  `cd_kit` int(11) NOT NULL,
  PRIMARY KEY (`id_servico`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Data for table "tb_alm_kit"
#

INSERT INTO `tb_alm_kit` VALUES (1,1),(2,2),(3,3);

#
# Source for table "tb_calendario"
#

DROP TABLE IF EXISTS `tb_calendario`;
CREATE TABLE `tb_calendario` (
  `Dt_inicial` datetime NOT NULL,
  `Dt_final` datetime NOT NULL,
  PRIMARY KEY (`Dt_inicial`,`Dt_final`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Data for table "tb_calendario"
#


#
# Source for table "tb_categoria"
#

DROP TABLE IF EXISTS `tb_categoria`;
CREATE TABLE `tb_categoria` (
  `Id_categoria` int(11) NOT NULL AUTO_INCREMENT,
  `Tx_categoria` char(20) DEFAULT NULL,
  `Dt_vigencia` datetime DEFAULT NULL,
  PRIMARY KEY (`Id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

#
# Data for table "tb_categoria"
#

INSERT INTO `tb_categoria` VALUES (1,'N/A',NULL),(2,'Reparo cabeamento in',NULL),(3,'Reparo cabeamento ex',NULL),(4,'Reconfiguração local',NULL),(5,'Reconfiguração remot',NULL),(6,'Causa cliente',NULL),(7,'Troca de equipamento',NULL);

#
# Source for table "tb_dados_clientes"
#

DROP TABLE IF EXISTS `tb_dados_clientes`;
CREATE TABLE `tb_dados_clientes` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `cpf` varchar(11) DEFAULT NULL,
  `cnpj` varchar(14) DEFAULT NULL,
  `nm_cliente` char(20) NOT NULL,
  `cd_email` tinytext,
  `dt_admissao` datetime DEFAULT NULL,
  `Endereco` varchar(100) DEFAULT NULL,
  `Numero` varchar(255) DEFAULT NULL,
  `Complemento` varchar(30) DEFAULT NULL,
  `Bairro` varchar(30) DEFAULT NULL,
  `Cidade` varchar(40) DEFAULT NULL,
  `UF` char(2) DEFAULT NULL,
  `Pais` varchar(40) DEFAULT NULL,
  `CEP` varchar(10) DEFAULT NULL,
  `nr_tel` decimal(14,0) DEFAULT NULL,
  `nr_celular` decimal(14,0) DEFAULT NULL,
  `nr_ident` char(20) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

#
# Data for table "tb_dados_clientes"
#

INSERT INTO `tb_dados_clientes` VALUES (1,'10000000001',NULL,'José Silva','cliente@gmail.com\n','2014-01-01 00:00:00','Rua Nogueira Acioli','100','CB 2','Jardim Guanabara','Rio de Janeiro','RJ','Brasil','21221000',34238978,98987647,'447564751'),(2,'10000000002',NULL,'Cleosvaldo Nogueira','a@a.com\t','2013-12-25 00:00:00','Avenida Rio Branco','116','Casa 1','Centro','Rio de Janeiro','RJ','Brasil','20040001',33224567,988776655,'447564332'),(3,'10000000003',NULL,'Luiza Diesel','l@l.com','2014-01-01 00:00:00','Base Aérea do Galeão',NULL,NULL,'Galeão','Rio de Janeiro','RJ','Brasil',NULL,22337766,988776655,'447564333');

#
# Source for table "tb_log"
#

DROP TABLE IF EXISTS `tb_log`;
CREATE TABLE `tb_log` (
  `Nr_matricula` int(11) NOT NULL,
  `Dt_operacao` datetime NOT NULL,
  `Tx_descricao` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Nr_matricula`,`Dt_operacao`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Data for table "tb_log"
#

INSERT INTO `tb_log` VALUES (1,'2014-04-16 15:14:48','operação de criação da O.S -6'),(1,'2014-04-16 15:15:43','operação de criação da O.S -7'),(1,'2014-04-17 00:26:11','operação de criação da O.S -8'),(1,'2014-04-17 00:46:29','operação de criação da O.S -9'),(1,'2014-04-17 00:54:34','operação de criação da O.S -10'),(1,'2014-04-17 00:55:33','operação de criação da O.S -11'),(1,'2014-04-29 19:05:34','operação de criação da O.S -12'),(1,'2014-04-29 19:54:54','operação de criação da O.S -13'),(1,'2014-04-29 20:09:54','operação de criação da O.S -14'),(1,'2014-04-30 16:09:02','operação de cancelamento do atendimento-12'),(1,'2014-04-30 16:41:13','operação de criação da O.S -15'),(1,'2014-04-30 16:41:24','operação de cancelamento do atendimento-13'),(1,'2014-04-30 19:41:38','operação de cancelamento do atendimento-13'),(1,'2014-04-30 19:43:22','operação de criação da O.S -16'),(1,'2014-04-30 21:12:22','operação de criação da O.S -17'),(1,'2014-04-30 21:12:36','operação de cancelamento do atendimento-15'),(1,'2014-05-01 23:08:47','operação de cancelamento do atendimento-11'),(1,'2014-05-01 23:10:27','operação de criação da O.S -18'),(1,'2014-05-01 23:10:57','operação de criação da O.S -19'),(1,'2014-05-01 23:11:54','operação de cancelamento do atendimento-17'),(1,'2014-05-01 23:23:22','operação de criação da O.S -20'),(1,'2014-05-01 23:23:33','operação de cancelamento do atendimento-18'),(1,'2014-05-13 20:27:31','operação de criação da O.S -21'),(1,'2014-05-13 20:27:43','operação de cancelamento do atendimento-19'),(1,'2014-05-13 20:36:15','operação de criação da O.S -22'),(1,'2014-05-13 20:38:56','operação de criação da O.S -23'),(1,'2014-05-13 20:43:16','operação de criação da O.S -24'),(1,'2014-05-22 21:08:57','operação de criação da O.S -25'),(1,'2014-05-30 11:41:48','operação de criação da O.S -26'),(1,'2014-05-30 12:00:12','operação de cancelamento do atendimento-24'),(1,'2014-05-30 14:14:35','operação de criação da O.S -28'),(1,'2014-05-30 14:33:28','operação de cancelamento do atendimento-26'),(1,'2014-05-30 14:33:29','operação de criação da O.S -29'),(1,'2014-05-30 15:57:38','operação de criação da O.S -30'),(1,'2014-06-04 14:47:06','operação de criação da O.S -31'),(1,'2014-06-04 14:53:31','operação de criação da O.S -32'),(1,'2014-06-04 14:57:14','operação de criação da O.S -33'),(1,'2014-06-24 15:15:08','operação de criação da O.S -31'),(1,'2014-06-24 15:29:17','operação de criação da O.S -32'),(1,'2014-06-24 15:32:05','operação de cancelamento do atendimento-26');

#
# Source for table "tb_login"
#

DROP TABLE IF EXISTS `tb_login`;
CREATE TABLE `tb_login` (
  `Nr_matricula` int(11) NOT NULL,
  `Cd_USUARIO` char(1) NOT NULL,
  `CD_SENHA` char(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Data for table "tb_login"
#

INSERT INTO `tb_login` VALUES (1,'A','123'),(2,'T','tec1'),(3,'C','coo1'),(4,'S','sup1'),(5,'D','ate1');

#
# Source for table "tb_rh"
#

DROP TABLE IF EXISTS `tb_rh`;
CREATE TABLE `tb_rh` (
  `nr_matricula` int(11) NOT NULL,
  `cpf` decimal(11,0) DEFAULT NULL,
  `nm_empregado` char(20) NOT NULL,
  `cd_email` tinytext,
  PRIMARY KEY (`nr_matricula`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Data for table "tb_rh"
#

INSERT INTO `tb_rh` VALUES (1,11111111110,'Empregado 1 Fictício','jose@gmail.com'),(2,11111111112,'Empregado 2 Fictício','ver@onica.com'),(3,11111111113,'Empregado 3 Fictício','em@em.com'),(4,11111111114,'Empregado 1 Fictício','a@a.com'),(5,11111111115,'Empregado 5 Fictício','fic@ticio.com');

#
# Source for table "tb_rh_disponibilidade"
#

DROP TABLE IF EXISTS `tb_rh_disponibilidade`;
CREATE TABLE `tb_rh_disponibilidade` (
  `nr_matricula` int(11) NOT NULL,
  `dt_inicio_indisp` datetime NOT NULL,
  `dt_fim_indisp` datetime NOT NULL,
  PRIMARY KEY (`nr_matricula`),
  CONSTRAINT `TB_RH_TB_RH_DISPONIBILIDADE_FK1` FOREIGN KEY (`nr_matricula`) REFERENCES `tb_rh` (`nr_matricula`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Data for table "tb_rh_disponibilidade"
#


#
# Source for table "tb_servico"
#

DROP TABLE IF EXISTS `tb_servico`;
CREATE TABLE `tb_servico` (
  `Id_servico` int(11) NOT NULL AUTO_INCREMENT,
  `Nm_servico` varchar(100) DEFAULT NULL,
  `Qt_inicio` int(11) DEFAULT NULL,
  `Qt_fim` int(11) DEFAULT NULL,
  `Qt_emp` int(11) DEFAULT NULL,
  `Dt_vigencia` datetime DEFAULT NULL COMMENT 'Data fim da validade do serviço',
  PRIMARY KEY (`Id_servico`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;

#
# Data for table "tb_servico"
#

INSERT INTO `tb_servico` VALUES (1,'Instalação Banda Larga 2M',111,240,2,'2011-01-01 00:00:11'),(2,'Instalação Banda Larga 10M',120,240,2,'2022-01-01 00:02:00'),(3,'Instalação Banda Larga 15M',120,240,5,'2020-01-01 00:00:00'),(4,'Instalação de Banda Garantida 2M',120,240,2,'2020-01-01 00:00:00'),(5,'Instalação de Banda Garantida 5M',120,240,2,'2020-01-01 00:00:00'),(6,'Instalação de Banda Garantida 10M',120,240,2,'2020-01-01 00:00:00'),(7,'Instalação de 1 linha telefônica',120,240,2,'2020-01-01 00:00:00'),(8,'Instalação de 5 linha telefônica',120,240,2,'2020-01-01 00:00:00'),(9,'Instalação de 10 linha telefônica',120,240,2,'2020-01-01 00:00:00'),(10,'Desinstalação de Banda Larga 2M',120,240,2,'2020-01-01 00:00:00'),(11,'Desinstalação de Banda Larga 10M',120,240,2,'2020-01-01 00:00:00'),(12,'Desinstalação de Banda Larga 15M',120,240,2,'2020-01-01 00:00:00'),(13,'Desinstalação de Banda Garantida 2M',120,240,2,'2020-01-01 00:00:00'),(14,'Desinstalação de Banda Garantida 5M',120,240,2,'2020-01-01 00:00:00'),(15,'Desinstalação de Banda Garantida 10M',120,240,2,'2020-01-01 00:00:00'),(16,'Desinstalação de 1 linha telefônica',120,240,2,'2020-01-01 00:00:00'),(17,'Desinstalação de 5 linha telefônica',120,240,2,'2020-01-01 00:00:00'),(18,'Desinstalação de 10 linha telefônica',120,240,2,'2020-01-01 00:00:00'),(19,'Manutenção de Banda Larga 2M',120,240,2,'2020-01-01 00:00:00'),(20,'Manutenção de Banda Larga 10M',120,240,2,'2020-01-01 00:00:00'),(21,'Manutenção de Banda Larga 15M',120,240,2,'2020-01-01 00:00:00'),(22,'Manutenção de Banda Garantida 2M',120,240,2,'2020-01-01 00:00:00'),(23,'Manutenção de Banda Garantida 5M',120,240,2,'2020-01-01 00:00:00'),(24,'Manutenção de Banda Garantida 10M',120,240,2,'2020-01-01 00:00:00'),(25,'Manutenção de 1 linha telefônica',120,240,2,'2020-01-01 00:00:00'),(26,'Manutenção de 5 linhas telefônica',120,240,2,'2020-01-01 00:00:00'),(27,'Manutenção de 10 linhas telefônica',120,240,2,'2020-01-01 00:00:00'),(30,'Nome servico Novo',1,10,10,'2014-01-01 23:59:59'),(31,'Nome servico 4',1,1,10,'2017-10-01 23:59:59'),(32,'Nome servico 3',1,1,10,'2014-01-01 23:59:59'),(33,'Nome servico 333',1,1,10,'2014-01-01 23:59:59'),(34,'Nome servico 333',1,1,10,'2014-01-25 23:59:59'),(38,'Instalação Banda Larga 2M',1,1,1,'2010-10-10 10:10:10'),(39,'Manutenção de 10 linhas telefônica',1,1,1,'2011-11-11 11:11:11'),(40,'Instalação',11,11,11,'2011-11-11 11:11:11'),(41,'Instalação',120,123,111,'2010-10-10 01:01:00'),(42,'Instalação',10,10,10,'2010-10-10 10:10:10'),(43,'Instalação',1,1,11,'2011-11-11 11:11:11'),(44,'Instalação',1,1,1,'2011-11-11 11:11:11'),(45,'Instalação',1,1,1,'2011-11-11 11:11:11'),(46,'Instalação',11,11,11,'1111-11-11 11:11:11'),(47,'Instalação',120,11,11,'1111-11-11 11:11:11'),(48,'teste',15,15,2,'2014-09-10 12:00:00'),(50,'teste jorlina 02',3,6,3,'2014-06-13 19:08:00');

#
# Source for table "tb_os"
#

DROP TABLE IF EXISTS `tb_os`;
CREATE TABLE `tb_os` (
  `Id_OS` int(11) NOT NULL AUTO_INCREMENT,
  `Id_servico` int(11) NOT NULL,
  `Dt_geracao` datetime DEFAULT NULL,
  `Id_cliente` int(11) DEFAULT NULL,
  `Tx_detalhe` text,
  `Cd_kit` char(3) DEFAULT NULL,
  `Cd_status` char(1) DEFAULT NULL COMMENT 'A - Aberta R ? Reagendada P ? Pendente C ? Cancelada T - Atendida F - Finalizada',
  `Dt_fim` datetime DEFAULT NULL COMMENT 'Data de finaliza??o da O.S',
  PRIMARY KEY (`Id_OS`),
  KEY `IDX_TB_OS` (`Id_servico`),
  CONSTRAINT `TB_SERVICO_TB_OS_FK1` FOREIGN KEY (`Id_servico`) REFERENCES `tb_servico` (`Id_servico`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

#
# Data for table "tb_os"
#

INSERT INTO `tb_os` VALUES (1,1,'2014-03-23 00:00:00',1,'O cliente est? solicitando um novo servi?o!','1','S',NULL),(2,2,'2014-03-24 00:00:00',2,'Outro detalhe!','2','S',NULL),(3,1,'2014-03-23 00:00:00',3,'Algumas informa??es!','1','S',NULL),(4,1,'2014-04-16 15:14:48',1,'dasdasdasdsadasdsadasdas','1','C',NULL),(5,1,'2014-04-16 15:15:43',1,'sdasdasdasdadasdsa','1','F','2014-05-01 23:23:33'),(6,1,'2014-04-17 00:26:11',1,'teste','1','C',NULL),(7,1,'2014-04-17 00:46:29',1,'sadadas','1','C',NULL),(8,1,'2014-04-17 00:54:34',1,'teste 123','1','C',NULL),(9,1,'2014-04-17 00:55:32',1,'testeste','1','C',NULL),(10,1,'2014-04-29 19:05:34',1,'teste 123','1','C',NULL),(11,1,'2014-04-29 19:54:54',1,'dasdsadsa','1','X',NULL),(12,1,'2014-04-29 20:09:54',1,'Teste','1','X',NULL),(13,1,'2014-04-30 16:41:13',2,'TEste teste','1','X',NULL),(14,2,'2014-04-30 19:43:22',2,'Instalacao requer  qndqime.','2','C',NULL),(15,1,'2014-04-30 21:12:22',1,'Vamos','1','F','2014-05-01 23:23:33'),(16,1,'2014-05-01 23:10:27',1,'TESTE','1','C',NULL),(17,1,'2014-05-01 23:10:57',1,'teste','1','X','2014-05-01 23:23:33'),(18,1,'2014-05-01 23:23:22',1,'dasdasda','1','X','2014-05-01 23:23:33'),(19,1,'2014-05-13 20:27:31',1,'TESTE','1','X','2014-05-13 20:27:42'),(20,1,'2014-05-13 20:36:15',1,'TESTE','1','S',NULL),(21,1,'2014-05-13 20:38:56',1,'teste2','1','F','2014-05-13 20:27:42'),(22,1,'2014-05-13 20:43:16',1,'123','1','X','2014-05-13 20:27:42'),(23,1,'2014-05-22 21:08:57',1,'Testezinho','1','C',NULL),(24,1,'2014-05-30 11:41:48',2,'123','1','X','2014-05-30 12:00:12'),(25,1,'2014-05-30 14:14:35',2,'teste','1','X','2014-05-30 14:33:28'),(26,1,'2014-05-30 14:33:29',2,'teste1','1','F',NULL),(27,1,'2014-05-30 15:57:38',1,'123','1','C',NULL),(31,1,'2014-06-24 15:15:08',2,'111111','1','C',NULL),(32,1,'2014-06-24 15:29:17',2,'111111','1','X','2014-06-24 15:32:05');

#
# Source for table "tb_janela"
#

DROP TABLE IF EXISTS `tb_janela`;
CREATE TABLE `tb_janela` (
  `Id_janela` int(11) NOT NULL AUTO_INCREMENT,
  `Id_servico` int(11) NOT NULL,
  `Hr_inicial` time NOT NULL DEFAULT '00:00:00',
  `Hr_final` time NOT NULL DEFAULT '00:00:00',
  `Dt_vig_fim` datetime DEFAULT NULL,
  `Dt_vig_ini` datetime NOT NULL,
  PRIMARY KEY (`Id_janela`),
  KEY `TB_SERVICO_TB_JANELA_FK1` (`Id_servico`),
  CONSTRAINT `TB_SERVICO_TB_JANELA_FK1` FOREIGN KEY (`Id_servico`) REFERENCES `tb_servico` (`Id_servico`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

#
# Data for table "tb_janela"
#

INSERT INTO `tb_janela` VALUES (1,1,'09:00:00','10:00:00','2014-03-01 00:00:00','2014-12-30 00:00:00'),(2,2,'09:00:00','10:00:00','2014-03-01 00:00:00','2014-12-30 00:00:00'),(3,1,'11:00:00','12:00:00','2014-03-01 00:00:00','2014-12-30 00:00:00'),(4,1,'14:00:00','15:00:00','2014-03-01 00:00:00','2014-12-30 00:00:00'),(5,1,'16:00:00','17:00:00','2014-03-01 00:00:00','2014-12-30 00:00:00'),(6,1,'17:00:00','18:00:00','2014-03-01 00:00:00','2014-12-30 00:00:00'),(7,2,'11:00:00','12:00:00','2014-03-01 00:00:00','2014-12-30 00:00:00'),(8,2,'14:00:00','15:00:00','2014-03-01 00:00:00','2014-12-30 00:00:00'),(9,2,'16:00:00','17:00:00','2014-03-01 00:00:00','2014-12-30 00:00:00'),(10,2,'17:00:00','18:00:00','2014-03-01 00:00:00','2014-12-30 00:00:00');

#
# Source for table "tb_dias"
#

DROP TABLE IF EXISTS `tb_dias`;
CREATE TABLE `tb_dias` (
  `Id_janela` int(11) NOT NULL,
  `Cd_dia` int(11) NOT NULL,
  `cd_semana` int(11) NOT NULL,
  PRIMARY KEY (`Id_janela`,`Cd_dia`,`cd_semana`),
  CONSTRAINT `TB_JANELA_TB_DIAS_FK1` FOREIGN KEY (`Id_janela`) REFERENCES `tb_janela` (`Id_janela`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Data for table "tb_dias"
#

INSERT INTO `tb_dias` VALUES (1,2,0),(1,2,7),(1,2,14),(1,2,21),(1,2,28),(1,3,0),(1,3,7),(1,3,14),(1,3,21),(1,3,28),(1,5,19),(2,2,0),(2,2,7),(2,2,14),(2,2,21),(2,2,28),(2,3,0),(2,3,7),(2,3,14),(2,3,21),(2,3,28),(2,5,0),(2,5,7),(2,5,14),(2,5,21),(2,5,28),(3,4,0),(3,4,7),(3,4,14),(3,4,21),(3,4,28),(3,7,0),(3,7,7),(3,7,14),(3,7,21),(3,7,28),(5,4,0),(5,4,7),(5,4,14),(5,4,21),(5,4,28),(5,7,0),(5,7,7),(5,7,14),(5,7,21),(5,7,28),(9,7,0),(9,7,7),(9,7,14),(9,7,21),(9,7,28),(10,7,0),(10,7,7),(10,7,14),(10,7,21),(10,7,28);

#
# Source for table "tb_equipe"
#

DROP TABLE IF EXISTS `tb_equipe`;
CREATE TABLE `tb_equipe` (
  `Id_equipe` int(11) NOT NULL AUTO_INCREMENT,
  `Id_servico` int(11) NOT NULL,
  `Nr_matricula` int(11) NOT NULL,
  `Nr_smarthfone` int(11) NOT NULL,
  `Nr_cep_inicial` int(11) NOT NULL,
  `Nr_cep_final` int(11) NOT NULL,
  PRIMARY KEY (`Id_equipe`),
  KEY `TB_SERVICO_TB_EQUIPE_FK1` (`Id_servico`),
  KEY `IDX_TB_EQUIPE` (`Nr_matricula`),
  CONSTRAINT `TB_SERVICO_TB_EQUIPE_FK1` FOREIGN KEY (`Id_servico`) REFERENCES `tb_servico` (`Id_servico`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

#
# Data for table "tb_equipe"
#

INSERT INTO `tb_equipe` VALUES (1,1,1,99998877,21221000,21221999),(2,2,2,88776655,27343000,27343999);

#
# Source for table "tb_agenda"
#

DROP TABLE IF EXISTS `tb_agenda`;
CREATE TABLE `tb_agenda` (
  `Id_janela` int(11) NOT NULL,
  `Id_equipe` int(11) NOT NULL,
  `Dt_criacao` datetime NOT NULL,
  `Dt_fim` datetime DEFAULT NULL,
  PRIMARY KEY (`Id_janela`,`Id_equipe`),
  KEY `TB_EQUIPE_TB_AGENDA_FK1` (`Id_equipe`),
  CONSTRAINT `TB_EQUIPE_TB_AGENDA_FK1` FOREIGN KEY (`Id_equipe`) REFERENCES `tb_equipe` (`Id_equipe`),
  CONSTRAINT `TB_JANELA_TB_AGENDA_FK1` FOREIGN KEY (`Id_janela`) REFERENCES `tb_janela` (`Id_janela`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Data for table "tb_agenda"
#

INSERT INTO `tb_agenda` VALUES (1,1,'2014-03-26 00:00:00','2014-03-30 00:00:00'),(2,2,'2014-03-26 00:00:00','2014-03-30 00:00:00'),(3,1,'2014-03-26 00:00:00','2014-03-30 00:00:00'),(4,1,'2014-03-26 00:00:00','2014-03-30 00:00:00'),(5,1,'2014-03-26 00:00:00','2014-03-30 00:00:00'),(6,1,'2014-03-26 00:00:00','2014-03-30 00:00:00'),(7,2,'2014-03-26 00:00:00','2014-03-30 00:00:00'),(8,2,'2014-03-26 00:00:00','2014-03-30 00:00:00'),(9,2,'2014-03-26 00:00:00','2014-03-30 00:00:00'),(10,2,'2014-03-26 00:00:00','2014-03-30 00:00:00');

#
# Source for table "tb_atendimento"
#

DROP TABLE IF EXISTS `tb_atendimento`;
CREATE TABLE `tb_atendimento` (
  `Id_atendimento` int(11) NOT NULL AUTO_INCREMENT,
  `Id_OS` int(11) NOT NULL,
  `Dt_agendamento` datetime NOT NULL,
  `Nr_matricula` int(11) NOT NULL,
  `Cd_status` char(1) NOT NULL,
  `Id_janela` int(11) NOT NULL,
  `Id_equipe` int(11) NOT NULL,
  `Id_categoria` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id_atendimento`),
  KEY `TB_OS_TB_ATENDIMENTO_FK1` (`Id_OS`),
  KEY `TB_CATEGORIA_TB_ATENDIMENTO_FK1` (`Id_categoria`),
  KEY `TB_AGENDA_TB_ATENDIMENTO_FK1` (`Id_janela`,`Id_equipe`),
  CONSTRAINT `TB_AGENDA_TB_ATENDIMENTO_FK1` FOREIGN KEY (`Id_janela`, `Id_equipe`) REFERENCES `tb_agenda` (`Id_janela`, `Id_equipe`),
  CONSTRAINT `TB_CATEGORIA_TB_ATENDIMENTO_FK1` FOREIGN KEY (`Id_categoria`) REFERENCES `tb_categoria` (`Id_categoria`),
  CONSTRAINT `TB_OS_TB_ATENDIMENTO_FK1` FOREIGN KEY (`Id_OS`) REFERENCES `tb_os` (`Id_OS`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

#
# Data for table "tb_atendimento"
#

INSERT INTO `tb_atendimento` VALUES (1,1,'2014-04-01 09:00:00',1,'A',1,1,1),(2,2,'2014-04-02 09:00:00',2,'A',2,2,1),(3,3,'2014-04-03 10:00:00',1,'A',1,1,1),(4,6,'2014-04-16 15:14:48',1,'A',3,1,1),(5,7,'2014-04-16 15:15:43',1,'A',3,1,1),(6,8,'2014-04-17 00:26:11',1,'A',1,1,1),(7,9,'2014-04-18 09:00:00',1,'A',1,1,1),(8,10,'2014-04-15 09:00:00',1,'A',1,1,1),(9,11,'2014-04-19 16:00:00',1,'A',5,1,1),(10,12,'2014-04-28 09:00:00',1,'A',1,1,1),(11,13,'2014-04-29 09:00:00',1,'C',1,1,1),(12,14,'2014-04-30 11:00:00',1,'C',3,1,1),(13,15,'2014-04-30 16:00:00',1,'C',5,1,1),(14,16,'2014-04-28 09:00:00',2,'P',2,2,1),(15,17,'2014-04-30 11:00:00',1,'C',3,1,1),(16,18,'2014-04-30 11:00:00',1,'A',3,1,1),(17,19,'2014-05-03 11:00:00',1,'C',3,1,1),(18,20,'2014-05-03 11:00:00',1,'C',3,1,1),(19,21,'2014-05-13 09:00:00',1,'C',1,1,1),(20,22,'2014-05-14 11:00:00',1,'P',3,1,1),(21,23,'2014-05-14 16:00:00',1,'E',5,1,1),(22,24,'2014-05-20 09:00:00',1,'R',1,1,1),(23,25,'2014-05-26 09:00:00',1,'A',1,1,1),(24,26,'2014-05-31 11:00:00',1,'P',3,1,2),(25,31,'2014-06-24 09:00:00',1,'R',1,1,1),(26,32,'2014-06-25 11:00:00',1,'C',3,1,1);

#
# Source for table "tb_reporte"
#

DROP TABLE IF EXISTS `tb_reporte`;
CREATE TABLE `tb_reporte` (
  `Id_atendimento` int(11) NOT NULL,
  `Cd_status` char(1) NOT NULL,
  `Dt_reporte` datetime NOT NULL,
  `Cd_pendencia` char(1) DEFAULT NULL,
  `Tx_longitude` char(8) DEFAULT NULL,
  `Tx_latitude` char(8) DEFAULT NULL,
  `Nr_matricula` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id_atendimento`,`Cd_status`,`Dt_reporte`),
  CONSTRAINT `TB_ATENDIMENTO_TB_REPORTE_FK1` FOREIGN KEY (`Id_atendimento`) REFERENCES `tb_atendimento` (`Id_atendimento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Data for table "tb_reporte"
#

INSERT INTO `tb_reporte` VALUES (1,'c','2014-03-23 00:00:00',NULL,'-43.1767','-22.9334',1),(2,'p','2014-03-24 00:00:00',NULL,'-43.1788','-22.9020',2),(3,'c','2014-03-23 00:00:00',NULL,'-43.3588','-22.9610',1);

#
# Source for table "tb_bloqueio"
#

DROP TABLE IF EXISTS `tb_bloqueio`;
CREATE TABLE `tb_bloqueio` (
  `Id_equipe` int(11) NOT NULL,
  `Dt_inicio` datetime NOT NULL,
  `Dt_fim` datetime NOT NULL,
  PRIMARY KEY (`Id_equipe`,`Dt_inicio`,`Dt_fim`),
  CONSTRAINT `TB_EQUIPE_TB_BLOQUEIO_FK1` FOREIGN KEY (`Id_equipe`) REFERENCES `tb_equipe` (`Id_equipe`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Data for table "tb_bloqueio"
#


#
# Source for table "tb_tec_auxiliares"
#

DROP TABLE IF EXISTS `tb_tec_auxiliares`;
CREATE TABLE `tb_tec_auxiliares` (
  `Id_equipe` int(11) NOT NULL,
  `Nr_matricula` int(11) NOT NULL,
  PRIMARY KEY (`Id_equipe`,`Nr_matricula`),
  CONSTRAINT `TB_EQUIPE_TB_TECNICOS_AUXILIARES_FK1` FOREIGN KEY (`Id_equipe`) REFERENCES `tb_equipe` (`Id_equipe`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Data for table "tb_tec_auxiliares"
#

INSERT INTO `tb_tec_auxiliares` VALUES (1,1),(1,2),(2,1),(2,2);

#
# Source for table "tb_usuario"
#

DROP TABLE IF EXISTS `tb_usuario`;
CREATE TABLE `tb_usuario` (
  `nr_matricula` int(11) NOT NULL,
  `cd_usuario` char(1) NOT NULL DEFAULT '' COMMENT 'A - Administrador S – supervisor T – Técnico C – Coordenador D - Atendente',
  PRIMARY KEY (`nr_matricula`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Data for table "tb_usuario"
#

INSERT INTO `tb_usuario` VALUES (1,'A'),(2,'S'),(3,'C'),(4,'D'),(5,'T'),(6,'T'),(7,'T'),(8,'T'),(9,'T'),(10,'T'),(11,'T');

#
# Source for view "vw_agenda_com_agendamento"
#

DROP VIEW IF EXISTS `vw_agenda_com_agendamento`;
CREATE VIEW `vw_agenda_com_agendamento` AS 
  SELECT
    `j`.`Id_servico` AS `id_servico`,
    `a`.`Id_janela` AS `id_janela`,
    `a`.`Id_equipe` AS `id_equipe`,
    `j`.`Hr_inicial`,
    `j`.`Hr_final`,
    IF(Isnull(`at`.`Id_atendimento`), 0, `at`.`Id_atendimento`) AS `id_atendimento`,
    IF(Isnull(`at`.`Dt_agendamento`), 0, `at`.`Dt_agendamento`) AS `data`,
    `e`.`Nr_matricula` AS `NrMatriculaTecnico`,
    `o`.`Id_OS`,
    `at`.`Cd_status` AS `cd_status`
  FROM
    ((((`tb_agenda` `a`
        JOIN `tb_janela` `j`
          ON((`a`.`Id_janela` = `j`.`Id_janela`)))
       JOIN `tb_atendimento` `at`
         ON(((`at`.`Id_janela` = `a`.`Id_janela`)
             AND (`at`.`Id_equipe` = `a`.`Id_equipe`))))
      JOIN `tb_equipe` `e`
        ON((`a`.`Id_equipe` = `e`.`Id_equipe`)))
     JOIN `tb_os` `o`
       ON((`o`.`Id_OS` = `at`.`Id_OS`)));

#
# Source for view "vw_agenda_sem_agendamento"
#

DROP VIEW IF EXISTS `vw_agenda_sem_agendamento`;
CREATE VIEW `vw_agenda_sem_agendamento` AS 
  SELECT
    `j`.`Id_servico` AS `id_servico`,
    `a`.`Id_janela` AS `id_janela`,
    `a`.`Id_equipe` AS `id_equipe`,
    `j`.`Hr_inicial`,
    `j`.`Hr_final`,
    `d`.`Cd_dia` AS `cd_dia`,
    `d`.`cd_semana`,
    Str_to_date((Curdate() + ((`d`.`Cd_dia` - Dayofweek(Curdate())) + `d`.`cd_semana`)), '%Y%m%d') AS `ano_mes_dia`,
    `e`.`Nr_matricula` AS `NrMatriculaTecnico`
  FROM
    (((`tb_agenda` `a`
       JOIN `tb_janela` `j`
         ON((`a`.`Id_janela` = `j`.`Id_janela`)))
      JOIN `tb_dias` `d`
        ON((`j`.`Id_janela` = `d`.`Id_janela`)))
     JOIN `tb_equipe` `e`
       ON((`a`.`Id_equipe` = `e`.`Id_equipe`)))
  WHERE
    ((NOT(Concat(`j`.`Id_servico`, `a`.`Id_janela`, `a`.`Id_equipe`, `j`.`Hr_inicial`, `j`.`Hr_final`, Str_to_date((Curdate() + ((`d`.`Cd_dia` - Dayofweek(Curdate())) + `d`.`cd_semana`)), '%Y%m%d')) IN (SELECT
                                                                                                                                                                                                             Concat(`j`.`Id_servico`, `a`.`Id_janela`, `a`.`Id_equipe`, `j`.`Hr_inicial`, `j`.`Hr_final`, IF(Isnull(`ate`.`Dt_agendamento`), 0, Cast(`ate`.`Dt_agendamento` AS date))) AS `teste`
                                                                                                                                                                                                           FROM
                                                                                                                                                                                                             ((`tb_agenda` `a`
                                                                                                                                                                                                               JOIN `tb_janela` `j`
                                                                                                                                                                                                                 ON((`a`.`Id_janela` = `j`.`Id_janela`)))
                                                                                                                                                                                                              JOIN `tb_atendimento` `ate`
                                                                                                                                                                                                                ON(((`ate`.`Id_janela` = `a`.`Id_janela`)
                                                                                                                                                                                                                    AND (`ate`.`Id_equipe` = `a`.`Id_equipe`)
                                                                                                                                                                                                                    AND (`ate`.`Cd_status` <> 'C')))))))
     AND (Str_to_date((Curdate() + ((`d`.`Cd_dia` - Dayofweek(Curdate())) + `d`.`cd_semana`)), '%Y%m%d') IS NOT NULL)
     AND (Dayofmonth(Str_to_date((Curdate() + ((`d`.`Cd_dia` - Dayofweek(Curdate())) + `d`.`cd_semana`)), '%Y%m%d')) > 0)
     AND (Str_to_date((Curdate() + ((`d`.`Cd_dia` - Dayofweek(Curdate())) + `d`.`cd_semana`)), '%Y%m%d') >= Curdate())
     AND ((Curdate() + ((`d`.`Cd_dia` - Dayofweek(Curdate())) + `d`.`cd_semana`)) <= Last_day(Sysdate())))
  UNION
  SELECT
    `j`.`Id_servico` AS `id_servico`,
    `a`.`Id_janela` AS `id_janela`,
    `a`.`Id_equipe` AS `id_equipe`,
    `j`.`Hr_inicial`,
    `j`.`Hr_final`,
    `d`.`Cd_dia` AS `cd_dia`,
    `d`.`cd_semana`,
    Str_to_date(((Last_day(Sysdate()) + INTERVAL 1 day) + ((`d`.`Cd_dia` - Dayofweek((Last_day(Sysdate()) + INTERVAL 1 day))) + `d`.`cd_semana`)), '%Y%m%d') AS `ano_mes_dia`,
    `e`.`Nr_matricula` AS `NrMatriculaTecnico`
  FROM
    (((`tb_agenda` `a`
       JOIN `tb_janela` `j`
         ON((`a`.`Id_janela` = `j`.`Id_janela`)))
      JOIN `tb_dias` `d`
        ON((`j`.`Id_janela` = `d`.`Id_janela`)))
     JOIN `tb_equipe` `e`
       ON((`a`.`Id_equipe` = `e`.`Id_equipe`)))
  WHERE
    ((NOT(Concat(`j`.`Id_servico`, `a`.`Id_janela`, `a`.`Id_equipe`, `j`.`Hr_inicial`, `j`.`Hr_final`, Str_to_date(((Last_day(Sysdate()) + INTERVAL 1 day) + ((`d`.`Cd_dia` - Dayofweek((Last_day(Sysdate()) + INTERVAL 1 day))) + `d`.`cd_semana`)), '%Y%m%d')) IN (SELECT
                                                                                                                                                                                                                                                                       Concat(`j`.`Id_servico`, `a`.`Id_janela`, `a`.`Id_equipe`, `j`.`Hr_inicial`, `j`.`Hr_final`, IF(Isnull(`ate`.`Dt_agendamento`), 0, Cast(`ate`.`Dt_agendamento` AS date))) AS `teste`
                                                                                                                                                                                                                                                                     FROM
                                                                                                                                                                                                                                                                       ((`tb_agenda` `a`
                                                                                                                                                                                                                                                                         JOIN `tb_janela` `j`
                                                                                                                                                                                                                                                                           ON((`a`.`Id_janela` = `j`.`Id_janela`)))
                                                                                                                                                                                                                                                                        JOIN `tb_atendimento` `ate`
                                                                                                                                                                                                                                                                          ON(((`ate`.`Id_janela` = `a`.`Id_janela`)
                                                                                                                                                                                                                                                                              AND (`ate`.`Id_equipe` = `a`.`Id_equipe`)
                                                                                                                                                                                                                                                                              AND (`ate`.`Cd_status` <> 'C')))))))
     AND (Str_to_date(((Last_day(Sysdate()) + INTERVAL 1 day) + ((`d`.`Cd_dia` - Dayofweek((Last_day(Sysdate()) + INTERVAL 1 day))) + `d`.`cd_semana`)), '%Y%m%d') IS NOT NULL)
     AND (Dayofmonth(Str_to_date(((Last_day(Sysdate()) + INTERVAL 1 day) + ((`d`.`Cd_dia` - Dayofweek((Last_day(Sysdate()) + INTERVAL 1 day))) + `d`.`cd_semana`)), '%Y%m%d')) > 0)
     AND (Str_to_date(((Last_day(Sysdate()) + INTERVAL 1 day) + ((`d`.`Cd_dia` - Dayofweek((Last_day(Sysdate()) + INTERVAL 1 day))) + `d`.`cd_semana`)), '%Y%m%d') >= Last_day(Sysdate()))
     AND (((Last_day(Sysdate()) + INTERVAL 1 day) + ((`d`.`Cd_dia` - Dayofweek((Last_day(Sysdate()) + INTERVAL 1 day))) + `d`.`cd_semana`)) <= (Last_day(Sysdate()) + INTERVAL 30 day)))
  ORDER BY
    `ano_mes_dia`,
    `Hr_inicial`;

#
# Source for view "vw_almoxarife"
#

DROP VIEW IF EXISTS `vw_almoxarife`;
CREATE VIEW `vw_almoxarife` AS 
  SELECT
    `id_servico` AS `ID_SERVICO`,
    `cd_kit` AS `CD_KIT`
  FROM
    `tb_alm_kit`;

#
# Source for view "vw_dados_clientes"
#

DROP VIEW IF EXISTS `vw_dados_clientes`;
CREATE VIEW `vw_dados_clientes` AS 
  SELECT
    `id_cliente`,
    `cpf` AS `CPF`,
    `cnpj` AS `CNPJ`,
    `nm_cliente` AS `NM_CLIENTE`,
    `cd_email` AS `CD_EMAIL`,
    `Endereco` AS `ENDERECO`,
    `Complemento` AS `COMPLEMENTO`,
    `Numero` AS `NUMERO`,
    `Bairro` AS `BAIRRO`,
    `Cidade` AS `CIDADE`,
    `UF`,
    `CEP`,
    `nr_tel` AS `NR_TEL`,
    `nr_celular` AS `NR_CELULAR`,
    `nr_ident` AS `NR_IDENT`
  FROM
    `tb_dados_clientes`;

#
# Source for view "vw_dados_rh"
#

DROP VIEW IF EXISTS `vw_dados_rh`;
CREATE VIEW `vw_dados_rh` AS 
  SELECT
    `r`.`nr_matricula` AS `NR_MATRICULA`,
    `r`.`nm_empregado` AS `NM_EMPREGADO`,
    `d`.`dt_inicio_indisp`,
    `d`.`dt_fim_indisp`
  FROM
    (`tb_rh` `r`
     LEFT JOIN `tb_rh_disponibilidade` `d`
            ON((`r`.`nr_matricula` = `d`.`nr_matricula`)));

#
# Source for procedure "pr_del_agendamento"
#

DROP PROCEDURE IF EXISTS `pr_del_agendamento`;
CREATE PROCEDURE `pr_del_agendamento`(
        IN  p_id_os                           INT(2), 
        IN  p_id_atendimento                  INT(2), 
        IN  p_nr_matricula_usuario            INT (11) 

     )
BEGIN 
          

    UPDATE tb_os 
         set cd_status = 'X', dt_fim = NOW()
        where id_os = p_id_os;


    UPDATE TB_ATENDIMENTO 
         set cd_status = 'C'
        where id_atendimento = p_id_atendimento;

              
                                 
    INSERT INTO TB_LOG VALUES ( p_nr_matricula_usuario,
                             sysdate(), 
                             concat('operação de cancelamento do atendimento', '-' , p_id_atendimento)); 
                             
                                 
END;

#
# Source for procedure "pr_ins_agendamento"
#

DROP PROCEDURE IF EXISTS `pr_ins_agendamento`;
CREATE PROCEDURE `pr_ins_agendamento`(
        IN  p_id_servico                      INT(2), 
        IN  p_id_categoria                    INT(2), 
        IN  p_id_cliente                      INT(11), 
        IN  p_tx_detalhe                      TEXT(500),
        IN  p_nr_matricula_tecnico            INT (11),
        IN  p_nr_matricula_usuario            INT (11),
        IN  p_id_janela                       INT (2),
        IN  p_id_equipe                       INT (2),
        IN  p_dt_agendamento                  VARCHAR(19)
     )
BEGIN 
          
    INSERT INTO tb_os 
         values (0,
                 p_id_servico,
                 sysdate(),
                 p_id_cliente,
                 p_tx_detalhe,
                 (select cd_kit from vw_almoxarife a WHERE a.id_servico = p_id_servico),
                 'C',
                 null);
       
                 
    INSERT INTO TB_ATENDIMENTO VALUES (0,
                            (select max(id_os) from tb_os),
                             p_dt_agendamento, 
                             p_nr_matricula_tecnico, 
                             'A', 
                             p_id_janela, 
                             p_id_equipe,
							 p_id_categoria); 
                             
    INSERT INTO TB_LOG VALUES ( p_nr_matricula_usuario,
                             sysdate(), 
                             concat('operação de criação da O.S ', '-' , (select max(id_os) from tb_os))); 
                             
                                 
END;

/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
