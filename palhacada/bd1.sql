-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 16-Jun-2018 às 06:34
-- Versão do servidor: 10.1.28-MariaDB
-- PHP Version: 7.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bd1`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `celula`
--

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
  `n_membros` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `culto`
--

CREATE TABLE `culto` (
  `data` date NOT NULL,
  `horario` time NOT NULL,
  `presentes` tinyint(4) NOT NULL,
  `oferta` float NOT NULL,
  `dizimo` float NOT NULL,
  `preletor` varchar(255) NOT NULL,
  `nome_igreja` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `igreja`
--

CREATE TABLE `igreja` (
  `nome` varchar(255) NOT NULL,
  `rua` varchar(255) NOT NULL,
  `numero` varchar(10) NOT NULL,
  `complemento` varchar(255) DEFAULT NULL,
  `bairro` varchar(255) NOT NULL,
  `cidade` varchar(255) NOT NULL,
  `uf` varchar(2) NOT NULL,
  `cep` varchar(8) NOT NULL,
  `n_membros` smallint(5) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `igreja`
--

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

-- --------------------------------------------------------

--
-- Estrutura da tabela `igreja_pastor`
--

CREATE TABLE `igreja_pastor` (
  `cpf_pastor` bigint(20) NOT NULL,
  `nome_igreja` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `igreja_pastor`
--

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

-- --------------------------------------------------------

--
-- Estrutura da tabela `lideres`
--

CREATE TABLE `lideres` (
  `data_posse` date NOT NULL,
  `cpf` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `membros`
--

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
  `complemento` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `membros`
--

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

-- --------------------------------------------------------

--
-- Estrutura da tabela `membro_igreja`
--

CREATE TABLE `membro_igreja` (
  `cpf_membro` bigint(20) NOT NULL,
  `nome_igreja` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `membro_igreja`
--

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

--
-- Acionadores `membro_igreja`
--
DELIMITER $$
CREATE TRIGGER `contador_igreja_add` AFTER INSERT ON `membro_igreja` FOR EACH ROW UPDATE igreja SET n_membros = n_membros +1
	WHERE nome = NEW.nome_igreja
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `contador_igreja_remove` AFTER DELETE ON `membro_igreja` FOR EACH ROW UPDATE igreja SET n_membros = n_membros - 1
	WHERE nome = OLD.nome_igreja
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `contador_igreja_update` AFTER UPDATE ON `membro_igreja` FOR EACH ROW BEGIN
	UPDATE igreja SET n_membros = n_membros - 1
	WHERE nome = OLD.nome_igreja;
	UPDATE igreja SET n_membros = n_membros + 1
	WHERE nome = NEW.nome_igreja;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `rede`
--

CREATE TABLE `rede` (
  `cod_rede` int(11) NOT NULL,
  `cor` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `reuniao_celula`
--

CREATE TABLE `reuniao_celula` (
  `data` date NOT NULL,
  `horario` time NOT NULL,
  `presentes` tinyint(4) NOT NULL,
  `visitantes` tinyint(4) NOT NULL,
  `oferta` float NOT NULL,
  `nome_celula` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `celula`
--
ALTER TABLE `celula`
  ADD PRIMARY KEY (`nome`,`cidade`,`uf`);

--
-- Indexes for table `culto`
--
ALTER TABLE `culto`
  ADD PRIMARY KEY (`nome_igreja`,`data`,`horario`);

--
-- Indexes for table `igreja`
--
ALTER TABLE `igreja`
  ADD PRIMARY KEY (`nome`);

--
-- Indexes for table `igreja_pastor`
--
ALTER TABLE `igreja_pastor`
  ADD PRIMARY KEY (`cpf_pastor`,`nome_igreja`),
  ADD KEY `igreja_pastor_FK` (`nome_igreja`);

--
-- Indexes for table `lideres`
--
ALTER TABLE `lideres`
  ADD PRIMARY KEY (`cpf`);

--
-- Indexes for table `membros`
--
ALTER TABLE `membros`
  ADD PRIMARY KEY (`cpf`);

--
-- Indexes for table `membro_igreja`
--
ALTER TABLE `membro_igreja`
  ADD KEY `cpf_membro_FK` (`cpf_membro`),
  ADD KEY `membro_igreja_FK` (`nome_igreja`);

--
-- Indexes for table `rede`
--
ALTER TABLE `rede`
  ADD UNIQUE KEY `cod_rede` (`cod_rede`);

--
-- Indexes for table `reuniao_celula`
--
ALTER TABLE `reuniao_celula`
  ADD PRIMARY KEY (`data`,`horario`,`nome_celula`) USING BTREE,
  ADD KEY `Celula_FK` (`nome_celula`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `rede`
--
ALTER TABLE `rede`
  MODIFY `cod_rede` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `culto`
--
ALTER TABLE `culto`
  ADD CONSTRAINT `Igreja_FK` FOREIGN KEY (`nome_igreja`) REFERENCES `igreja` (`nome`);

--
-- Limitadores para a tabela `igreja_pastor`
--
ALTER TABLE `igreja_pastor`
  ADD CONSTRAINT `igreja_pastor_FK` FOREIGN KEY (`nome_igreja`) REFERENCES `igreja` (`nome`),
  ADD CONSTRAINT `membro_cpf_FK` FOREIGN KEY (`cpf_pastor`) REFERENCES `membros` (`cpf`);

--
-- Limitadores para a tabela `lideres`
--
ALTER TABLE `lideres`
  ADD CONSTRAINT `LiderMembro_FK` FOREIGN KEY (`cpf`) REFERENCES `membros` (`cpf`);

--
-- Limitadores para a tabela `membro_igreja`
--
ALTER TABLE `membro_igreja`
  ADD CONSTRAINT `cpf_membro_FK` FOREIGN KEY (`cpf_membro`) REFERENCES `membros` (`cpf`),
  ADD CONSTRAINT `membro_igreja_FK` FOREIGN KEY (`nome_igreja`) REFERENCES `igreja` (`nome`);

--
-- Limitadores para a tabela `reuniao_celula`
--
ALTER TABLE `reuniao_celula`
  ADD CONSTRAINT `Celula_FK` FOREIGN KEY (`nome_celula`) REFERENCES `celula` (`nome`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
