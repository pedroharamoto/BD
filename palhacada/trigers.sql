-- TABELA MEMBROS_IGREJA
CREATE TRIGGER `contador_igreja_add`
AFTER INSERT ON `membro_igreja`
FOR EACH ROW
	UPDATE igreja SET n_membros = n_membros +1
	WHERE nome = NEW.nome_igreja;

CREATE TRIGGER `contador_igreja_remove`
AFTER DELETE ON `membro_igreja`
FOR EACH ROW 
	UPDATE igreja SET n_membros = n_membros - 1
	WHERE nome = OLD.nome_igreja;

DELIMITER $$
CREATE TRIGGER `contador_igreja_update`
AFTER UPDATE ON `membro_igreja`
FOR EACH ROW
BEGIN
	UPDATE igreja SET n_membros = n_membros - 1
	WHERE nome = OLD.nome_igreja;
	UPDATE igreja SET n_membros = n_membros + 1
	WHERE nome = NEW.nome_igreja;
END $$
DELIMITER ;

-- TABELA MEMBRO_CELULA
CREATE TRIGGER `contador_celula_add`
AFTER INSERT ON `membro_celula`
FOR EACH ROW
	UPDATE celula SET n_membros = n_membros +1
	WHERE nome = NEW.nome_celula and 
	uf = NEW.uf_celula and 
	cidade = NEW.cidade_celula;

CREATE TRIGGER `contador_celula_remove`
AFTER DELETE ON `membro_celula`
FOR EACH ROW
	UPDATE celula SET n_membros = n_membros - 1
	WHERE nome = OLD.nome_celula and 
	uf = OLD.uf_celula and 
	cidade = OLD.cidade_celula;

DELIMITER $$
CREATE TRIGGER `contador_celula_update`
AFTER UPDATE ON `membro_celula`
FOR EACH ROW
BEGIN
	UPDATE celula SET n_membros = n_membros - 1
	WHERE nome = OLD.nome_celula and 
	uf = OLD.uf_celula and 
	cidade = OLD.cidade_celula;
	UPDATE celula SET n_membros = n_membros + 1
	WHERE nome = NEW.nome_celula and 
	uf = NEW.uf_celula and 
	cidade = NEW.cidade_celula;
END $$
DELIMITER ;
