-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tempo de Geração: 25/07/2014 às 09h26min
-- Versão do Servidor: 5.5.34
-- Versão do PHP: 5.3.10-1ubuntu3.9

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Banco de Dados: `db_sge`
--

DELIMITER $$
--
-- Procedimentos
--
DROP PROCEDURE IF EXISTS `pr_del_agendamento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pr_del_agendamento`(
        IN  p_id_os                           INT(2), 
        IN  p_id_atendimento                  INT(2), 
        IN  p_nr_matricula_usuario            INT (11) 

     )
BEGIN 
          

    UPDATE tb_os 
         set cd_status = 'X', dt_fim = NOW()
        where id_os = p_id_os;


    UPDATE tb_atendimento  
         set cd_status = 'C'
        where id_atendimento = p_id_atendimento;

              
                                 
    INSERT INTO tb_log VALUES ( p_nr_matricula_usuario,
                             sysdate(), 
                             concat('operacao de cancelamento do atendimento', '-' , p_id_atendimento)); 
                             
                                 
END$$

DROP PROCEDURE IF EXISTS `pr_ins_agendamento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pr_ins_agendamento`(
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
       
                 
    INSERT INTO tb_atendimento VALUES (0,
                            (select max(id_os) from tb_os),
                             p_dt_agendamento, 
                             p_nr_matricula_tecnico, 
                             'A', 
                             p_id_janela, 
                             p_id_equipe,
							 p_id_categoria); 
                             
    INSERT INTO tb_log VALUES ( p_nr_matricula_usuario,
                             sysdate(), 
                             concat('operaзгo de criaзгo da O.S ', '-' , (select max(id_os) from tb_os))); 
                             
                                 
END$$

DROP PROCEDURE IF EXISTS `pr_ins_reporte`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pr_ins_reporte`(
        IN  p_id_atendimento                  INT(2), 
        IN  p_Cd_status                       CHAR(1),
        IN  p_Dt_reporte                      DATETIME, 
        IN  p_Cd_pendencia                    CHAR(1),
        IN  p_Tx_longitude                    CHAR(8),
        IN  p_Tx_latitude                     CHAR(8),
        IN  p_nr_matricula_usuario            INT (11),
		   OUT p_return_code tinyint unsigned
     )
BEGIN 

  DECLARE exit handler for sqlexception
  BEGIN
    
    set p_return_code = 1;
    rollback;
  END;

  DECLARE exit handler for sqlwarning
  BEGIN
    
    set p_return_code = 2;
    rollback;
  END;
          
START TRANSACTION;

    INSERT INTO tb_reporte
         VALUES ( p_id_atendimento,
                  p_Cd_status, 
                  p_Dt_reporte, 
                  p_Cd_pendencia, 
                  p_Tx_longitude,
                  p_Tx_latitude,
                  p_nr_matricula_usuario);             
                                 
    INSERT INTO tb_log VALUES ( p_nr_matricula_usuario,
                             sysdate(), 
                             concat('operacao de atualizacao de reporte de atendimento', '-' , p_id_atendimento));     
                                                     
COMMIT;
set p_return_code = 0;                                     
END$$

DROP PROCEDURE IF EXISTS `pr_ins_reporte_efetuado`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pr_ins_reporte_efetuado`(
        IN  p_id_atendimento                  INT(2), 
        IN  p_Cd_status                       CHAR(1),
        IN  p_Dt_reporte                      DATETIME, 
        IN  p_Cd_pendencia                    CHAR(1),
        IN  p_Tx_longitude                    CHAR(8),
        IN  p_Tx_latitude                     CHAR(8),
        IN  p_nr_matricula_usuario            INT (11) ,
		 OUT p_return_code tinyint unsigned
     )
BEGIN 

DECLARE exit handler for sqlexception
  BEGIN
    
    set p_return_code = 1;
    rollback;
  END;

  DECLARE exit handler for sqlwarning
  BEGIN
    
    set p_return_code = 2;
    rollback;
  END;
          
START TRANSACTION;

    UPDATE tb_atendimento 
         set cd_status = 'E'
        where id_atendimento = p_id_atendimento;  
 
    INSERT INTO tb_reporte
         VALUES ( p_id_atendimento,
                  p_Cd_status, 
                  p_Dt_reporte, 
                  p_Cd_pendencia, 
                  p_Tx_longitude,
                  p_Tx_latitude,
                  p_nr_matricula_usuario);             
                                 
    INSERT INTO tb_log VALUES ( p_nr_matricula_usuario,
                             sysdate(), 
                             concat('operacao de atualizacao de reporte de atendimento', '-' , p_id_atendimento));     
                                                     
COMMIT;
set p_return_code = 0;                                     
END$$

DROP PROCEDURE IF EXISTS `pr_ins_reporte_pendente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pr_ins_reporte_pendente`(
        IN  p_id_atendimento                  INT(2), 
        IN  p_Cd_status                       CHAR(1),
        IN  p_Dt_reporte                      DATETIME, 
        IN  p_Cd_pendencia                    CHAR(1),
        IN  p_Tx_longitude                    CHAR(8),
        IN  p_Tx_latitude                     CHAR(8),
        IN  p_nr_matricula_usuario            INT (11) ,
		 OUT p_return_code tinyint unsigned
     )
BEGIN 

DECLARE exit handler for sqlexception
  BEGIN
    -- ERROR
    set p_return_code = 1;
    rollback;
  END;

  DECLARE exit handler for sqlwarning
  BEGIN
    -- WARNING
    set p_return_code = 2;
    rollback;
  END;
          
START TRANSACTION;

    UPDATE tb_atendimento 
         set cd_status = 'P'
        where id_atendimento = p_id_atendimento;  
 
    INSERT INTO tb_reporte
         VALUES ( p_id_atendimento,
                  p_Cd_status, 
                  p_Dt_reporte, 
                  p_Cd_pendencia, 
                  p_Tx_longitude,
                  p_Tx_latitude,
                  p_nr_matricula_usuario);             
                                 
    INSERT INTO tb_log VALUES ( p_nr_matricula_usuario,
                             sysdate(), 
                             concat('operacao de atualizacao de reporte de atendimento', '-' , p_id_atendimento));     
                                                     
COMMIT;
set p_return_code = 0;                                     
END$$

DROP PROCEDURE IF EXISTS `pr_upd_atendimento`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pr_upd_atendimento`(

        IN  p_id_atendimento                  INT(2), 
        IN  p_nr_matricula_usuario            INT (11) 

     )
BEGIN 
          
START TRANSACTION;
 
    UPDATE tb_atendimento  
         set cd_status = 'E'
        where id_atendimento = p_id_atendimento;              
                                 
    INSERT INTO tb_log VALUES ( p_nr_matricula_usuario,
                             sysdate(), 
                             concat('operação de atualizacao de reporte de atendimento', '-' , p_id_atendimento));                              
COMMIT;                                
END$$

DROP PROCEDURE IF EXISTS `pr_upd_os`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `pr_upd_os`(
        IN  p_id_os                     INT(2), 
        IN  p_tx_detalhe                TEXT(500),
        IN  p_nr_matricula_usuario      INT (11),
        IN  p_dt_fim                    DATETIME,       
       OUT p_return_code tinyint unsigned
  )
BEGIN

  DECLARE exit handler for sqlexception
  BEGIN
    
    set p_return_code = 1;
    rollback;
  END;

  DECLARE exit handler for sqlwarning
  BEGIN
    
    set p_return_code = 2;
    rollback;
  END;

          
START TRANSACTION; 
          
    UPDATE  tb_os 
         set tx_detalhe = p_tx_detalhe,
             cd_status = 'F',
             dt_fim = p_dt_fim
         where id_os = p_id_os;      
            
                               
    INSERT INTO TB_LOG VALUES ( p_nr_matricula_usuario,
                             sysdate(), 
                             concat('operacao de finalizacao da O.S ', '-' , p_id_os)); 
                             
COMMIT;    
set p_return_code = 0;                            
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_agenda`
--

DROP TABLE IF EXISTS `tb_agenda`;
CREATE TABLE IF NOT EXISTS `tb_agenda` (
  `Id_janela` int(11) NOT NULL,
  `Id_equipe` int(11) NOT NULL,
  `Dt_criacao` datetime NOT NULL,
  `Dt_fim` datetime DEFAULT NULL,
  PRIMARY KEY (`Id_janela`,`Id_equipe`),
  KEY `TB_EQUIPE_TB_AGENDA_FK1` (`Id_equipe`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `tb_agenda`
--

INSERT INTO `tb_agenda` (`Id_janela`, `Id_equipe`, `Dt_criacao`, `Dt_fim`) VALUES
(1, 1, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(2, 2, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(3, 1, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(4, 1, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(5, 1, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(6, 1, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(7, 2, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(8, 2, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(9, 2, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(10, 2, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(11, 2, '2014-03-26 00:00:00', '2015-03-30 00:00:00'),
(12, 1, '2014-03-26 00:00:00', '2015-03-30 00:00:00'),
(12, 3, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(13, 3, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(14, 3, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(15, 3, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(16, 4, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(17, 4, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(18, 4, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(19, 4, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(20, 5, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(21, 5, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(22, 5, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(23, 5, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(24, 6, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(25, 6, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(26, 6, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(27, 6, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(28, 7, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(29, 7, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(30, 7, '2014-03-26 00:00:00', '2014-03-30 00:00:00'),
(31, 7, '2014-03-26 00:00:00', '2014-03-30 00:00:00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_alm_kit`
--

DROP TABLE IF EXISTS `tb_alm_kit`;
CREATE TABLE IF NOT EXISTS `tb_alm_kit` (
  `id_servico` int(11) NOT NULL,
  `cd_kit` int(11) NOT NULL,
  PRIMARY KEY (`id_servico`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `tb_alm_kit`
--

INSERT INTO `tb_alm_kit` (`id_servico`, `cd_kit`) VALUES
(1, 1),
(2, 2),
(3, 3);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_atendimento`
--

DROP TABLE IF EXISTS `tb_atendimento`;
CREATE TABLE IF NOT EXISTS `tb_atendimento` (
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
  KEY `TB_AGENDA_TB_ATENDIMENTO_FK1` (`Id_janela`,`Id_equipe`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=67 ;

--
-- Extraindo dados da tabela `tb_atendimento`
--

INSERT INTO `tb_atendimento` (`Id_atendimento`, `Id_OS`, `Dt_agendamento`, `Nr_matricula`, `Cd_status`, `Id_janela`, `Id_equipe`, `Id_categoria`) VALUES
(1, 1, '2014-04-01 09:00:00', 1, 'A', 1, 1, 1),
(2, 2, '2014-04-02 09:00:00', 2, 'A', 2, 2, 1),
(3, 3, '2014-04-03 10:00:00', 1, 'A', 1, 1, 1),
(4, 6, '2014-04-16 15:14:48', 1, 'A', 3, 1, 1),
(5, 7, '2014-04-16 15:15:43', 1, 'A', 3, 1, 1),
(6, 8, '2014-04-17 00:26:11', 1, 'A', 1, 1, 1),
(7, 9, '2014-04-18 09:00:00', 1, 'A', 1, 1, 1),
(8, 10, '2014-04-15 09:00:00', 1, 'A', 1, 1, 1),
(9, 11, '2014-04-19 16:00:00', 1, 'A', 5, 1, 1),
(10, 12, '2014-04-28 09:00:00', 1, 'A', 1, 1, 1),
(11, 13, '2014-04-29 09:00:00', 1, 'C', 1, 1, 1),
(12, 14, '2014-04-30 11:00:00', 1, 'C', 3, 1, 1),
(13, 15, '2014-04-30 16:00:00', 1, 'C', 5, 1, 1),
(14, 16, '2014-04-28 09:00:00', 2, 'P', 2, 2, 1),
(15, 17, '2014-04-30 11:00:00', 1, 'C', 3, 1, 1),
(16, 18, '2014-04-30 11:00:00', 1, 'A', 3, 1, 1),
(17, 19, '2014-05-03 11:00:00', 1, 'C', 3, 1, 1),
(18, 20, '2014-05-03 11:00:00', 1, 'C', 3, 1, 1),
(19, 21, '2014-05-13 09:00:00', 1, 'C', 1, 1, 1),
(20, 22, '2014-05-14 11:00:00', 1, 'P', 3, 1, 1),
(21, 23, '2014-05-14 16:00:00', 1, 'E', 5, 1, 1),
(22, 24, '2014-05-20 09:00:00', 1, 'R', 1, 1, 1),
(23, 25, '2014-05-26 09:00:00', 1, 'A', 1, 1, 1),
(24, 26, '2014-05-31 11:00:00', 1, 'C', 3, 1, 1),
(37, 31, '2014-07-22 09:00:00', 1, 'C', 1, 1, 1),
(38, 32, '2014-07-22 09:00:00', 2, 'A', 2, 2, 1),
(39, 33, '2014-07-23 17:17:00', 1, 'A', 12, 1, 1),
(40, 34, '2014-07-22 09:00:00', 1, 'R', 1, 1, 1),
(41, 35, '2014-07-26 11:00:00', 1, 'E', 3, 1, 7),
(42, 36, '2014-07-24 09:00:00', 2, 'A', 2, 2, 1),
(43, 37, '2014-07-23 11:00:00', 1, 'A', 3, 1, 1),
(44, 38, '2014-07-25 17:17:00', 1, 'E', 12, 1, 1),
(45, 39, '2014-07-28 09:00:00', 1, 'E', 1, 1, 1),
(46, 40, '2014-07-23 08:00:00', 1, 'E', 13, 3, 1),
(47, 41, '2014-07-26 11:00:00', 7, 'A', 17, 4, 1),
(48, 42, '2014-07-26 17:00:00', 8, 'A', 23, 5, 1),
(49, 43, '2014-08-02 17:00:00', 8, 'A', 23, 5, 1),
(50, 44, '2014-08-01 17:00:00', 8, 'A', 23, 5, 1),
(51, 45, '2014-07-30 09:00:00', 1, 'A', 15, 3, 1),
(52, 46, '2014-07-30 08:00:00', 1, 'R', 13, 3, 1),
(53, 47, '2014-07-26 16:00:00', 1, 'A', 5, 1, 1),
(54, 48, '2014-08-02 16:00:00', 1, 'A', 5, 1, 1),
(55, 49, '2014-07-25 14:00:00', 8, 'A', 20, 5, 1),
(56, 50, '2014-07-24 08:00:00', 1, 'A', 14, 3, 1),
(57, 51, '2014-07-24 17:00:00', 8, 'A', 23, 5, 1),
(58, 52, '2014-07-30 08:00:00', 1, 'C', 14, 3, 1),
(59, 53, '2014-07-23 08:00:00', 1, 'A', 14, 3, 1),
(60, 54, '2014-07-23 17:00:00', 8, 'A', 23, 5, 1),
(61, 55, '2014-07-24 08:00:00', 1, 'A', 13, 3, 1),
(62, 56, '2014-07-24 08:00:00', 9, 'A', 25, 6, 1),
(63, 57, '2014-07-28 17:00:00', 8, 'A', 23, 5, 1),
(64, 58, '2014-08-02 11:00:00', 1, 'A', 3, 1, 1),
(65, 59, '2014-07-23 16:00:00', 1, 'E', 5, 1, 1),
(66, 60, '2014-07-24 14:00:00', 8, 'A', 20, 5, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_bloqueio`
--

DROP TABLE IF EXISTS `tb_bloqueio`;
CREATE TABLE IF NOT EXISTS `tb_bloqueio` (
  `Id_equipe` int(11) NOT NULL,
  `Dt_inicio` datetime NOT NULL,
  `Dt_fim` datetime NOT NULL,
  PRIMARY KEY (`Id_equipe`,`Dt_inicio`,`Dt_fim`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_calendario`
--

DROP TABLE IF EXISTS `tb_calendario`;
CREATE TABLE IF NOT EXISTS `tb_calendario` (
  `Dt_inicial` datetime NOT NULL,
  `Dt_final` datetime NOT NULL,
  PRIMARY KEY (`Dt_inicial`,`Dt_final`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_categoria`
--

DROP TABLE IF EXISTS `tb_categoria`;
CREATE TABLE IF NOT EXISTS `tb_categoria` (
  `Id_categoria` int(11) NOT NULL AUTO_INCREMENT,
  `Tx_categoria` char(20) DEFAULT NULL,
  `Dt_vigencia` datetime DEFAULT NULL,
  PRIMARY KEY (`Id_categoria`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Extraindo dados da tabela `tb_categoria`
--

INSERT INTO `tb_categoria` (`Id_categoria`, `Tx_categoria`, `Dt_vigencia`) VALUES
(1, 'N/A', NULL),
(2, 'Reparo cabeamento in', NULL),
(3, 'Reparo cabeamento ex', NULL),
(4, 'Reconfiguracao local', NULL),
(5, 'Reconfiguracao remot', NULL),
(6, 'Causa cliente', NULL),
(7, 'Troca de equipamento', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_dados_clientes`
--

DROP TABLE IF EXISTS `tb_dados_clientes`;
CREATE TABLE IF NOT EXISTS `tb_dados_clientes` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Extraindo dados da tabela `tb_dados_clientes`
--

INSERT INTO `tb_dados_clientes` (`id_cliente`, `cpf`, `cnpj`, `nm_cliente`, `cd_email`, `dt_admissao`, `Endereco`, `Numero`, `Complemento`, `Bairro`, `Cidade`, `UF`, `Pais`, `CEP`, `nr_tel`, `nr_celular`, `nr_ident`) VALUES
(1, '10000000001', NULL, 'José Silva', 'cliente@gmail.com\n', '2014-01-01 00:00:00', 'Rua Nogueira Acioli', '100', 'CB 2', 'Jardim Guanabara', 'Rio de Janeiro', 'RJ', 'Brasil', '21221000', 34238978, 98987647, '447564751'),
(2, '10000000002', NULL, 'Cleosvaldo Nogueira', 'a@a.com	', '2013-12-25 00:00:00', 'Avenida Rio Branco', '116', 'Casa 1', 'Centro', 'Rio de Janeiro', 'RJ', 'Brasil', '20040001', 33224567, 988776655, '447564332'),
(3, '10000000003', NULL, 'Luiza Diesel', 'l@l.com', '2014-01-01 00:00:00', 'Rua Dona Mariana', '172', 'AP 100', 'Botafogo', 'Rio de Janeiro', 'RJ', 'Brasil', '22280020', 22337766, 988776655, '447564333'),
(4, '10000000004', NULL, 'Cliente Ficticio', 'email@email.com', '2014-07-17 00:00:00', 'Rua Marquês de São Vicente', '100', NULL, 'Gávea', 'Rio de Janeiro', 'RJ', 'Brasil', '22451041', 2133224567, 2133224567, '3322445533');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_dias`
--

DROP TABLE IF EXISTS `tb_dias`;
CREATE TABLE IF NOT EXISTS `tb_dias` (
  `Id_janela` int(11) NOT NULL,
  `Cd_dia` int(11) NOT NULL,
  `cd_semana` int(11) NOT NULL,
  PRIMARY KEY (`Id_janela`,`Cd_dia`,`cd_semana`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `tb_dias`
--

INSERT INTO `tb_dias` (`Id_janela`, `Cd_dia`, `cd_semana`) VALUES
(1, 2, 0),
(1, 2, 7),
(1, 2, 14),
(1, 2, 21),
(1, 2, 28),
(1, 3, 0),
(1, 3, 7),
(1, 3, 14),
(1, 3, 21),
(1, 3, 28),
(1, 5, 19),
(2, 2, 0),
(2, 2, 7),
(2, 2, 14),
(2, 2, 21),
(2, 2, 28),
(2, 3, 0),
(2, 3, 7),
(2, 3, 14),
(2, 3, 21),
(2, 3, 28),
(2, 5, 0),
(2, 5, 7),
(2, 5, 14),
(2, 5, 21),
(2, 5, 28),
(3, 4, 0),
(3, 4, 7),
(3, 4, 14),
(3, 4, 21),
(3, 4, 28),
(3, 7, 0),
(3, 7, 7),
(3, 7, 14),
(3, 7, 21),
(3, 7, 28),
(5, 4, 0),
(5, 4, 7),
(5, 4, 14),
(5, 4, 21),
(5, 4, 28),
(5, 7, 0),
(5, 7, 7),
(5, 7, 14),
(5, 7, 21),
(5, 7, 28),
(9, 7, 0),
(9, 7, 7),
(9, 7, 14),
(9, 7, 21),
(9, 7, 28),
(10, 7, 0),
(10, 7, 7),
(10, 7, 14),
(10, 7, 21),
(10, 7, 28),
(11, 2, 0),
(11, 2, 7),
(11, 2, 14),
(11, 2, 21),
(11, 2, 28),
(11, 2, 32),
(11, 3, 0),
(11, 3, 7),
(11, 3, 14),
(11, 3, 21),
(11, 3, 28),
(11, 3, 32),
(11, 4, 0),
(11, 4, 7),
(11, 4, 14),
(11, 4, 21),
(11, 4, 28),
(11, 4, 32),
(11, 5, 0),
(11, 5, 7),
(11, 5, 14),
(11, 5, 21),
(11, 5, 28),
(11, 5, 32),
(11, 6, 0),
(11, 6, 7),
(11, 6, 14),
(11, 6, 21),
(11, 6, 28),
(11, 6, 32),
(11, 7, 0),
(11, 7, 7),
(11, 7, 14),
(11, 7, 21),
(11, 7, 28),
(11, 7, 32),
(12, 2, 0),
(12, 2, 2),
(12, 2, 7),
(12, 2, 14),
(12, 2, 28),
(12, 3, 3),
(12, 4, 3),
(12, 5, 4),
(12, 7, 0),
(12, 7, 7),
(12, 7, 14),
(12, 7, 21),
(12, 7, 28),
(12, 7, 32),
(12, 22, 3),
(13, 2, 0),
(13, 2, 7),
(13, 2, 14),
(13, 2, 21),
(13, 2, 28),
(13, 2, 32),
(13, 3, 0),
(13, 3, 7),
(13, 3, 14),
(13, 3, 21),
(13, 3, 28),
(13, 3, 32),
(13, 4, 0),
(13, 4, 7),
(13, 4, 14),
(13, 4, 21),
(13, 4, 28),
(13, 4, 32),
(13, 5, 0),
(13, 5, 7),
(13, 5, 14),
(13, 5, 21),
(13, 5, 28),
(13, 5, 32),
(13, 6, 0),
(13, 6, 7),
(13, 6, 14),
(13, 6, 21),
(13, 6, 28),
(13, 6, 32),
(13, 7, 0),
(13, 7, 7),
(13, 7, 14),
(13, 7, 21),
(13, 7, 28),
(13, 7, 32),
(14, 2, 0),
(14, 2, 7),
(14, 2, 14),
(14, 2, 21),
(14, 2, 28),
(14, 2, 32),
(14, 3, 0),
(14, 3, 7),
(14, 3, 14),
(14, 3, 21),
(14, 3, 28),
(14, 3, 32),
(14, 4, 0),
(14, 4, 7),
(14, 4, 14),
(14, 4, 21),
(14, 4, 28),
(14, 4, 32),
(14, 5, 0),
(14, 5, 7),
(14, 5, 14),
(14, 5, 21),
(14, 5, 28),
(14, 5, 32),
(14, 6, 0),
(14, 6, 7),
(14, 6, 14),
(14, 6, 21),
(14, 6, 28),
(14, 6, 32),
(14, 7, 0),
(14, 7, 7),
(14, 7, 14),
(14, 7, 21),
(14, 7, 28),
(14, 7, 32),
(15, 2, 0),
(15, 2, 7),
(15, 2, 14),
(15, 2, 21),
(15, 2, 28),
(15, 2, 32),
(15, 3, 0),
(15, 3, 7),
(15, 3, 14),
(15, 3, 21),
(15, 3, 28),
(15, 3, 32),
(15, 4, 0),
(15, 4, 7),
(15, 4, 14),
(15, 4, 21),
(15, 4, 28),
(15, 4, 32),
(15, 5, 0),
(15, 5, 7),
(15, 5, 14),
(15, 5, 21),
(15, 5, 28),
(15, 5, 32),
(15, 6, 0),
(15, 6, 7),
(15, 6, 14),
(15, 6, 21),
(15, 6, 28),
(15, 6, 32),
(15, 7, 0),
(15, 7, 7),
(15, 7, 14),
(15, 7, 21),
(15, 7, 28),
(15, 7, 32),
(16, 2, 0),
(16, 2, 7),
(16, 2, 14),
(16, 2, 21),
(16, 2, 28),
(16, 2, 32),
(16, 3, 0),
(16, 3, 7),
(16, 3, 14),
(16, 3, 21),
(16, 3, 28),
(16, 3, 32),
(16, 4, 0),
(16, 4, 7),
(16, 4, 14),
(16, 4, 21),
(16, 4, 28),
(16, 4, 32),
(16, 5, 0),
(16, 5, 7),
(16, 5, 14),
(16, 5, 21),
(16, 5, 28),
(16, 5, 32),
(16, 6, 0),
(16, 6, 7),
(16, 6, 14),
(16, 6, 21),
(16, 6, 28),
(16, 6, 32),
(16, 7, 0),
(16, 7, 7),
(16, 7, 14),
(16, 7, 21),
(16, 7, 28),
(16, 7, 32),
(17, 2, 0),
(17, 2, 7),
(17, 2, 14),
(17, 2, 21),
(17, 2, 28),
(17, 2, 32),
(17, 3, 0),
(17, 3, 7),
(17, 3, 14),
(17, 3, 21),
(17, 3, 28),
(17, 3, 32),
(17, 4, 0),
(17, 4, 7),
(17, 4, 14),
(17, 4, 21),
(17, 4, 28),
(17, 4, 32),
(17, 5, 0),
(17, 5, 7),
(17, 5, 14),
(17, 5, 21),
(17, 5, 28),
(17, 5, 32),
(17, 6, 0),
(17, 6, 7),
(17, 6, 14),
(17, 6, 21),
(17, 6, 28),
(17, 6, 32),
(17, 7, 0),
(17, 7, 7),
(17, 7, 14),
(17, 7, 21),
(17, 7, 28),
(17, 7, 32),
(18, 2, 0),
(18, 2, 7),
(18, 2, 14),
(18, 2, 21),
(18, 2, 28),
(18, 2, 32),
(18, 3, 0),
(18, 3, 7),
(18, 3, 14),
(18, 3, 21),
(18, 3, 28),
(18, 3, 32),
(18, 4, 0),
(18, 4, 7),
(18, 4, 14),
(18, 4, 21),
(18, 4, 28),
(18, 4, 32),
(18, 5, 0),
(18, 5, 7),
(18, 5, 14),
(18, 5, 21),
(18, 5, 28),
(18, 5, 32),
(18, 6, 0),
(18, 6, 7),
(18, 6, 14),
(18, 6, 21),
(18, 6, 28),
(18, 6, 32),
(18, 7, 0),
(18, 7, 7),
(18, 7, 14),
(18, 7, 21),
(18, 7, 28),
(18, 7, 32),
(19, 2, 0),
(19, 2, 7),
(19, 2, 14),
(19, 2, 21),
(19, 2, 28),
(19, 2, 32),
(19, 3, 0),
(19, 3, 7),
(19, 3, 14),
(19, 3, 21),
(19, 3, 28),
(19, 3, 32),
(19, 4, 0),
(19, 4, 7),
(19, 4, 14),
(19, 4, 21),
(19, 4, 28),
(19, 4, 32),
(19, 5, 0),
(19, 5, 7),
(19, 5, 14),
(19, 5, 21),
(19, 5, 28),
(19, 5, 32),
(19, 6, 0),
(19, 6, 7),
(19, 6, 14),
(19, 6, 21),
(19, 6, 28),
(19, 6, 32),
(19, 7, 0),
(19, 7, 7),
(19, 7, 14),
(19, 7, 21),
(19, 7, 28),
(19, 7, 32),
(20, 2, 0),
(20, 2, 7),
(20, 2, 14),
(20, 2, 21),
(20, 2, 28),
(20, 2, 32),
(20, 3, 0),
(20, 3, 7),
(20, 3, 14),
(20, 3, 21),
(20, 3, 28),
(20, 3, 32),
(20, 4, 0),
(20, 4, 7),
(20, 4, 14),
(20, 4, 21),
(20, 4, 28),
(20, 4, 32),
(20, 5, 0),
(20, 5, 7),
(20, 5, 14),
(20, 5, 21),
(20, 5, 28),
(20, 5, 32),
(20, 6, 0),
(20, 6, 7),
(20, 6, 14),
(20, 6, 21),
(20, 6, 28),
(20, 6, 32),
(20, 7, 0),
(20, 7, 7),
(20, 7, 14),
(20, 7, 21),
(20, 7, 28),
(20, 7, 32),
(21, 2, 0),
(21, 2, 7),
(21, 2, 14),
(21, 2, 21),
(21, 2, 28),
(21, 2, 32),
(21, 3, 0),
(21, 3, 7),
(21, 3, 14),
(21, 3, 21),
(21, 3, 28),
(21, 3, 32),
(21, 4, 0),
(21, 4, 7),
(21, 4, 14),
(21, 4, 21),
(21, 4, 28),
(21, 4, 32),
(21, 5, 0),
(21, 5, 7),
(21, 5, 14),
(21, 5, 21),
(21, 5, 28),
(21, 5, 32),
(21, 6, 0),
(21, 6, 7),
(21, 6, 14),
(21, 6, 21),
(21, 6, 28),
(21, 6, 32),
(21, 7, 0),
(21, 7, 7),
(21, 7, 14),
(21, 7, 21),
(21, 7, 28),
(21, 7, 32),
(22, 2, 0),
(22, 2, 7),
(22, 2, 14),
(22, 2, 21),
(22, 2, 28),
(22, 2, 32),
(22, 3, 0),
(22, 3, 7),
(22, 3, 14),
(22, 3, 21),
(22, 3, 28),
(22, 3, 32),
(22, 4, 0),
(22, 4, 7),
(22, 4, 14),
(22, 4, 21),
(22, 4, 28),
(22, 4, 32),
(22, 5, 0),
(22, 5, 7),
(22, 5, 14),
(22, 5, 21),
(22, 5, 28),
(22, 5, 32),
(22, 6, 0),
(22, 6, 7),
(22, 6, 14),
(22, 6, 21),
(22, 6, 28),
(22, 6, 32),
(22, 7, 0),
(22, 7, 7),
(22, 7, 14),
(22, 7, 21),
(22, 7, 28),
(22, 7, 32),
(23, 2, 0),
(23, 2, 7),
(23, 2, 14),
(23, 2, 21),
(23, 2, 28),
(23, 2, 32),
(23, 3, 0),
(23, 3, 7),
(23, 3, 14),
(23, 3, 21),
(23, 3, 28),
(23, 3, 32),
(23, 4, 0),
(23, 4, 7),
(23, 4, 14),
(23, 4, 21),
(23, 4, 28),
(23, 4, 32),
(23, 5, 0),
(23, 5, 7),
(23, 5, 14),
(23, 5, 21),
(23, 5, 28),
(23, 5, 32),
(23, 6, 0),
(23, 6, 7),
(23, 6, 14),
(23, 6, 21),
(23, 6, 28),
(23, 6, 32),
(23, 7, 0),
(23, 7, 7),
(23, 7, 14),
(23, 7, 21),
(23, 7, 28),
(23, 7, 32),
(24, 2, 0),
(24, 2, 7),
(24, 2, 14),
(24, 2, 21),
(24, 2, 28),
(24, 2, 32),
(24, 3, 0),
(24, 3, 7),
(24, 3, 14),
(24, 3, 21),
(24, 3, 28),
(24, 3, 32),
(24, 4, 0),
(24, 4, 7),
(24, 4, 14),
(24, 4, 21),
(24, 4, 28),
(24, 4, 32),
(24, 5, 0),
(24, 5, 7),
(24, 5, 14),
(24, 5, 21),
(24, 5, 28),
(24, 5, 32),
(24, 6, 0),
(24, 6, 7),
(24, 6, 14),
(24, 6, 21),
(24, 6, 28),
(24, 6, 32),
(24, 7, 0),
(24, 7, 7),
(24, 7, 14),
(24, 7, 21),
(24, 7, 28),
(24, 7, 32),
(25, 2, 0),
(25, 2, 7),
(25, 2, 14),
(25, 2, 21),
(25, 2, 28),
(25, 2, 32),
(25, 3, 0),
(25, 3, 7),
(25, 3, 14),
(25, 3, 21),
(25, 3, 28),
(25, 3, 32),
(25, 4, 0),
(25, 4, 7),
(25, 4, 14),
(25, 4, 21),
(25, 4, 28),
(25, 4, 32),
(25, 5, 0),
(25, 5, 7),
(25, 5, 14),
(25, 5, 21),
(25, 5, 28),
(25, 5, 32),
(25, 6, 0),
(25, 6, 7),
(25, 6, 14),
(25, 6, 21),
(25, 6, 28),
(25, 6, 32),
(25, 7, 0),
(25, 7, 7),
(25, 7, 14),
(25, 7, 21),
(25, 7, 28),
(25, 7, 32),
(26, 2, 0),
(26, 2, 7),
(26, 2, 14),
(26, 2, 21),
(26, 2, 28),
(26, 2, 32),
(26, 3, 0),
(26, 3, 7),
(26, 3, 14),
(26, 3, 21),
(26, 3, 28),
(26, 3, 32),
(26, 4, 0),
(26, 4, 7),
(26, 4, 14),
(26, 4, 21),
(26, 4, 28),
(26, 4, 32),
(26, 5, 0),
(26, 5, 7),
(26, 5, 14),
(26, 5, 21),
(26, 5, 28),
(26, 5, 32),
(26, 6, 0),
(26, 6, 7),
(26, 6, 14),
(26, 6, 21),
(26, 6, 28),
(26, 6, 32),
(26, 7, 0),
(26, 7, 7),
(26, 7, 14),
(26, 7, 21),
(26, 7, 28),
(26, 7, 32),
(27, 2, 0),
(27, 2, 7),
(27, 2, 14),
(27, 2, 21),
(27, 2, 28),
(27, 2, 32),
(27, 3, 0),
(27, 3, 7),
(27, 3, 14),
(27, 3, 21),
(27, 3, 28),
(27, 3, 32),
(27, 4, 0),
(27, 4, 7),
(27, 4, 14),
(27, 4, 21),
(27, 4, 28),
(27, 4, 32),
(27, 5, 0),
(27, 5, 7),
(27, 5, 14),
(27, 5, 21),
(27, 5, 28),
(27, 5, 32),
(27, 6, 0),
(27, 6, 7),
(27, 6, 14),
(27, 6, 21),
(27, 6, 28),
(27, 6, 32),
(27, 7, 0),
(27, 7, 7),
(27, 7, 14),
(27, 7, 21),
(27, 7, 28),
(27, 7, 32),
(28, 2, 0),
(28, 2, 7),
(28, 2, 14),
(28, 2, 21),
(28, 2, 28),
(28, 2, 32),
(28, 3, 0),
(28, 3, 7),
(28, 3, 14),
(28, 3, 21),
(28, 3, 28),
(28, 3, 32),
(28, 4, 0),
(28, 4, 7),
(28, 4, 14),
(28, 4, 21),
(28, 4, 28),
(28, 4, 32),
(28, 5, 0),
(28, 5, 7),
(28, 5, 14),
(28, 5, 21),
(28, 5, 28),
(28, 5, 32),
(28, 6, 0),
(28, 6, 7),
(28, 6, 14),
(28, 6, 21),
(28, 6, 28),
(28, 6, 32),
(28, 7, 0),
(28, 7, 7),
(28, 7, 14),
(28, 7, 21),
(28, 7, 28),
(28, 7, 32),
(29, 2, 0),
(29, 2, 7),
(29, 2, 14),
(29, 2, 21),
(29, 2, 28),
(29, 2, 32),
(29, 3, 0),
(29, 3, 7),
(29, 3, 14),
(29, 3, 21),
(29, 3, 28),
(29, 3, 32),
(29, 4, 0),
(29, 4, 7),
(29, 4, 14),
(29, 4, 21),
(29, 4, 28),
(29, 4, 32),
(29, 5, 0),
(29, 5, 7),
(29, 5, 14),
(29, 5, 21),
(29, 5, 28),
(29, 5, 32),
(29, 6, 0),
(29, 6, 7),
(29, 6, 14),
(29, 6, 21),
(29, 6, 28),
(29, 6, 32),
(29, 7, 0),
(29, 7, 7),
(29, 7, 14),
(29, 7, 21),
(29, 7, 28),
(29, 7, 32),
(30, 2, 0),
(30, 2, 7),
(30, 2, 14),
(30, 2, 21),
(30, 2, 28),
(30, 2, 32),
(30, 3, 0),
(30, 3, 7),
(30, 3, 14),
(30, 3, 21),
(30, 3, 28),
(30, 3, 32),
(30, 4, 0),
(30, 4, 7),
(30, 4, 14),
(30, 4, 21),
(30, 4, 28),
(30, 4, 32),
(30, 5, 0),
(30, 5, 7),
(30, 5, 14),
(30, 5, 21),
(30, 5, 28),
(30, 5, 32),
(30, 6, 0),
(30, 6, 7),
(30, 6, 14),
(30, 6, 21),
(30, 6, 28),
(30, 6, 32),
(30, 7, 0),
(30, 7, 7),
(30, 7, 14),
(30, 7, 21),
(30, 7, 28),
(30, 7, 32),
(31, 2, 0),
(31, 2, 7),
(31, 2, 14),
(31, 2, 21),
(31, 2, 28),
(31, 2, 32),
(31, 3, 0),
(31, 3, 7),
(31, 3, 14),
(31, 3, 21),
(31, 3, 28),
(31, 3, 32),
(31, 4, 0),
(31, 4, 7),
(31, 4, 14),
(31, 4, 21),
(31, 4, 28),
(31, 4, 32),
(31, 5, 0),
(31, 5, 7),
(31, 5, 14),
(31, 5, 21),
(31, 5, 28),
(31, 5, 32),
(31, 6, 0),
(31, 6, 7),
(31, 6, 14),
(31, 6, 21),
(31, 6, 28),
(31, 6, 32),
(31, 7, 0),
(31, 7, 7),
(31, 7, 14),
(31, 7, 21),
(31, 7, 28),
(31, 7, 32);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_equipe`
--

DROP TABLE IF EXISTS `tb_equipe`;
CREATE TABLE IF NOT EXISTS `tb_equipe` (
  `Id_equipe` int(11) NOT NULL AUTO_INCREMENT,
  `Id_servico` int(11) NOT NULL,
  `Nr_matricula` int(11) NOT NULL,
  `Nr_smarthfone` int(11) NOT NULL,
  `Nr_cep_inicial` int(11) NOT NULL,
  `Nr_cep_final` int(11) NOT NULL,
  PRIMARY KEY (`Id_equipe`),
  KEY `TB_SERVICO_TB_EQUIPE_FK1` (`Id_servico`),
  KEY `IDX_TB_EQUIPE` (`Nr_matricula`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Extraindo dados da tabela `tb_equipe`
--

INSERT INTO `tb_equipe` (`Id_equipe`, `Id_servico`, `Nr_matricula`, `Nr_smarthfone`, `Nr_cep_inicial`, `Nr_cep_final`) VALUES
(1, 1, 1, 99998877, 21221000, 21221999),
(2, 2, 2, 88776655, 27343000, 27343999),
(3, 3, 1, 988776655, 21221000, 21222009),
(4, 4, 7, 33333333, 26343000, 27343999),
(5, 5, 8, 33333333, 26343000, 27343999),
(6, 6, 9, 33333333, 26343000, 27343999),
(7, 7, 10, 33333333, 26343000, 27343999),
(8, 8, 11, 33333333, 26343000, 27343999),
(9, 9, 12, 33333333, 26343000, 27343999);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_janela`
--

DROP TABLE IF EXISTS `tb_janela`;
CREATE TABLE IF NOT EXISTS `tb_janela` (
  `Id_janela` int(11) NOT NULL AUTO_INCREMENT,
  `Id_servico` int(11) NOT NULL,
  `Hr_inicial` time NOT NULL DEFAULT '00:00:00',
  `Hr_final` time NOT NULL DEFAULT '00:00:00',
  `Dt_vig_fim` datetime DEFAULT NULL,
  `Dt_vig_ini` datetime NOT NULL,
  PRIMARY KEY (`Id_janela`),
  KEY `TB_SERVICO_TB_JANELA_FK1` (`Id_servico`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=33 ;

--
-- Extraindo dados da tabela `tb_janela`
--

INSERT INTO `tb_janela` (`Id_janela`, `Id_servico`, `Hr_inicial`, `Hr_final`, `Dt_vig_fim`, `Dt_vig_ini`) VALUES
(1, 1, '09:00:00', '10:00:00', '2014-03-01 00:00:00', '2014-12-30 00:00:00'),
(2, 2, '09:00:00', '10:00:00', '2014-03-01 00:00:00', '2014-12-30 00:00:00'),
(3, 1, '11:00:00', '12:00:00', '2014-03-01 00:00:00', '2014-12-30 00:00:00'),
(4, 1, '14:00:00', '15:00:00', '2014-03-01 00:00:00', '2014-12-30 00:00:00'),
(5, 1, '16:00:00', '17:00:00', '2014-03-01 00:00:00', '2014-12-30 00:00:00'),
(6, 1, '17:00:00', '18:00:00', '2014-03-01 00:00:00', '2014-12-30 00:00:00'),
(7, 2, '11:00:00', '12:00:00', '2014-03-01 00:00:00', '2014-12-30 00:00:00'),
(8, 2, '14:00:00', '15:00:00', '2014-03-01 00:00:00', '2014-12-30 00:00:00'),
(9, 2, '16:00:00', '17:00:00', '2014-03-01 00:00:00', '2014-12-30 00:00:00'),
(10, 2, '17:00:00', '18:00:00', '2014-03-01 00:00:00', '2014-12-30 00:00:00'),
(11, 2, '18:01:00', '19:02:00', '2014-07-10 00:00:00', '2014-07-18 00:00:00'),
(12, 3, '17:17:00', '18:18:00', '2015-07-16 00:00:00', '2014-07-16 00:00:00'),
(13, 1, '08:00:00', '09:00:00', '2013-07-01 00:00:00', '2015-07-01 00:00:00'),
(14, 1, '08:00:00', '09:00:00', '2013-07-01 00:00:00', '2015-07-01 00:00:00'),
(15, 2, '09:00:00', '10:00:00', '2013-07-01 00:00:00', '2015-07-01 00:00:00'),
(16, 3, '10:00:00', '11:00:00', '2013-07-01 00:00:00', '2015-07-01 00:00:00'),
(17, 1, '11:00:00', '12:00:00', '2013-07-01 00:00:00', '2015-07-01 00:00:00'),
(18, 2, '12:00:00', '13:00:00', '2013-07-01 00:00:00', '2015-07-01 00:00:00'),
(19, 3, '13:00:00', '14:00:00', '2013-07-01 00:00:00', '2015-07-01 00:00:00'),
(20, 1, '14:00:00', '15:00:00', '2013-07-01 00:00:00', '2015-07-01 00:00:00'),
(21, 2, '15:00:00', '16:00:00', '2013-07-01 00:00:00', '2015-07-01 00:00:00'),
(22, 3, '16:00:00', '17:00:00', '2013-07-01 00:00:00', '2015-07-01 00:00:00'),
(23, 1, '17:00:00', '18:00:00', '2013-07-01 00:00:00', '2015-07-01 00:00:00'),
(24, 2, '18:00:00', '19:00:00', '2013-07-01 00:00:00', '2015-07-01 00:00:00'),
(25, 3, '08:00:00', '09:00:00', '2013-07-01 00:00:00', '2015-07-01 00:00:00'),
(26, 1, '09:00:00', '10:00:00', '2013-07-01 00:00:00', '2015-07-01 00:00:00'),
(27, 2, '10:00:00', '11:00:00', '2013-07-01 00:00:00', '2015-07-01 00:00:00'),
(28, 3, '11:00:00', '12:00:00', '2013-07-01 00:00:00', '2015-07-01 00:00:00'),
(29, 1, '12:00:00', '13:00:00', '2013-07-01 00:00:00', '2015-07-01 00:00:00'),
(30, 2, '13:00:00', '14:00:00', '2013-07-01 00:00:00', '2015-07-01 00:00:00'),
(31, 3, '14:00:00', '15:00:00', '2013-07-01 00:00:00', '2015-07-01 00:00:00'),
(32, 1, '14:00:00', '15:00:00', '2013-07-01 00:00:00', '2015-07-01 00:00:00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_log`
--

DROP TABLE IF EXISTS `tb_log`;
CREATE TABLE IF NOT EXISTS `tb_log` (
  `Nr_matricula` int(11) NOT NULL,
  `Dt_operacao` datetime NOT NULL,
  `Tx_descricao` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Nr_matricula`,`Dt_operacao`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `tb_log`
--

INSERT INTO `tb_log` (`Nr_matricula`, `Dt_operacao`, `Tx_descricao`) VALUES
(1, '2014-04-16 15:14:48', 'operação de criação da O.S -6'),
(1, '2014-04-16 15:15:43', 'operação de criação da O.S -7'),
(1, '2014-04-17 00:26:11', 'operação de criação da O.S -8'),
(1, '2014-04-17 00:46:29', 'operação de criação da O.S -9'),
(1, '2014-04-17 00:54:34', 'operação de criação da O.S -10'),
(1, '2014-04-17 00:55:33', 'operação de criação da O.S -11'),
(1, '2014-04-29 19:05:34', 'operação de criação da O.S -12'),
(1, '2014-04-29 19:54:54', 'operação de criação da O.S -13'),
(1, '2014-04-29 20:09:54', 'operação de criação da O.S -14'),
(1, '2014-04-30 16:09:02', 'operação de cancelamento do atendimento-12'),
(1, '2014-04-30 16:41:13', 'operação de criação da O.S -15'),
(1, '2014-04-30 16:41:24', 'operação de cancelamento do atendimento-13'),
(1, '2014-04-30 19:41:38', 'operação de cancelamento do atendimento-13'),
(1, '2014-04-30 19:43:22', 'operação de criação da O.S -16'),
(1, '2014-04-30 21:12:22', 'operação de criação da O.S -17'),
(1, '2014-04-30 21:12:36', 'operação de cancelamento do atendimento-15'),
(1, '2014-05-01 23:08:47', 'operação de cancelamento do atendimento-11'),
(1, '2014-05-01 23:10:27', 'operação de criação da O.S -18'),
(1, '2014-05-01 23:10:57', 'operação de criação da O.S -19'),
(1, '2014-05-01 23:11:54', 'operação de cancelamento do atendimento-17'),
(1, '2014-05-01 23:23:22', 'operação de criação da O.S -20'),
(1, '2014-05-01 23:23:33', 'operação de cancelamento do atendimento-18'),
(1, '2014-05-13 20:27:31', 'operação de criação da O.S -21'),
(1, '2014-05-13 20:27:43', 'operação de cancelamento do atendimento-19'),
(1, '2014-05-13 20:36:15', 'operação de criação da O.S -22'),
(1, '2014-05-13 20:38:56', 'operação de criação da O.S -23'),
(1, '2014-05-13 20:43:16', 'operação de criação da O.S -24'),
(1, '2014-05-22 21:08:57', 'operação de criação da O.S -25'),
(1, '2014-05-30 11:41:48', 'operação de criação da O.S -26'),
(1, '2014-05-30 12:00:12', 'operação de cancelamento do atendimento-24'),
(1, '2014-05-30 14:14:35', 'operação de criação da O.S -28'),
(1, '2014-05-30 14:33:28', 'operação de cancelamento do atendimento-26'),
(1, '2014-05-30 14:33:29', 'operação de criação da O.S -29'),
(1, '2014-05-30 15:57:38', 'operação de criação da O.S -30'),
(1, '2014-06-04 14:47:06', 'operação de criação da O.S -31'),
(1, '2014-06-04 14:53:31', 'operação de criação da O.S -32'),
(1, '2014-06-04 14:57:14', 'operação de criação da O.S -33'),
(1, '2014-06-24 15:15:08', 'operação de criação da O.S -31'),
(1, '2014-06-24 15:29:17', 'operação de criação da O.S -32'),
(1, '2014-06-24 15:32:05', 'operação de cancelamento do atendimento-26'),
(1, '2014-07-10 02:31:34', 'operacao de criacao da O.S -40'),
(1, '2014-07-10 03:43:57', 'operacao de criacao da O.S -41'),
(1, '2014-07-15 20:29:56', 'operacao de criacao da O.S -42'),
(1, '2014-07-15 22:06:24', 'operacao de criacao da O.S -43'),
(1, '2014-07-15 22:07:32', 'operacao de criacao da O.S -44'),
(1, '2014-07-16 16:47:35', 'operacao de cancelamento do atendimento-36'),
(1, '2014-07-16 16:53:25', 'opera??o de cria??o da O.S -45'),
(1, '2014-07-16 16:53:30', 'operacao de cancelamento do atendimento-37'),
(1, '2014-07-16 20:53:37', 'opera??o de cria??o da O.S -46'),
(1, '2014-07-17 11:49:39', 'opera??o de cria??o da O.S -47'),
(1, '2014-07-17 12:09:01', 'operacao de cancelamento do atendimento-39'),
(1, '2014-07-17 14:38:49', 'opera??o de cria??o da O.S -48'),
(1, '2014-07-17 16:21:49', 'opera??o de cria??o da O.S -49'),
(1, '2014-07-17 17:24:56', 'operacao de atualizacao de reporte de atendimento-38'),
(1, '2014-07-17 17:27:49', 'operacao de atualizacao de reporte de atendimento-41'),
(1, '2014-07-17 17:31:10', 'operacao de atualizacao de reporte de atendimento-41'),
(1, '2014-07-17 17:36:45', 'operacao de atualizacao de reporte de atendimento-41'),
(1, '2014-07-17 17:39:20', 'operacao de atualizacao de reporte de atendimento-41'),
(1, '2014-07-18 14:12:47', 'operacao de atualizacao de reporte de atendimento-38'),
(1, '2014-07-18 14:12:52', 'operacao de atualizacao de reporte de atendimento-38'),
(1, '2014-07-18 14:12:59', 'operacao de atualizacao de reporte de atendimento-38'),
(1, '2014-07-18 14:13:18', 'operacao de atualizacao de reporte de atendimento-38'),
(1, '2014-07-18 14:13:42', 'operacao de atualizacao de reporte de atendimento-38'),
(1, '2014-07-18 14:13:46', 'operacao de atualizacao de reporte de atendimento-38'),
(1, '2014-07-18 14:13:52', 'operacao de atualizacao de reporte de atendimento-38'),
(1, '2014-07-18 14:14:34', 'opera??o de cria??o da O.S -50'),
(1, '2014-07-18 14:15:22', 'operacao de atualizacao de reporte de atendimento-42'),
(1, '2014-07-18 14:15:26', 'operacao de atualizacao de reporte de atendimento-42'),
(1, '2014-07-18 14:19:51', 'operacao de atualizacao de reporte de atendimento-38'),
(1, '2014-07-18 14:24:31', 'opera??o de cria??o da O.S -51'),
(1, '2014-07-18 14:28:56', 'operacao de atualizacao de reporte de atendimento-38'),
(1, '2014-07-18 14:29:04', 'operacao de atualizacao de reporte de atendimento-35'),
(1, '2014-07-18 14:29:09', 'operacao de atualizacao de reporte de atendimento-35'),
(1, '2014-07-18 14:37:28', 'opera??o de cria??o da O.S -52'),
(1, '2014-07-18 14:38:20', 'operacao de atualizacao de reporte de atendimento-44'),
(1, '2014-07-18 14:55:10', 'operacao de atualizacao de reporte de atendimento-44'),
(1, '2014-07-18 15:35:58', 'opera??o de cria??o da O.S -53'),
(1, '2014-07-18 15:38:03', 'operacao de atualizacao de reporte de atendimento-45'),
(1, '2014-07-18 15:38:54', 'operacao de atualizacao de reporte de atendimento-45'),
(1, '2014-07-18 16:40:13', 'operacao de atualizacao de reporte de atendimento-45'),
(1, '2014-07-18 16:41:03', 'operacao de atualizacao de reporte de atendimento-45'),
(1, '2014-07-18 16:47:33', 'operacao de atualizacao de reporte de atendimento-44'),
(1, '2014-07-18 17:08:57', 'opera??o de cria??o da O.S -54'),
(1, '2014-07-18 17:10:46', 'opera??o de cria??o da O.S -55'),
(1, '2014-07-18 17:11:10', 'operacao de cancelamento do atendimento-47'),
(1, '2014-07-18 17:11:34', 'opera??o de cria??o da O.S -56'),
(1, '2014-07-18 17:16:55', 'operacao de atualizacao de reporte de atendimento-34'),
(1, '2014-07-18 17:18:32', 'opera??o de cria??o da O.S -57'),
(1, '2014-07-18 17:18:52', 'operacao de atualizacao de reporte de atendimento-48'),
(1, '2014-07-18 17:20:16', 'operacao de atualizacao de reporte de atendimento-44'),
(1, '2014-07-18 17:26:35', 'opera??o de cria??o da O.S -58'),
(1, '2014-07-19 15:25:22', 'opera??o de cria??o da O.S -59'),
(1, '2014-07-19 16:12:17', 'operacao de atualizacao de reporte de atendimento-51'),
(1, '2014-07-20 09:25:47', 'opera??o de cria??o da O.S -60'),
(1, '2014-07-20 09:27:33', 'operacao de atualizacao de reporte de atendimento-50'),
(1, '2014-07-20 09:30:01', 'operacao de atualizacao de reporte de atendimento-50'),
(1, '2014-07-20 13:38:01', 'operacao de atualizacao de reporte de atendimento-48'),
(1, '2014-07-20 14:00:51', 'opera??o de cria??o da O.S -61'),
(1, '2014-07-20 14:03:18', 'operacao de cancelamento do atendimento-53'),
(1, '2014-07-20 14:15:55', 'operacao de atualizacao de reporte de atendimento-52'),
(1, '2014-07-20 14:19:34', 'opera??o de cria??o da O.S -62'),
(1, '2014-07-20 14:21:01', 'operacao de atualizacao de reporte de atendimento-54'),
(1, '2014-07-20 15:04:20', 'operacao de atualizacao de reporte de atendimento-54'),
(1, '2014-07-20 17:45:30', 'opera??o de cria??o da O.S -63'),
(1, '2014-07-20 19:43:18', 'operacao de atualizacao de reporte de atendimento-56'),
(1, '2014-07-20 19:47:24', 'operacao de atualizacao de reporte de atendimento-56'),
(1, '2014-07-20 19:48:21', 'operacao de atualizacao de reporte de atendimento-56'),
(1, '2014-07-20 20:30:39', 'operacao de atualizacao de reporte de atendimento-55'),
(1, '2014-07-20 20:30:56', 'operacao de atualizacao de reporte de atendimento-55'),
(1, '2014-07-20 20:35:46', 'operacao de atualizacao de reporte de atendimento-55'),
(1, '2014-07-20 20:42:57', 'operacao de atualizacao de reporte de atendimento-55'),
(1, '2014-07-20 23:20:34', 'operacao de atualizacao de reporte de atendimento-55'),
(1, '2014-07-20 23:24:13', 'operacao de atualizacao de reporte de atendimento-55'),
(1, '2014-07-20 23:29:27', 'operacao de atualizacao de reporte de atendimento-1'),
(1, '2014-07-20 23:29:34', 'operacao de atualizacao de reporte de atendimento-3'),
(1, '2014-07-21 00:09:16', 'operacao de atualizacao de reporte de atendimento-54'),
(1, '2014-07-21 00:09:40', 'operacao de atualizacao de reporte de atendimento-54'),
(1, '2014-07-21 00:09:59', 'operacao de atualizacao de reporte de atendimento-54'),
(1, '2014-07-21 00:36:29', 'operacao de atualizacao de reporte de atendimento-55'),
(1, '2014-07-21 00:37:36', 'operacao de atualizacao de reporte de atendimento-51'),
(1, '2014-07-21 00:37:49', 'operacao de atualizacao de reporte de atendimento-48'),
(1, '2014-07-21 00:37:58', 'operacao de atualizacao de reporte de atendimento-46'),
(1, '2014-07-21 00:38:10', 'operacao de atualizacao de reporte de atendimento-35'),
(1, '2014-07-21 00:38:19', 'operacao de atualizacao de reporte de atendimento-35'),
(1, '2014-07-21 00:38:35', 'operacao de atualizacao de reporte de atendimento-33'),
(1, '2014-07-21 00:38:45', 'operacao de atualizacao de reporte de atendimento-33'),
(1, '2014-07-21 10:07:28', 'operacao de atualizacao de reporte de atendimento-44'),
(1, '2014-07-21 10:07:39', 'operacao de atualizacao de reporte de atendimento-55'),
(1, '2014-07-21 10:07:43', 'operacao de atualizacao de reporte de atendimento-55'),
(1, '2014-07-21 10:07:49', 'operacao de atualizacao de reporte de atendimento-55'),
(1, '2014-07-21 10:07:59', 'operacao de atualizacao de reporte de atendimento-46'),
(1, '2014-07-21 10:08:10', 'operacao de atualizacao de reporte de atendimento-46'),
(1, '2014-07-21 10:08:17', 'operacao de atualizacao de reporte de atendimento-46'),
(1, '2014-07-21 10:08:29', 'operacao de atualizacao de reporte de atendimento-52'),
(1, '2014-07-21 10:08:46', 'operacao de atualizacao de reporte de atendimento-34'),
(1, '2014-07-21 10:08:58', 'operacao de atualizacao de reporte de atendimento-34'),
(1, '2014-07-21 10:09:07', 'operacao de atualizacao de reporte de atendimento-34'),
(1, '2014-07-21 16:25:35', 'operacao de atualizacao de reporte de atendimento-54'),
(1, '2014-07-21 16:26:51', 'operacao de atualizacao de reporte de atendimento-54'),
(1, '2014-07-21 16:27:23', 'operacao de atualizacao de reporte de atendimento-54'),
(1, '2014-07-21 16:27:55', 'operacao de atualizacao de reporte de atendimento-54'),
(1, '2014-07-21 18:44:30', 'operacao de atualizacao de reporte de atendimento-23'),
(1, '2014-07-21 18:47:19', 'operacao de atualizacao de reporte de atendimento-9'),
(1, '2014-07-21 19:01:56', 'opera??o de cria??o da O.S -65'),
(1, '2014-07-21 21:26:36', 'operacao de atualizacao de reporte de atendimento-1'),
(1, '2014-07-21 21:26:45', 'operacao de atualizacao de reporte de atendimento-1'),
(1, '2014-07-21 21:28:54', 'opera??o de cria??o da O.S -66'),
(1, '2014-07-21 21:29:58', 'operacao de atualizacao de reporte de atendimento-58'),
(1, '2014-07-21 21:42:05', 'opera??o de cria??o da O.S -67'),
(1, '2014-07-22 09:48:39', 'opera??o de cria??o da O.S -31'),
(1, '2014-07-22 10:13:03', 'opera??o de cria??o da O.S -32'),
(1, '2014-07-22 13:55:05', 'operacao de atualizacao de reporte de atendimento-37'),
(1, '2014-07-22 13:55:56', 'operacao de atualizacao de reporte de atendimento-37'),
(1, '2014-07-22 13:58:36', 'operacao de cancelamento do atendimento-37'),
(1, '2014-07-22 14:00:58', 'operacao de atualizacao de reporte de atendimento-37'),
(1, '2014-07-22 14:02:18', 'operacao de atualizacao de reporte de atendimento-23'),
(1, '2014-07-22 16:19:07', 'opera??o de cria??o da O.S -33'),
(1, '2014-07-22 16:46:34', 'opera??o de cria??o da O.S -34'),
(1, '2014-07-22 16:51:13', 'opera??o de cria??o da O.S -35'),
(1, '2014-07-22 16:54:11', 'operacao de atualizacao de reporte de atendimento-41'),
(1, '2014-07-22 16:54:22', 'opera??o de cria??o da O.S -36'),
(1, '2014-07-22 16:55:10', 'operacao de atualizacao de reporte de atendimento-41'),
(1, '2014-07-22 16:55:22', 'operacao de atualizacao de reporte de atendimento-41'),
(1, '2014-07-22 19:06:59', 'opera??o de cria??o da O.S -37'),
(1, '2014-07-22 19:12:51', 'operacao de atualizacao de reporte de atendimento-43'),
(1, '2014-07-22 19:15:04', 'operacao de atualizacao de reporte de atendimento-43'),
(1, '2014-07-22 19:34:30', 'operacao de atualizacao de reporte de atendimento-43'),
(1, '2014-07-22 19:35:44', 'opera??o de cria??o da O.S -38'),
(1, '2014-07-22 19:36:40', 'operacao de atualizacao de reporte de atendimento-44'),
(1, '2014-07-22 19:38:51', 'operacao de atualizacao de reporte de atendimento-44'),
(1, '2014-07-22 20:33:34', 'operacao de atualizacao de reporte de atendimento-40'),
(1, '2014-07-22 21:21:06', 'opera??o de cria??o da O.S -39'),
(1, '2014-07-22 21:27:28', 'operacao de atualizacao de reporte de atendimento-45'),
(1, '2014-07-22 21:36:32', 'operacao de atualizacao de reporte de atendimento-45'),
(1, '2014-07-23 12:58:14', 'opera??o de cria??o da O.S -40'),
(1, '2014-07-23 13:00:52', 'opera??o de cria??o da O.S -41'),
(1, '2014-07-23 13:01:01', 'operacao de atualizacao de reporte de atendimento-46'),
(1, '2014-07-23 13:02:35', 'operacao de atualizacao de reporte de atendimento-46'),
(1, '2014-07-23 13:04:07', 'operacao de atualizacao de reporte de atendimento-46'),
(1, '2014-07-23 13:06:44', 'operacao de atualizacao de reporte de atendimento-46'),
(1, '2014-07-23 13:14:19', 'opera??o de cria??o da O.S -42'),
(1, '2014-07-23 13:18:28', 'operacao de atualizacao de reporte de atendimento-39'),
(1, '2014-07-23 13:31:29', 'opera??o de cria??o da O.S -43'),
(1, '2014-07-23 13:35:17', 'operacao de atualizacao de reporte de atendimento-44'),
(1, '2014-07-23 14:48:00', 'opera??o de cria??o da O.S -44'),
(1, '2014-07-23 14:50:50', 'operacao de atualizacao de reporte de atendimento-44'),
(1, '2014-07-23 14:51:35', 'operacao de atualizacao de reporte de atendimento-44'),
(1, '2014-07-23 15:08:00', 'opera??o de cria??o da O.S -45'),
(1, '2014-07-23 15:12:23', 'opera??o de cria??o da O.S -46'),
(1, '2014-07-23 15:13:00', 'opera??o de cria??o da O.S -47'),
(1, '2014-07-23 15:13:37', 'opera??o de cria??o da O.S -48'),
(1, '2014-07-23 15:14:06', 'operacao de atualizacao de reporte de atendimento-54'),
(1, '2014-07-23 15:26:11', 'opera??o de cria??o da O.S -49'),
(1, '2014-07-23 15:50:35', 'opera??o de cria??o da O.S -50'),
(1, '2014-07-23 15:51:45', 'operacao de atualizacao de reporte de atendimento-52'),
(1, '2014-07-23 15:52:05', 'opera??o de cria??o da O.S -51'),
(1, '2014-07-23 15:52:51', 'opera??o de cria??o da O.S -52'),
(1, '2014-07-23 15:53:09', 'operacao de cancelamento do atendimento-58'),
(1, '2014-07-23 18:06:39', 'operacao de atualizacao de reporte de atendimento-54'),
(1, '2014-07-23 18:09:09', 'opera??o de cria??o da O.S -53'),
(1, '2014-07-23 18:17:46', 'operacao de atualizacao de reporte de atendimento-59'),
(1, '2014-07-23 18:36:14', 'operacao de atualizacao de reporte de atendimento-39'),
(1, '2014-07-23 18:37:02', 'operacao de atualizacao de reporte de atendimento-39'),
(1, '2014-07-23 18:37:33', 'operacao de atualizacao de reporte de atendimento-39'),
(1, '2014-07-23 18:38:22', 'operacao de atualizacao de reporte de atendimento-56'),
(1, '2014-07-23 18:38:41', 'operacao de atualizacao de reporte de atendimento-56'),
(1, '2014-07-23 18:40:41', 'opera??o de cria??o da O.S -54'),
(1, '2014-07-23 18:47:26', 'opera??o de cria??o da O.S -55'),
(1, '2014-07-23 18:48:50', 'opera??o de cria??o da O.S -56'),
(1, '2014-07-23 18:50:54', 'opera??o de cria??o da O.S -57'),
(1, '2014-07-23 18:53:39', 'opera??o de cria??o da O.S -58'),
(1, '2014-07-23 19:29:05', 'opera??o de cria??o da O.S -59'),
(1, '2014-07-23 19:32:35', 'operacao de atualizacao de reporte de atendimento-65'),
(1, '2014-07-23 19:35:22', 'operacao de atualizacao de reporte de atendimento-65'),
(1, '2014-07-23 19:39:09', 'opera??o de cria??o da O.S -60'),
(2, '2014-07-18 17:23:40', 'operacao de atualizacao de reporte de atendimento-49'),
(2, '2014-07-21 16:15:43', 'operacao de atualizacao de reporte de atendimento-43'),
(2, '2014-07-21 21:42:40', 'operacao de atualizacao de reporte de atendimento-59'),
(2, '2014-07-21 21:47:00', 'operacao de atualizacao de reporte de atendimento-59'),
(2, '2014-07-21 21:49:37', 'operacao de atualizacao de reporte de atendimento-59'),
(2, '2014-07-22 10:13:37', 'operacao de atualizacao de reporte de atendimento-38'),
(5, '2014-07-20 19:33:47', 'opera??o de cria??o da O.S -64');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_login`
--

DROP TABLE IF EXISTS `tb_login`;
CREATE TABLE IF NOT EXISTS `tb_login` (
  `Nr_matricula` int(11) NOT NULL,
  `Cd_USUARIO` char(1) NOT NULL,
  `CD_SENHA` char(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `tb_login`
--

INSERT INTO `tb_login` (`Nr_matricula`, `Cd_USUARIO`, `CD_SENHA`) VALUES
(1, 'A', '123'),
(2, 'T', 'tec1'),
(3, 'C', 'coo1'),
(4, 'S', 'sup1'),
(5, 'D', 'ate1');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_os`
--

DROP TABLE IF EXISTS `tb_os`;
CREATE TABLE IF NOT EXISTS `tb_os` (
  `Id_OS` int(11) NOT NULL AUTO_INCREMENT,
  `Id_servico` int(11) NOT NULL,
  `Dt_geracao` datetime DEFAULT NULL,
  `Id_cliente` int(11) DEFAULT NULL,
  `Tx_detalhe` text,
  `Cd_kit` char(3) DEFAULT NULL,
  `Cd_status` char(1) DEFAULT NULL COMMENT 'A - Aberta R � Reagendada P � Pendente C � Cancelada T - Atendida F - Finalizada',
  `Dt_fim` datetime DEFAULT NULL COMMENT 'Data de finaliza��o da O.S',
  PRIMARY KEY (`Id_OS`),
  KEY `IDX_TB_OS` (`Id_servico`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=61 ;

--
-- Extraindo dados da tabela `tb_os`
--

INSERT INTO `tb_os` (`Id_OS`, `Id_servico`, `Dt_geracao`, `Id_cliente`, `Tx_detalhe`, `Cd_kit`, `Cd_status`, `Dt_fim`) VALUES
(1, 1, '2014-03-23 00:00:00', 1, 'O cliente est? solicitando um novo servi?o!', '1', 'S', NULL),
(2, 2, '2014-03-24 00:00:00', 2, 'Outro detalhe!', '2', 'S', NULL),
(3, 1, '2014-03-23 00:00:00', 3, 'Algumas informa??es!', '1', 'S', NULL),
(4, 1, '2014-04-16 15:14:48', 1, 'dasdasdasdsadasdsadasdas', '1', 'C', NULL),
(5, 1, '2014-04-16 15:15:43', 1, 'sdasdasdasdadasdsa', '1', 'F', '2014-05-01 23:23:33'),
(6, 1, '2014-04-17 00:26:11', 1, 'teste', '1', 'C', NULL),
(7, 1, '2014-04-17 00:46:29', 1, 'sadadas', '1', 'C', NULL),
(8, 1, '2014-04-17 00:54:34', 1, 'teste 123', '1', 'C', NULL),
(9, 1, '2014-04-17 00:55:32', 1, 'testeste', '1', 'C', NULL),
(10, 1, '2014-04-29 19:05:34', 1, 'teste 123', '1', 'C', NULL),
(11, 1, '2014-04-29 19:54:54', 1, 'dasdsadsa', '1', 'X', NULL),
(12, 1, '2014-04-29 20:09:54', 1, 'Teste', '1', 'X', NULL),
(13, 1, '2014-04-30 16:41:13', 2, 'TEste teste', '1', 'X', NULL),
(14, 2, '2014-04-30 19:43:22', 2, 'Instalacao requer  qndqime.', '2', 'C', NULL),
(15, 1, '2014-04-30 21:12:22', 1, 'Vamos', '1', 'F', '2014-05-01 23:23:33'),
(16, 1, '2014-05-01 23:10:27', 1, 'TESTE', '1', 'C', NULL),
(17, 1, '2014-05-01 23:10:57', 1, 'teste', '1', 'X', '2014-05-01 23:23:33'),
(18, 1, '2014-05-01 23:23:22', 1, 'dasdasda', '1', 'X', '2014-05-01 23:23:33'),
(19, 1, '2014-05-13 20:27:31', 1, 'TESTE', '1', 'X', '2014-05-13 20:27:42'),
(20, 1, '2014-05-13 20:36:15', 1, 'TESTE', '1', 'S', NULL),
(21, 1, '2014-05-13 20:38:56', 1, 'teste2', '1', 'F', '2014-05-13 20:27:42'),
(22, 1, '2014-05-13 20:43:16', 1, '123', '1', 'X', '2014-05-13 20:27:42'),
(23, 1, '2014-05-22 21:08:57', 1, 'Testezinho', '1', 'C', NULL),
(24, 1, '2014-05-30 11:41:48', 2, '123', '1', 'X', '2014-05-30 12:00:12'),
(25, 1, '2014-05-30 14:14:35', 2, 'teste', '1', 'X', '2014-05-30 14:33:28'),
(26, 1, '2014-05-30 14:33:29', 2, 'teste', '1', 'C', NULL),
(27, 1, '2014-05-30 15:57:38', 1, '123', '1', 'C', NULL),
(31, 1, '2014-07-22 09:48:39', 3, 'Teste de insercao', '1', 'X', '2014-07-22 13:58:36'),
(32, 2, '2014-07-22 10:13:03', 3, 'teste', '2', 'C', NULL),
(33, 3, '2014-07-22 16:19:07', 3, '123', '3', 'C', NULL),
(34, 1, '2014-07-22 16:46:34', 3, 'teste', '1', 'C', NULL),
(35, 1, '2014-07-22 16:51:13', 4, 'Proximo ao ponto de onibus\r\nTivemos que trocar o equipamento do kit por um spare', '1', 'F', NULL),
(36, 2, '2014-07-22 16:54:22', 3, 'teste', '2', 'C', NULL),
(37, 1, '2014-07-22 19:06:59', 1, 'teste', '1', 'C', NULL),
(38, 3, '2014-07-22 19:35:44', 1, 'teste', '3', 'C', NULL),
(39, 1, '2014-07-22 21:21:06', 4, 'Meu atendimento de teste', '1', 'F', NULL),
(40, 1, '2014-07-23 12:58:14', 4, 'teste para a apresentacao', '1', 'C', NULL),
(41, 1, '2014-07-23 13:00:52', 2, 'TESTE', '1', 'C', NULL),
(42, 1, '2014-07-23 13:14:19', 3, 'teste apresentaÃ§Ã£o', '1', 'C', NULL),
(43, 1, '2014-07-23 13:31:29', 2, 'testejjjj', '1', 'C', NULL),
(44, 1, '2014-07-23 14:48:00', 2, 'teste2', '1', 'S', NULL),
(45, 2, '2014-07-23 15:08:00', 1, 'Cadastramento de teste', '2', 'C', NULL),
(46, 1, '2014-07-23 15:12:23', 1, 'Cadastro de teste ', '1', 'C', NULL),
(47, 1, '2014-07-23 15:13:00', 2, 'teste Carol', '1', 'C', NULL),
(48, 1, '2014-07-23 15:13:37', 2, 'teste Carol 2', '1', 'C', NULL),
(49, 1, '2014-07-23 15:26:11', 2, 'rrrr', '1', 'C', NULL),
(50, 1, '2014-07-23 15:50:35', 1, 'Reagendar Atendimento.', '1', 'C', NULL),
(51, 1, '2014-07-23 15:52:05', 1, 'Cadastro de teste ', '1', 'C', NULL),
(52, 1, '2014-07-23 15:52:51', 1, 'Teste de Cancelamento', '1', 'X', '2014-07-23 15:53:09'),
(53, 1, '2014-07-23 18:09:09', 2, 'teste de atendimento', '1', 'C', NULL),
(54, 1, '2014-07-23 18:40:41', 4, 'www2', '1', 'C', NULL),
(55, 1, '2014-07-23 18:47:26', 1, 'teste', '1', 'C', NULL),
(56, 3, '2014-07-23 18:48:50', 1, 'teste 123', '3', 'C', NULL),
(57, 1, '2014-07-23 18:50:54', 1, 'teste', '1', 'C', NULL),
(58, 1, '2014-07-23 18:53:39', 1, 'teste 123', '1', 'C', NULL),
(59, 1, '2014-07-23 19:29:05', 1, 'Atendimento de teste', '1', 'F', NULL),
(60, 1, '2014-07-23 19:39:09', 3, 'Instalacao de novo modem banda larga', '1', 'C', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_reporte`
--

DROP TABLE IF EXISTS `tb_reporte`;
CREATE TABLE IF NOT EXISTS `tb_reporte` (
  `Id_atendimento` int(11) NOT NULL,
  `Cd_status` char(1) NOT NULL,
  `Dt_reporte` datetime NOT NULL,
  `Cd_pendencia` char(1) DEFAULT NULL,
  `Tx_longitude` char(8) DEFAULT NULL,
  `Tx_latitude` char(8) DEFAULT NULL,
  `Nr_matricula` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id_atendimento`,`Cd_status`,`Dt_reporte`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `tb_reporte`
--

INSERT INTO `tb_reporte` (`Id_atendimento`, `Cd_status`, `Dt_reporte`, `Cd_pendencia`, `Tx_longitude`, `Tx_latitude`, `Nr_matricula`) VALUES
(1, 'c', '2014-03-23 00:00:00', NULL, '-43.1767', '-22.9334', 1),
(2, 'p', '2014-03-24 00:00:00', NULL, '-43.1788', '-22.9020', 2),
(3, 'c', '2014-03-23 00:00:00', NULL, '-43.3588', '-22.9610', 1),
(23, 'P', '2014-07-22 14:01:38', 'C', '-43.3581', '-22.9636', 1),
(37, 'C', '2014-07-22 13:55:16', NULL, '-43.3581', '-22.9636', 1),
(37, 'E', '2014-07-22 13:54:25', NULL, '-43.3581', '-22.9636', 1),
(37, 'P', '2014-07-22 14:00:18', 'C', '-43.3580', '-22.9637', 1),
(38, 'C', '2014-07-22 10:13:37', NULL, '-43.1905', '-22.9397', 2),
(39, 'C', '2014-07-24 13:18:28', NULL, '-43.1900', '-22.9400', 1),
(39, 'E', '2014-07-24 18:36:14', NULL, '-43.2315', '-22.9790', 1),
(39, 'E', '2014-07-24 18:37:02', NULL, '-43.2291', '-22.9794', 1),
(39, 'E', '2014-07-24 18:37:33', NULL, '-43.2291', '-22.9794', 1),
(40, 'P', '2014-07-22 20:33:34', 'C', '-43.2345', '-22.9820', 1),
(41, 'A', '2014-07-22 16:54:41', NULL, '-43.2278', '-22.9166', 1),
(41, 'C', '2014-07-22 16:53:30', NULL, '-43.2285', '-22.9167', 1),
(41, 'E', '2014-07-22 16:54:30', NULL, '-43.2278', '-22.9166', 1),
(43, 'C', '2014-07-22 19:12:51', NULL, '-43.1901', '-22.9400', 1),
(43, 'C', '2014-07-22 19:34:30', NULL, '-43.2329', '-22.9804', 1),
(43, 'E', '2014-07-22 19:15:04', NULL, '-43.2344', '-22.9819', 1),
(44, 'A', '2014-07-24 14:51:35', NULL, '-43.1900', '-22.9400', 1),
(44, 'C', '2014-07-22 19:36:40', NULL, '-43.2329', '-22.9804', 1),
(44, 'C', '2014-07-24 13:35:17', NULL, '-43.1900', '-22.9401', 1),
(44, 'C', '2014-07-24 14:50:50', NULL, '-43.1900', '-22.9401', 1),
(44, 'E', '2014-07-22 19:38:51', NULL, '-43.2355', '-22.9822', 1),
(45, 'A', '2014-07-22 21:35:49', NULL, '-43.2287', '-22.9791', 1),
(45, 'C', '2014-07-22 21:26:46', NULL, '-43.2291', '-22.9794', 1),
(46, 'A', '2014-07-24 13:06:44', NULL, '-43.1899', '-22.9401', 1),
(46, 'C', '2014-07-24 13:01:01', NULL, '-43.2317', '-22.9792', 1),
(46, 'C', '2014-07-24 13:04:07', NULL, '-43.1900', '-22.9401', 1),
(46, 'E', '2014-07-24 13:02:35', NULL, '-43.2280', '-22.9167', 1),
(52, 'P', '2014-07-24 15:51:45', 'C', '-43.1900', '-22.9400', 1),
(54, 'C', '2014-07-24 15:14:06', NULL, '-43.1900', '-22.9401', 1),
(54, 'E', '2014-07-24 18:06:39', NULL, '-43.2150', '-22.9622', 1),
(56, 'C', '2014-07-24 18:38:22', NULL, '-43.2291', '-22.9794', 1),
(56, 'E', '2014-07-24 18:38:41', NULL, '-43.2291', '-22.9794', 1),
(59, 'C', '2014-07-24 18:17:46', NULL, '-43.2313', '-22.9791', 1),
(65, 'A', '2014-07-23 19:35:22', NULL, '-43.2312', '-22.9791', 1),
(65, 'C', '2014-07-23 19:32:35', NULL, '-43.2313', '-22.9791', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_rh`
--

DROP TABLE IF EXISTS `tb_rh`;
CREATE TABLE IF NOT EXISTS `tb_rh` (
  `nr_matricula` int(11) NOT NULL,
  `cpf` decimal(11,0) DEFAULT NULL,
  `nm_empregado` char(20) NOT NULL,
  `cd_email` tinytext,
  PRIMARY KEY (`nr_matricula`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `tb_rh`
--

INSERT INTO `tb_rh` (`nr_matricula`, `cpf`, `nm_empregado`, `cd_email`) VALUES
(1, 11111111110, 'Administrador1', 'jose@gmail.com'),
(2, 11111111112, 'Tecnico2', 'ver@onica.com'),
(3, 11111111113, 'Empregado 3 Fictício', 'em@em.com'),
(4, 11111111114, 'Empregado 1 Fictício', 'a@a.com'),
(5, 11111111115, 'Empregado 5 Fictício', 'fic@ticio.com'),
(6, 96734604772, 'Wellington Nen', NULL),
(7, 96734604772, 'Maria Baier', NULL),
(8, 96734604772, 'Celso Fabio', NULL),
(9, 96734604772, 'Marildo Nunes', NULL),
(10, 96734604772, 'Ana de Souza', NULL),
(11, 96734604772, 'martha lima', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_rh_disponibilidade`
--

DROP TABLE IF EXISTS `tb_rh_disponibilidade`;
CREATE TABLE IF NOT EXISTS `tb_rh_disponibilidade` (
  `nr_matricula` int(11) NOT NULL,
  `dt_inicio_indisp` datetime NOT NULL,
  `dt_fim_indisp` datetime NOT NULL,
  PRIMARY KEY (`nr_matricula`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_servico`
--

DROP TABLE IF EXISTS `tb_servico`;
CREATE TABLE IF NOT EXISTS `tb_servico` (
  `Id_servico` int(11) NOT NULL AUTO_INCREMENT,
  `Nm_servico` varchar(100) DEFAULT NULL,
  `Qt_inicio` int(11) DEFAULT NULL,
  `Qt_fim` int(11) DEFAULT NULL,
  `Qt_emp` int(11) DEFAULT NULL,
  `Dt_vigencia` datetime DEFAULT NULL COMMENT 'Data fim da validade do serviço',
  PRIMARY KEY (`Id_servico`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=56 ;

--
-- Extraindo dados da tabela `tb_servico`
--

INSERT INTO `tb_servico` (`Id_servico`, `Nm_servico`, `Qt_inicio`, `Qt_fim`, `Qt_emp`, `Dt_vigencia`) VALUES
(1, 'Instalacao Banda Larga 2M', 14, 240, 9, '2020-01-01 00:00:00'),
(2, 'Instalacao Banda Larga 10M', 120, 240, 2, '2020-01-01 00:00:00'),
(3, 'Instalacao Banda Larga 15M', 120, 240, 5, '2020-01-01 00:00:00'),
(4, 'Instalacao de Banda Garantida 2M', 120, 240, 2, '2020-01-01 00:00:00'),
(5, 'Instalacao de Banda Garantida 5M', 120, 240, 2, '2020-01-01 00:00:00'),
(6, 'Instalacao de Banda Garantida 10M', 120, 240, 2, '2020-01-01 00:00:00'),
(7, 'Instalacao de 1 linha telefonica', 121, 240, 2, '2020-01-01 00:00:00'),
(8, 'Instalacao de 5 linha telefonica', 120, 240, 2, '2020-01-01 00:00:00'),
(9, 'Instalacao de 10 linha telefonica', 120, 240, 2, '2020-01-01 00:00:00'),
(10, 'Desinstalacao de Banda Larga 2M', 120, 240, 2, '2020-01-01 00:00:00'),
(11, 'Desinstalacao de Banda Larga 10M', 120, 240, 2, '2020-01-01 00:00:00'),
(12, 'Desinstalacao de Banda Larga 15M', 120, 240, 2, '2020-01-01 00:00:00'),
(13, 'Desinstalacao de Banda Garantida 2M', 120, 240, 2, '2020-01-01 00:00:00'),
(14, 'Desinstalacao de Banda Garantida 5M', 120, 240, 2, '2020-01-01 00:00:00'),
(15, 'Desinstalacao de Banda Garantida 10M', 120, 240, 2, '2020-01-01 00:00:00'),
(16, 'Desinstalacao de 1 linha telefonica', 120, 240, 2, '2020-01-01 00:00:00'),
(17, 'Desinstalacao de 5 linha telefonica', 120, 240, 2, '2020-01-01 00:00:00'),
(18, 'Desinstalacao de 10 linha telefonica', 120, 240, 2, '2020-01-01 00:00:00'),
(19, 'Manutencao de Banda Larga 2M', 120, 240, 2, '2020-01-01 00:00:00'),
(20, 'Manutencao de Banda Larga 10M', 120, 240, 2, '2020-01-01 00:00:00'),
(21, 'Manutencao de Banda Larga 15M', 120, 240, 2, '2020-01-01 00:00:00'),
(22, 'Manutencao de Banda Garantida 2M', 120, 240, 2, '2020-01-01 00:00:00'),
(23, 'Manutencao de Banda Garantida 5M', 120, 240, 2, '2020-01-01 00:00:00'),
(24, 'Manutencao de Banda Garantida 10M', 120, 240, 2, '2020-01-01 00:00:00'),
(25, 'Manutencao de 1 linha telefonica', 120, 240, 2, '2020-01-01 00:00:00'),
(26, 'Manutencao de 5 linhas telefonica', 120, 240, 2, '2020-01-01 00:00:00'),
(27, 'Manutencao de 10 linhas telefonica', 120, 240, 2, '2020-01-01 00:00:00'),
(30, 'Nome servico Novo', 1, 10, 10, '2020-01-01 00:00:00'),
(31, 'Nome servico 4', 1, 1, 10, '2020-01-01 00:00:00'),
(32, 'Nome servico 3', 1, 1, 10, '2020-01-01 00:00:00'),
(33, 'Nome servico 333', 1, 1, 10, '2020-01-01 00:00:00'),
(34, 'Nome servico 333', 1, 1, 10, '2020-01-01 00:00:00'),
(38, 'Instalação Banda Larga 2M', 1, 1, 1, '2020-01-01 00:00:00'),
(39, 'Manutenção de 10 linhas telefônica', 1, 1, 1, '2020-01-01 00:00:00'),
(40, 'Instalação', 11, 11, 11, '2020-01-01 00:00:00'),
(41, 'Instalação', 120, 123, 111, '2020-01-01 00:00:00'),
(42, 'Instalação', 10, 10, 10, '2020-01-01 00:00:00'),
(43, 'Instalação', 1, 1, 11, '2020-01-01 00:00:00'),
(44, 'Instalação', 1, 1, 1, '2020-01-01 00:00:00'),
(45, 'Instalação', 1, 1, 1, '2020-01-01 00:00:00'),
(46, 'Instalação', 11, 11, 11, '2020-01-01 00:00:00'),
(47, 'Instalação', 120, 11, 11, '2020-01-01 00:00:00'),
(48, 'teste não', 15, 15, 2, '2020-01-01 00:00:00'),
(50, 'teste jorlina 02', 3, 6, 3, '2020-01-01 00:00:00'),
(53, 'Instalaçãõ', 111, 222, 3, '2020-01-01 00:00:00'),
(55, 'Servico Cadastrado', 120, 120, 11, '2020-01-01 00:00:00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_tec_auxiliares`
--

DROP TABLE IF EXISTS `tb_tec_auxiliares`;
CREATE TABLE IF NOT EXISTS `tb_tec_auxiliares` (
  `Id_equipe` int(11) NOT NULL,
  `Nr_matricula` int(11) NOT NULL,
  PRIMARY KEY (`Id_equipe`,`Nr_matricula`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `tb_tec_auxiliares`
--

INSERT INTO `tb_tec_auxiliares` (`Id_equipe`, `Nr_matricula`) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_usuario`
--

DROP TABLE IF EXISTS `tb_usuario`;
CREATE TABLE IF NOT EXISTS `tb_usuario` (
  `nr_matricula` int(11) NOT NULL,
  `cd_usuario` char(1) NOT NULL DEFAULT '' COMMENT 'A - Administrador S – supervisor T – Técnico C – Coordenador D - Atendente',
  PRIMARY KEY (`nr_matricula`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `tb_usuario`
--

INSERT INTO `tb_usuario` (`nr_matricula`, `cd_usuario`) VALUES
(1, 'A'),
(2, 'S'),
(3, 'C'),
(4, 'D'),
(5, 'T'),
(6, 'T'),
(7, 'T'),
(8, 'T'),
(9, 'T'),
(10, 'T'),
(11, 'T'),
(12, 'T');

-- --------------------------------------------------------

--
-- Estrutura stand-in para visualizar `vw_agenda_com_agendamento`
--
DROP VIEW IF EXISTS `vw_agenda_com_agendamento`;
CREATE TABLE IF NOT EXISTS `vw_agenda_com_agendamento` (
`id_servico` int(11)
,`id_janela` int(11)
,`id_equipe` int(11)
,`Hr_inicial` time
,`Hr_final` time
,`id_atendimento` bigint(11)
,`data` varchar(19)
,`NrMatriculaTecnico` int(11)
,`Id_OS` int(11)
,`cd_status` char(1)
);
-- --------------------------------------------------------

--
-- Estrutura stand-in para visualizar `vw_agenda_sem_agendamento`
--
DROP VIEW IF EXISTS `vw_agenda_sem_agendamento`;
CREATE TABLE IF NOT EXISTS `vw_agenda_sem_agendamento` (
`id_servico` int(11)
,`id_janela` int(11)
,`id_equipe` int(11)
,`Hr_inicial` time
,`Hr_final` time
,`cd_dia` int(11)
,`cd_semana` int(11)
,`ano_mes_dia` date
,`NrMatriculaTecnico` int(11)
);
-- --------------------------------------------------------

--
-- Estrutura stand-in para visualizar `vw_almoxarife`
--
DROP VIEW IF EXISTS `vw_almoxarife`;
CREATE TABLE IF NOT EXISTS `vw_almoxarife` (
`ID_SERVICO` int(11)
,`CD_KIT` int(11)
);
-- --------------------------------------------------------

--
-- Estrutura stand-in para visualizar `vw_dados_clientes`
--
DROP VIEW IF EXISTS `vw_dados_clientes`;
CREATE TABLE IF NOT EXISTS `vw_dados_clientes` (
`id_cliente` int(11)
,`CPF` varchar(11)
,`CNPJ` varchar(14)
,`NM_CLIENTE` char(20)
,`CD_EMAIL` tinytext
,`ENDERECO` varchar(100)
,`COMPLEMENTO` varchar(30)
,`NUMERO` varchar(255)
,`BAIRRO` varchar(30)
,`CIDADE` varchar(40)
,`UF` char(2)
,`CEP` varchar(10)
,`NR_TEL` decimal(14,0)
,`NR_CELULAR` decimal(14,0)
,`NR_IDENT` char(20)
);
-- --------------------------------------------------------

--
-- Estrutura stand-in para visualizar `vw_dados_rh`
--
DROP VIEW IF EXISTS `vw_dados_rh`;
CREATE TABLE IF NOT EXISTS `vw_dados_rh` (
`NR_MATRICULA` int(11)
,`NM_EMPREGADO` char(20)
,`dt_inicio_indisp` datetime
,`dt_fim_indisp` datetime
);
-- --------------------------------------------------------

--
-- Estrutura para visualizar `vw_agenda_com_agendamento`
--
DROP TABLE IF EXISTS `vw_agenda_com_agendamento`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_agenda_com_agendamento` AS select `j`.`Id_servico` AS `id_servico`,`a`.`Id_janela` AS `id_janela`,`a`.`Id_equipe` AS `id_equipe`,`j`.`Hr_inicial` AS `Hr_inicial`,`j`.`Hr_final` AS `Hr_final`,if(isnull(`at`.`Id_atendimento`),0,`at`.`Id_atendimento`) AS `id_atendimento`,if(isnull(`at`.`Dt_agendamento`),0,`at`.`Dt_agendamento`) AS `data`,`e`.`Nr_matricula` AS `NrMatriculaTecnico`,`o`.`Id_OS` AS `Id_OS`,`at`.`Cd_status` AS `cd_status` from ((((`tb_agenda` `a` join `tb_janela` `j` on((`a`.`Id_janela` = `j`.`Id_janela`))) join `tb_atendimento` `at` on(((`at`.`Id_janela` = `a`.`Id_janela`) and (`at`.`Id_equipe` = `a`.`Id_equipe`)))) join `tb_equipe` `e` on((`a`.`Id_equipe` = `e`.`Id_equipe`))) join `tb_os` `o` on((`o`.`Id_OS` = `at`.`Id_OS`)));

-- --------------------------------------------------------

--
-- Estrutura para visualizar `vw_agenda_sem_agendamento`
--
DROP TABLE IF EXISTS `vw_agenda_sem_agendamento`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_agenda_sem_agendamento` AS select `j`.`Id_servico` AS `id_servico`,`a`.`Id_janela` AS `id_janela`,`a`.`Id_equipe` AS `id_equipe`,`j`.`Hr_inicial` AS `Hr_inicial`,`j`.`Hr_final` AS `Hr_final`,`d`.`Cd_dia` AS `cd_dia`,`d`.`cd_semana` AS `cd_semana`,str_to_date((curdate() + ((`d`.`Cd_dia` - dayofweek(curdate())) + `d`.`cd_semana`)),'%Y%m%d') AS `ano_mes_dia`,`e`.`Nr_matricula` AS `NrMatriculaTecnico` from (((`tb_agenda` `a` join `tb_janela` `j` on((`a`.`Id_janela` = `j`.`Id_janela`))) join `tb_dias` `d` on((`j`.`Id_janela` = `d`.`Id_janela`))) join `tb_equipe` `e` on((`a`.`Id_equipe` = `e`.`Id_equipe`))) where ((not(concat(`j`.`Id_servico`,`a`.`Id_janela`,`a`.`Id_equipe`,`j`.`Hr_inicial`,`j`.`Hr_final`,str_to_date((curdate() + ((`d`.`Cd_dia` - dayofweek(curdate())) + `d`.`cd_semana`)),'%Y%m%d')) in (select concat(`j`.`Id_servico`,`a`.`Id_janela`,`a`.`Id_equipe`,`j`.`Hr_inicial`,`j`.`Hr_final`,if(isnull(`ate`.`Dt_agendamento`),0,cast(`ate`.`Dt_agendamento` as date))) AS `teste` from ((`tb_agenda` `a` join `tb_janela` `j` on((`a`.`Id_janela` = `j`.`Id_janela`))) join `tb_atendimento` `ate` on(((`ate`.`Id_janela` = `a`.`Id_janela`) and (`ate`.`Id_equipe` = `a`.`Id_equipe`) and (`ate`.`Cd_status` <> 'C'))))))) and (str_to_date((curdate() + ((`d`.`Cd_dia` - dayofweek(curdate())) + `d`.`cd_semana`)),'%Y%m%d') is not null) and (dayofmonth(str_to_date((curdate() + ((`d`.`Cd_dia` - dayofweek(curdate())) + `d`.`cd_semana`)),'%Y%m%d')) > 0) and (str_to_date((curdate() + ((`d`.`Cd_dia` - dayofweek(curdate())) + `d`.`cd_semana`)),'%Y%m%d') >= curdate()) and ((curdate() + ((`d`.`Cd_dia` - dayofweek(curdate())) + `d`.`cd_semana`)) <= last_day(sysdate()))) union select `j`.`Id_servico` AS `id_servico`,`a`.`Id_janela` AS `id_janela`,`a`.`Id_equipe` AS `id_equipe`,`j`.`Hr_inicial` AS `Hr_inicial`,`j`.`Hr_final` AS `Hr_final`,`d`.`Cd_dia` AS `cd_dia`,`d`.`cd_semana` AS `cd_semana`,str_to_date(((last_day(sysdate()) + interval 1 day) + ((`d`.`Cd_dia` - dayofweek((last_day(sysdate()) + interval 1 day))) + `d`.`cd_semana`)),'%Y%m%d') AS `ano_mes_dia`,`e`.`Nr_matricula` AS `NrMatriculaTecnico` from (((`tb_agenda` `a` join `tb_janela` `j` on((`a`.`Id_janela` = `j`.`Id_janela`))) join `tb_dias` `d` on((`j`.`Id_janela` = `d`.`Id_janela`))) join `tb_equipe` `e` on((`a`.`Id_equipe` = `e`.`Id_equipe`))) where ((not(concat(`j`.`Id_servico`,`a`.`Id_janela`,`a`.`Id_equipe`,`j`.`Hr_inicial`,`j`.`Hr_final`,str_to_date(((last_day(sysdate()) + interval 1 day) + ((`d`.`Cd_dia` - dayofweek((last_day(sysdate()) + interval 1 day))) + `d`.`cd_semana`)),'%Y%m%d')) in (select concat(`j`.`Id_servico`,`a`.`Id_janela`,`a`.`Id_equipe`,`j`.`Hr_inicial`,`j`.`Hr_final`,if(isnull(`ate`.`Dt_agendamento`),0,cast(`ate`.`Dt_agendamento` as date))) AS `teste` from ((`tb_agenda` `a` join `tb_janela` `j` on((`a`.`Id_janela` = `j`.`Id_janela`))) join `tb_atendimento` `ate` on(((`ate`.`Id_janela` = `a`.`Id_janela`) and (`ate`.`Id_equipe` = `a`.`Id_equipe`) and (`ate`.`Cd_status` <> 'C'))))))) and (str_to_date(((last_day(sysdate()) + interval 1 day) + ((`d`.`Cd_dia` - dayofweek((last_day(sysdate()) + interval 1 day))) + `d`.`cd_semana`)),'%Y%m%d') is not null) and (dayofmonth(str_to_date(((last_day(sysdate()) + interval 1 day) + ((`d`.`Cd_dia` - dayofweek((last_day(sysdate()) + interval 1 day))) + `d`.`cd_semana`)),'%Y%m%d')) > 0) and (str_to_date(((last_day(sysdate()) + interval 1 day) + ((`d`.`Cd_dia` - dayofweek((last_day(sysdate()) + interval 1 day))) + `d`.`cd_semana`)),'%Y%m%d') >= last_day(sysdate())) and (((last_day(sysdate()) + interval 1 day) + ((`d`.`Cd_dia` - dayofweek((last_day(sysdate()) + interval 1 day))) + `d`.`cd_semana`)) <= (last_day(sysdate()) + interval 30 day))) order by `ano_mes_dia`,`Hr_inicial`;

-- --------------------------------------------------------

--
-- Estrutura para visualizar `vw_almoxarife`
--
DROP TABLE IF EXISTS `vw_almoxarife`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_almoxarife` AS select `tb_alm_kit`.`id_servico` AS `ID_SERVICO`,`tb_alm_kit`.`cd_kit` AS `CD_KIT` from `tb_alm_kit`;

-- --------------------------------------------------------

--
-- Estrutura para visualizar `vw_dados_clientes`
--
DROP TABLE IF EXISTS `vw_dados_clientes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_dados_clientes` AS select `tb_dados_clientes`.`id_cliente` AS `id_cliente`,`tb_dados_clientes`.`cpf` AS `CPF`,`tb_dados_clientes`.`cnpj` AS `CNPJ`,`tb_dados_clientes`.`nm_cliente` AS `NM_CLIENTE`,`tb_dados_clientes`.`cd_email` AS `CD_EMAIL`,`tb_dados_clientes`.`Endereco` AS `ENDERECO`,`tb_dados_clientes`.`Complemento` AS `COMPLEMENTO`,`tb_dados_clientes`.`Numero` AS `NUMERO`,`tb_dados_clientes`.`Bairro` AS `BAIRRO`,`tb_dados_clientes`.`Cidade` AS `CIDADE`,`tb_dados_clientes`.`UF` AS `UF`,`tb_dados_clientes`.`CEP` AS `CEP`,`tb_dados_clientes`.`nr_tel` AS `NR_TEL`,`tb_dados_clientes`.`nr_celular` AS `NR_CELULAR`,`tb_dados_clientes`.`nr_ident` AS `NR_IDENT` from `tb_dados_clientes`;

-- --------------------------------------------------------

--
-- Estrutura para visualizar `vw_dados_rh`
--
DROP TABLE IF EXISTS `vw_dados_rh`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_dados_rh` AS select `r`.`nr_matricula` AS `NR_MATRICULA`,`r`.`nm_empregado` AS `NM_EMPREGADO`,`d`.`dt_inicio_indisp` AS `dt_inicio_indisp`,`d`.`dt_fim_indisp` AS `dt_fim_indisp` from (`tb_rh` `r` left join `tb_rh_disponibilidade` `d` on((`r`.`nr_matricula` = `d`.`nr_matricula`)));

--
-- Restrições para as tabelas dumpadas
--

--
-- Restrições para a tabela `tb_agenda`
--
ALTER TABLE `tb_agenda`
  ADD CONSTRAINT `TB_EQUIPE_TB_AGENDA_FK1` FOREIGN KEY (`Id_equipe`) REFERENCES `tb_equipe` (`Id_equipe`),
  ADD CONSTRAINT `TB_JANELA_TB_AGENDA_FK1` FOREIGN KEY (`Id_janela`) REFERENCES `tb_janela` (`Id_janela`);

--
-- Restrições para a tabela `tb_bloqueio`
--
ALTER TABLE `tb_bloqueio`
  ADD CONSTRAINT `TB_EQUIPE_TB_BLOQUEIO_FK1` FOREIGN KEY (`Id_equipe`) REFERENCES `tb_equipe` (`Id_equipe`);

--
-- Restrições para a tabela `tb_dias`
--
ALTER TABLE `tb_dias`
  ADD CONSTRAINT `TB_JANELA_TB_DIAS_FK1` FOREIGN KEY (`Id_janela`) REFERENCES `tb_janela` (`Id_janela`);

--
-- Restrições para a tabela `tb_equipe`
--
ALTER TABLE `tb_equipe`
  ADD CONSTRAINT `TB_SERVICO_TB_EQUIPE_FK1` FOREIGN KEY (`Id_servico`) REFERENCES `tb_servico` (`Id_servico`);

--
-- Restrições para a tabela `tb_janela`
--
ALTER TABLE `tb_janela`
  ADD CONSTRAINT `TB_SERVICO_TB_JANELA_FK1` FOREIGN KEY (`Id_servico`) REFERENCES `tb_servico` (`Id_servico`);

--
-- Restrições para a tabela `tb_os`
--
ALTER TABLE `tb_os`
  ADD CONSTRAINT `TB_SERVICO_TB_OS_FK1` FOREIGN KEY (`Id_servico`) REFERENCES `tb_servico` (`Id_servico`);

--
-- Restrições para a tabela `tb_rh_disponibilidade`
--
ALTER TABLE `tb_rh_disponibilidade`
  ADD CONSTRAINT `TB_RH_TB_RH_DISPONIBILIDADE_FK1` FOREIGN KEY (`nr_matricula`) REFERENCES `tb_rh` (`nr_matricula`);

--
-- Restrições para a tabela `tb_tec_auxiliares`
--
ALTER TABLE `tb_tec_auxiliares`
  ADD CONSTRAINT `TB_EQUIPE_TB_TECNICOS_AUXILIARES_FK1` FOREIGN KEY (`Id_equipe`) REFERENCES `tb_equipe` (`Id_equipe`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
