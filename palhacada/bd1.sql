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
  `cod_rede` int(11) NOT NULL AUTO_INCREMENT,
  `cor` varchar(15) NOT NULL,
  PRIMARY KEY (`cod_rede`),
  UNIQUE (`cod_rede`)
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

CREATE TABLE `lider_rede` (
  `cpf_membro` bigint NOT NULL,
  `cod_rede` int NOT NULL, 
  PRIMARY KEY (`cpf_membro`, `cod_rede`),
  CONSTRAINT `lide_rede_cpf_FK` FOREIGN KEY (`cpf_membro`) REFERENCES `membros` (`cpf`),
  CONSTRAINT `lide_rede_cod_FK` FOREIGN KEY (`cod_rede`) REFERENCES `rede` (`cod_rede`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `rede_celula` (
  `cod_rede` int NOT NULL,
  `nome_celula` varchar(255) NOT NULL,
  `cidade_celula` VARCHAR(255) NOT NULL ,
  `uf_celula` VARCHAR(2) NOT NULL ,
  PRIMARY KEY (`nome_celula`, `cidade_celula`, `uf_celula`, `cod_rede`),
  CONSTRAINT `rede_celula_FK` FOREIGN KEY (`nome_celula`, `cidade_celula`, `uf_celula`) REFERENCES `celula` (`nome`, `cidade`, `uf`),
  CONSTRAINT `rede_celula_cod_FK` FOREIGN KEY (`cod_rede`) REFERENCES `rede` (`cod_rede`)
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

-- INSERÇÕES TESTE (MOCKUPS)
-- Extraindo dados da tabela `igreja`
INSERT INTO `igreja` (`nome`, `rua`, `numero`, `complemento`, `bairro`, `cidade`, `uf`, `cep`, `n_membros`) VALUES
('123', 'rua', '1', 'complemento', 'bairro', 'cidade', '0', '12345-12', 0),
('124as', 'rua', '1', 'complemento', 'bairro', 'cidade', '0', '12345-12', 0),
('1577', 'rua', '1', 'complemento', 'bairro', 'cidade', '0', '12345-12', 0),
('15771', 'rua', '1', 'complemento', 'bairro', 'cidade', '0', '12345-12', 0),
('184', 'rua', '1', 'complemento', 'bairro', 'cidade', '0', '12345-12', 0),
('AAAAAAAAAAAAAAAAA', 'rua', '1', 'complemento', 'bairro', 'cidade', '0', '12345-12', 0),
('aaafdafsdagsg', 'rua', '1', 'complemento', 'bairro', 'cidade', '0', '12345-12', 0),
('BBBBBBBBBBBB', 'rua', '1', 'complemento', 'bairro', 'cidade', 'AC', '12345-12', 0),
('ccccccccc', 'rua', '1', 'complemento', 'bairro', 'cidade', 'MT', '12345-12', 0),
('igrej1a', 'rua', '1', 'complemento', 'bairro', 'cidade', '0', '12345-12', 0),
('igreja', 'rua', '1', 'complemento', 'bairro', 'cidade', '0', '12345-12', 0),
('igreja123', 'rua', '1', 'complemento', 'bairro', 'cidade', '0', '12345-12', 0),
('igreja1234', 'rua', '1', 'complemento', 'bairro', 'cidade', '0', '12345-12', 0),
('igreja34343432432423432', 'rua', '1', 'complemento', 'bairro', 'cidade', '0', '12345-12', 0),
('igreja5555', 'rua', '1', 'complemento', 'bairro', 'cidade', '0', '12345-12', 0),
('igreja985d', 'rua', '1-50', 'complemento', 'bairro', 'cidade', '0', '12345-12', 0),
('TESTE_MEMBRO_IGREJA', 'rua', '1', 'complemento', 'bairro', 'cidade', '0', '12345-12', 0);

-- Extraindo dados da tabela `membros`
INSERT INTO `membros` (`cpf`, `nome`, `email`, `telefone`, `sexo`, `cidade`, `uf`, `cep`, `data_nasc`, `rua`, `numero`, `bairro`, `complemento`) VALUES
(-413, 'AaE', 'aea@asde.com', '(18)99874-5784', '', 'cidade', '0', '12345-12', '0000-00-00', 'rua', '1', 'bairro', 'complemento'),
(1, 'AaE', 'aea@asde.com', '(18)99874-5784', '', 'cidade', '0', '12345-12', '0000-00-00', 'rua', '1', 'bairro', 'complemento'),
(2, 'AaE', 'aea@asde.com', '(18)99874-5784', '', 'cidade', '0', '12345-12', '0000-00-00', 'rua', '1', 'bairro', 'complemento'),
(124, 'aab', 'aea@asde.com', '(18)99874-5784', '', 'cidade', '0', '12345-12', '0000-00-00', 'rua', '1', 'bairro', 'complemento'),
(125, 'cab', 'aea@asde.com', '(18)99874-5784', '', 'cidade', '0', '12345-12', '0000-00-00', 'rua', '1', 'bairro', 'complemento'),
(157, 'AaE78', 'aea@asde.com', '(18)99874-5784', 'F', 'cidade', '0', '12345-12', '0000-00-00', 'rua', '1', 'bairro', 'complemento'),
(557, 'pastor', 'aea@asde.com', '(18)99874-5784', 'M', 'cidade', 'CE', '12345-12', '2018-06-15', 'rua', '1', 'bairro', 'complemento'),
(8784, 'teste data', 'aea@asde.com', '(18)99874-5784', 'M', 'cidade', 'MS', '12345-12', '2018-06-15', 'rua', '1', 'bairro', 'complemento'),
(12354, 'dsadsad', 'aea@asde.com', '(18)99874-5784', '', 'cidade', '0', '12345-12', '2018-06-15', 'rua', '1', 'bairro', 'complemento'),
(15977, 'TESTE_MEMRTA_OIGEHAS', 'aea@asde.com', '(18)99874-5784', '', 'cidade', '0', '12345-12', '0000-00-00', 'rua', '1', 'bairro', 'complemento'),
(21312, 'dsadsadsadsa', 'aea@asde.com', '(18)99874-5784', '', 'cidade', '0', '12345-12', '2018-06-15', 'rua', '1', 'bairro', 'complemento'),
(74511, 'AaEhjgkhkjghkgjhkjghlkjgkjhhjkghkjghjgkhkgjkhjkhgjkjgk', 'aea@asde.com', '(18)99874-5784', '', 'cidade', 'AM', '12345-12', '2018-06-15', 'rua', '1', 'bairro', 'complemento'),
(99784, 'teste data', 'aea@asde.com', '(18)99874-5784', 'M', 'cidade', 'MS', '12345-12', '2018-06-15', 'rua', '1', 'bairro', 'complemento'),
(124781, 'pastor_#$!#$!2', 'aea@asde.com', '(18)99874-5784', '', 'cidade', '0', '12345-12', '2018-06-15', 'rua', '1', 'bairro', 'complemento'),
(654564, 'dasjasdhj', 'aea@asde.com', '(18)99874-5784', '', 'cidade', '0', '12345-12', '2018-06-15', 'rua', '1', 'bairro', 'complemento'),
(57506574, 'dikasjhdsauhgiute5r876954343', 'aea@asde.com', '(18)99874-5784', '', 'cidade', '0', '12345-12', '2018-06-15', 'rua', '1', 'bairro', 'complemento'),
(30057107158, 'AaE', 'aea@asde.com', '(18)99874-5784', '', 'cidade', '0', '12345-12', '0000-00-00', 'rua', '1', 'bairro', 'complemento'),
(30057107258, 'AaE', 'aea@asde.com', '(18)99874-5784', '', 'cidade', '0', '12345-12', '0000-00-00', 'rua', '1', 'bairro', 'complemento');

-- Extraindo dados da tabela `igreja_pastor`
INSERT INTO `igreja_pastor` (`cpf_pastor`, `nome_igreja`) VALUES
(-413, 'igreja5555'),
(124, 'TESTE_MEMBRO_IGREJA'),
(125, 'TESTE_MEMBRO_IGREJA'),
(557, '123'),
(15977, 'TESTE_MEMBRO_IGREJA'),
(21312, '184'),
(74511, 'TESTE_MEMBRO_IGREJA'),
(124781, 'BBBBBBBBBBBB'),
(654564, 'TESTE_MEMBRO_IGREJA'),
(57506574, '1577');

-- Extraindo dados da tabela `membro_igreja`
INSERT INTO `membro_igreja` (`cpf_membro`, `nome_igreja`) VALUES
(15977, 'TESTE_MEMBRO_IGREJA'),
(124, 'TESTE_MEMBRO_IGREJA'),
(125, 'TESTE_MEMBRO_IGREJA'),
(-413, 'igreja5555'),
(74511, 'TESTE_MEMBRO_IGREJA'),
(557, '123'),
(654564, 'TESTE_MEMBRO_IGREJA'),
(124781, 'BBBBBBBBBBBB'),
(57506574, '1577'),
(21312, '184'),
(12354, 'igrej1a'),
(8784, 'igrej1a'),
(99784, 'igrej1a');

COMMIT;
