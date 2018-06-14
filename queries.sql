-- phpMyAdmin SQL Dump
-- version 4.8.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 14-Jun-2018 às 07:16
-- Versão do servidor: 10.1.33-MariaDB
-- PHP Version: 7.2.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `trabalho_bd`
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

-- --------------------------------------------------------

--
-- Estrutura da tabela `igreja_pastor`
--

CREATE TABLE `igreja_pastor` (
  `cpf_pastor` bigint(20) NOT NULL,
  `nome_igreja` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

-- --------------------------------------------------------

--
-- Estrutura da tabela `membro_igreja`
--

CREATE TABLE `membro_igreja` (
  `cpf_membro` bigint(20) NOT NULL,
  `nome_igreja` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pastores`
--

CREATE TABLE `pastores` (
  `data_posse` date NOT NULL,
  `empossador` varchar(255) NOT NULL,
  `cpf` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  ADD KEY `cpf_pastor_FK` (`cpf_pastor`),
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
-- Indexes for table `pastores`
--
ALTER TABLE `pastores`
  ADD PRIMARY KEY (`cpf`);

--
-- Indexes for table `rede`
--
ALTER TABLE `rede`
  ADD UNIQUE KEY `cod_rede` (`cod_rede`);

--
-- Indexes for table `reuniao_celula`
--
ALTER TABLE `reuniao_celula`
  ADD PRIMARY KEY (`data`,`horario`,`nome_celula`),
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
  ADD CONSTRAINT `cpf_pastor_FK` FOREIGN KEY (`cpf_pastor`) REFERENCES `pastores` (`cpf`),
  ADD CONSTRAINT `igreja_pastor_FK` FOREIGN KEY (`nome_igreja`) REFERENCES `igreja` (`nome`);

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
-- Limitadores para a tabela `pastores`
--
ALTER TABLE `pastores`
  ADD CONSTRAINT `Membro_Pastor_FK` FOREIGN KEY (`cpf`) REFERENCES `membros` (`cpf`);

--
-- Limitadores para a tabela `reuniao_celula`
--
ALTER TABLE `reuniao_celula`
  ADD CONSTRAINT `Celula_FK` FOREIGN KEY (`nome_celula`) REFERENCES `celula` (`nome`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
