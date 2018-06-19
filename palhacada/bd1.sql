SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

-- Tabelas entidades
CREATE TABLE `celula` (
  `nome` varchar(255) NOT NULL,
  `rua` varchar(255) NOT NULL,
  `numero` varchar(10) NOT NULL,
  `bairro` varchar(255) NOT NULL,
  `complemento` varchar(255) DEFAULT NULL,
  `cidade` varchar(255) NOT NULL,
  `uf` varchar(2) NOT NULL,
  `cep` varchar(8) NOT NULL,
  `feira` varchar(10) NOT NULL,
  `status` boolean NOT NULL DEFAULT TRUE,
  `n_membros` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`nome`,`cidade`,`uf`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `igreja` (
  `nome` varchar(255) NOT NULL,
  `rua` varchar(255) NOT NULL,
  `numero` varchar(10) NOT NULL,
  `complemento` varchar(255) DEFAULT NULL,
  `bairro` varchar(255) NOT NULL,
  `cidade` varchar(255) NOT NULL,
  `uf` varchar(2) NOT NULL,
  `cep` varchar(8) NOT NULL,
  `n_membros` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `membros` (
  `cpf` bigint(20) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `sexo` enum('M','F') NOT NULL,
  `cidade` varchar(255) NOT NULL,
  `uf` varchar(2) NOT NULL,
  `cep` varchar(8) NOT NULL,
  `data_nasc` date NOT NULL,
  `rua` varchar(255) NOT NULL,
  `numero` varchar(10) NOT NULL,
  `bairro` varchar(255) NOT NULL,
  `complemento` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `rede` (
  `cor` varchar(15) NOT NULL,
  `nome_igreja` varchar(255) NOT NULL,
  `lider` bigint NOT NULL,
  PRIMARY KEY (`cor`, `nome_igreja`),
  CONSTRAINT `igreja_rede_FK` FOREIGN KEY (`nome_igreja`) REFERENCES `igreja` (`nome`),
  CONSTRAINT `lider_rede_FK` FOREIGN KEY (`lider`) REFERENCES `membros` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- RELAÇÕES:

CREATE TABLE `igreja_pastor` (
  `cpf_pastor` bigint(20) NOT NULL,
  `nome_igreja` varchar(255) NOT NULL,
  PRIMARY KEY (`cpf_pastor`, `nome_igreja`),
  CONSTRAINT `igreja_pastor_nome_igreja_FK` FOREIGN KEY (`nome_igreja`) REFERENCES `igreja` (`nome`),
  CONSTRAINT `igreja_pastor_cpf_FK` FOREIGN KEY (`cpf_pastor`) REFERENCES `membros` (`cpf`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `membro_celula`
( `cpf_membro` BIGINT NOT NULL ,
  `nome_celula` VARCHAR(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL ,
  `cidade_celula` VARCHAR(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL ,
  `uf_celula` VARCHAR(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL ,
  PRIMARY KEY (`cpf_membro`, `nome_celula`, `cidade_celula`, `uf_celula`),
  CONSTRAINT `celula_membro_FK` FOREIGN KEY (`nome_celula`, `cidade_celula`, `uf_celula`) REFERENCES `celula` (`nome`, `cidade`, `uf`),
  CONSTRAINT `cpf_membro_celula_FK` FOREIGN KEY (`cpf_membro`) REFERENCES `membros`(`cpf`) ON DELETE CASCADE)
  ENGINE = InnoDB;

CREATE TABLE `membro_igreja` (
  `cpf_membro` bigint(20) NOT NULL,
  `nome_igreja` varchar(255) NOT NULL,
  PRIMARY KEY (`cpf_membro`, `nome_igreja`),
  CONSTRAINT `membro_igreja_cpf_FK` FOREIGN KEY (`cpf_membro`) REFERENCES `membros`(`cpf`) ON DELETE CASCADE,
  CONSTRAINT `membro_igreja_nome_igreja_FK` FOREIGN KEY (`nome_igreja`) REFERENCES `igreja` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `reuniao_celula` (
  `data` date NOT NULL,
  `horario` time NOT NULL,
  `presentes` tinyint(4) NOT NULL,
  `visitantes` tinyint(4) NOT NULL,
  `oferta` float NOT NULL,
  `nome_celula` varchar(255) NOT NULL,
  `cidade_celula` VARCHAR(255) NOT NULL ,
  `uf_celula` VARCHAR(2) NOT NULL ,
  PRIMARY KEY (`nome_celula`, `cidade_celula`, `uf_celula`, `data`),
  CONSTRAINT `reuniao_celula_FK` FOREIGN KEY (`nome_celula`, `cidade_celula`, `uf_celula`) REFERENCES `celula` (`nome`, `cidade`, `uf`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `rede_celula` (
  `cor_rede` varchar(15) NOT NULL,
  `nome_igreja` varchar(255) NOT NULL,
  `nome_celula` varchar(255) NOT NULL,
  `cidade_celula` VARCHAR(255) NOT NULL ,
  `uf_celula` VARCHAR(2) NOT NULL ,
  PRIMARY KEY (`nome_celula`, `cidade_celula`, `uf_celula`, `cor_rede`, `nome_igreja`),
  CONSTRAINT `rede_celula_FK` FOREIGN KEY (`nome_celula`, `cidade_celula`, `uf_celula`) REFERENCES `celula` (`nome`, `cidade`, `uf`),
  CONSTRAINT `rede_celula_cor_FK` FOREIGN KEY (`cor_rede`) REFERENCES `rede` (`cor`),
  CONSTRAINT `rede_celula_igreja_FK` FOREIGN KEY (`nome_igreja`) REFERENCES `igreja` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `lider_celula` (
  `cpf` bigint NOT NULL,
  `nome_celula` varchar(255) NOT NULL,
  `cidade_celula` VARCHAR(255) NOT NULL,
  `uf_celula` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`nome_celula`, `cidade_celula`, `uf_celula`, `cpf`),
  CONSTRAINT `lider_celula_FK` FOREIGN KEY (`nome_celula`, `cidade_celula`, `uf_celula`) REFERENCES `celula` (`nome`, `cidade`, `uf`),
  CONSTRAINT `lider_celula_cpf_FK` FOREIGN KEY (`cpf`) REFERENCES `membros` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `culto` (
  `data` date NOT NULL,
  `horario` time NOT NULL,
  `presentes` tinyint(4) NOT NULL,
  `oferta` float NOT NULL,
  `dizimo` float NOT NULL,
  `preletor` varchar(255) NOT NULL,
  `nome_igreja` varchar(255) NOT NULL,
  PRIMARY KEY (`nome_igreja`,`data`,`horario`),
  CONSTRAINT `Igreja_FK` FOREIGN KEY (`nome_igreja`) REFERENCES `igreja` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


COMMIT;
