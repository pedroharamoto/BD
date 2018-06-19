<?php
header("Content-Type: application/json; charset=UTF-8");

include "conecta.php";

//**************************************************************//

$obj = json_decode($_POST["data"], false);
$ordem = $obj->funcao;

if($ordem == 1){
    //adc uma igreja
    addIgreja($conn,$obj);
}
else if($ordem == 2) {
    //mostra as igrejas
    mostraIgreja($conn);
}
else if($ordem == 3){
    //adc um membro
    addMembro($conn,$obj);
}
else if($ordem == 33){
    //edita um membro
    editMembro($conn,$obj);
}
else if($ordem == 57){
    //mostra um membro de uma igreja
    mostraMembro($conn,$obj);
}
else if($ordem == 88){
    //add um pastor
    addPastor($conn,$obj);
}
else if($ordem == 58){
    //mostra um membro de uma igreja
    mostraPastores($conn,$obj);
}
else if($ordem == 59){
    //mostra um membro de uma igreja
    mostraPastoresMesmo($conn,$obj);
}
else if($ordem == 123){
    //add um culto
    addCulto($conn,$obj);
}
else if($ordem == 124){
    //mostra os cultos
    mostraCulto($conn,$obj);
}
else if($ordem == 200){
    //add uma celula
    addCel($conn,$obj);
}
else if($ordem == 201){
    //mostra as celulas
    mostraCel($conn,$obj);
}
else if($ordem == 202){
    //mostra as celulas
    mostraRedes_cel($conn,$obj);
}
else if($ordem == 204){
    //mostra as celulas
    mostraCelulas($conn,$obj);
}
else if($ordem == 300){
    //add uma Rede
    addRede($conn,$obj);
}else if($ordem == 301) {
    //lista membros de uma igreja em especifico
    mostraMembrosIgreja($conn, $obj);
}else if($ordem == 302){
    //Mostra REDES
    mostraRedes($conn, $obj);
}
else if($ordem == 978){
    //mostra celulas em edit membros
    shw_celula($conn,$obj);
}
//**************************************************************//
//**************************************************************//
//
//FUNÇÕES PARA QUERY
//
//**************************************************************//
//**************************************************************//
function exQuery($conn, $sql){
    //função para executar uma query
    //$link é a conexão
    //$txt é a query

    $result = $conn->query($sql);

    return $result;

}
//**************************************************************//
//**************************************************************//
//
//FUNÇÕES PARA IGREJA
//
//**************************************************************//
//**************************************************************//
function mostraIgreja($conn){
    //
    //mostra as igrejas
    //$link é a conexao
    //
    $sql = "SELECT * FROM igreja";
    //
    $resultado = exQuery($conn,$sql);
    $saida = array();
    $saida = $resultado->fetch_all(MYSQLI_ASSOC);
    //
    //
    echo json_encode($saida); //envio todos os dados encontrados em formato JSON

}
//
function addIgreja($conn,$obj){
    //
    //insere uma igreja
    //$link é a conexão
    //
    $igreja_nome        = $obj->igreja_nome;
    $igreja_qte_membros = $obj->igreja_qte_membros;
    $igreja_rua         = $obj->igreja_rua;
    $igreja_numero      = $obj->igreja_numero;
    $igreja_complemento = $obj->igreja_complemento;
    $igreja_cep         = $obj->igreja_cep;
    $igreja_bairro      = $obj->igreja_bairro;
    $igreja_cidade      = $obj->igreja_cidade;
    $igreja_uf          = $obj->igreja_uf;

    $txt_dados  = "('" . $igreja_nome . "',";
    $txt_dados  .= $igreja_qte_membros . ",";
    $txt_dados  .= "'" . $igreja_rua . "',";
    $txt_dados  .= "'" . $igreja_numero . "',";
    $txt_dados  .= "'" . $igreja_complemento . "',";
    $txt_dados  .= "'" . $igreja_bairro . "',";
    $txt_dados  .= "'" . $igreja_cidade . "',";
    $txt_dados  .= "'" . $igreja_uf . "',";
    $txt_dados  .= "'" . $igreja_cep . "')";

    $sql = "INSERT INTO igreja (nome,n_membros,rua,numero,complemento,bairro,cidade,uf,cep) VALUES " . $txt_dados;

    $resultado = exQuery($conn,$sql);
    //
    $saida = ["msg"=>$resultado]; //apenas para mandar sempre um json, aqui ainda não é um json
    //
    //
    echo json_encode($saida); //envio todos os dados encontrados em formato JSON
}
//**************************************************************//
//**************************************************************//
//
//FUNÇÕES PARA MEMBRO
//
//**************************************************************//
//**************************************************************//
function shw_celula($conn,$obj){

    $sql = "SELECT * FROM rede_celula WHERE nome_igreja = '" . $obj->nome_igreja . "'";
    //
    $resultado = exQuery($conn,$sql);
    $saida = array();
    $saida = $resultado->fetch_all(MYSQLI_ASSOC);
    //
    echo json_encode($saida);
}
function editMembro($conn,$obj){
    //
    //função para editar um membro
    //
    $membro_nome        = $obj->membro_nome;
    $membro_cpf         = $obj->membro_cpf;
    $membro_nasc        = $obj->membro_nasc;
    $membro_sexo        = $obj->membro_sexo;
    $membro_email       = $obj->membro_email;
    $membro_telefone    = $obj->membro_telefone;
    $membro_rua         = $obj->membro_rua;
    $membro_numero      = $obj->membro_numero;
    $membro_complemento = $obj->membro_complemento;
    $membro_cep         = $obj->membro_cep;
    $membro_bairro      = $obj->membro_bairro;
    $membro_cidade      = $obj->membro_cidade;
    $membro_uf          = $obj->membro_uf;
    //
    $txt_dados  = "nome = '" . $membro_nome . "',";
    $txt_dados  .= "cpf = " . $membro_cpf . ",";
    $txt_dados  .= "data_nasc = DATE('" . $membro_nasc . "'),";
    $txt_dados  .= "sexo = '" . $membro_sexo . "',";
    $txt_dados  .= "email = '" . $membro_email . "',";
    $txt_dados  .= "telefone = '" . $membro_telefone . "',";
    $txt_dados  .= "rua = '" . $membro_rua . "',";
    $txt_dados  .= "numero = '" . $membro_numero . "',";
    $txt_dados  .= "complemento = '" . $membro_complemento . "',";
    $txt_dados  .= "bairro = '" . $membro_bairro . "',";
    $txt_dados  .= "cidade = '" . $membro_cidade . "',";
    $txt_dados  .= "uf = '" . $membro_uf . "',";
    $txt_dados  .= "cep = '" . $membro_cep . "'";


    $sql = "UPDATE membros SET " . $txt_dados . " WHERE cpf = '".$membro_cpf . "'";
    //
    $resultado = exQuery($conn,$sql);
    //
    $saida = ["msg"=>mysqli_errno($conn)];
    //
    echo json_encode($saida); //envio todos os dados encontrados em formato JSON
}
function mostraMembro($conn,$obj){
    //
    // o $saida para CONSULTAS são diferentes do $saida das inserções
    //
    $membro_nome = $obj->membro_nome;
    $membro_igreja_nome = $obj->membro_igreja_nome;
    $condicao = "";

    if(!$membro_igreja_nome){
        $cond_igreja = "";
    }
    else{
        $cond_igreja = "membro_igreja.nome_igreja = '" . $membro_igreja_nome . "' AND";
    }
    $condicao .= $cond_igreja;
    $condicao .= " membro_igreja.cpf_membro = membros.cpf";
    $condicao .= " AND membros.nome like '%" . $membro_nome . "%'";

    $sql = "SELECT * FROM membros,membro_igreja WHERE " . $condicao;
    //
    $resultado = exQuery($conn,$sql);
    $saida = array();
    $saida = $resultado->fetch_all(MYSQLI_ASSOC);
    //
    //$saida = ["msg"=>$sql];
    //
    echo json_encode($saida); //envio todos os dados encontrados em formato JSON
}
//
function addMembro($conn,$obj){
    //
    //insere um membro
    //$link é a conexão
    //
    $membro_nome        = $obj->membro_nome;
    $membro_cpf         = $obj->membro_cpf;
    $membro_nasc        = $obj->membro_nasc;
    $membro_sexo        = $obj->membro_sexo;
    $membro_email       = $obj->membro_email;
    $membro_telefone    = $obj->membro_telefone;
    $membro_rua         = $obj->membro_rua;
    $membro_numero      = $obj->membro_numero;
    $membro_complemento = $obj->membro_complemento;
    $membro_cep         = $obj->membro_cep;
    $membro_bairro      = $obj->membro_bairro;
    $membro_cidade      = $obj->membro_cidade;
    $membro_uf          = $obj->membro_uf;

    $txt_dados  = "('" . $membro_nome . "',";
    $txt_dados  .= "" . $membro_cpf . ",";
    $txt_dados  .= "DATE('" . $membro_nasc . "'),";
    $txt_dados  .= "'" . $membro_sexo . "',";
    $txt_dados  .= "'" . $membro_email . "',";
    $txt_dados  .= "'" . $membro_telefone . "',";
    $txt_dados  .= "'" . $membro_rua . "',";
    $txt_dados  .= "'" . $membro_numero . "',";
    $txt_dados  .= "'" . $membro_complemento . "',";
    $txt_dados  .= "'" . $membro_bairro . "',";
    $txt_dados  .= "'" . $membro_cidade . "',";
    $txt_dados  .= "'" . $membro_uf . "',";
    $txt_dados  .= "'" . $membro_cep . "')";

    $sql = "INSERT INTO membros (nome,cpf,data_nasc,sexo,email,telefone,rua,numero,complemento,bairro,cidade,uf,cep) VALUES " . $txt_dados;

    $resultado = exQuery($conn,$sql);
    //
    if($resultado){
        //
        //add um membro, agora é necessario add a relação MEMBRO ~ IGREJA
        //
        $membro_igreja_nome = $obj->membro_igreja_nome;
        //
        $txt_dados = "";
        $txt_dados .= "(" . $membro_cpf . ",'" . $membro_igreja_nome . "')";
        //
        $sql = "INSERT INTO membro_igreja (cpf_membro, nome_igreja) VALUES " . $txt_dados;
        //
        $resultado = exQuery($conn,$sql);
    }
    //
    $saida = ["msg"=>$resultado]; //apenas para mandar sempre um json, aqui ainda não é um json
    //
    //
    echo json_encode($saida); //envio todos os dados encontrados em formato JSON
}
//**************************************************************//
//**************************************************************//
//
//FUNÇÕES PARA PASTOR
//
//**************************************************************//
//**************************************************************//
function mostraPastoresMesmo($conn,$obj){
    //
    // o $saida para CONSULTAS são diferentes do $saida das inserções
    //
    $membro_igreja_nome = $obj->membro_igreja_nome;
    $proc_pastor_nome   = $obj->proc_pastor_nome;
    //
    $condicao = "";

    if(!$membro_igreja_nome){
        $cond_igreja = "";
    }
    else{
        $cond_igreja = " AND igreja_pastor.nome_igreja = '" . $membro_igreja_nome . "'";
    }
    $condicao .= $cond_igreja;
    $condicao .= " AND membros.nome like '%" . $proc_pastor_nome . "%'";

    $sql = "SELECT membros.cpf cpf, membros.nome nome, membros.email email, membros.telefone telefone, membros.sexo sexo, membros.cidade cidade, membros.uf uf, membros.cep cep, membros.data_nasc data_nasc, membros.rua rua, membros.numero numero, membros.bairro bairro, membros.complemento complemento";
    $sql .= " FROM membros,igreja_pastor";
    $sql .= " WHERE membros.cpf = igreja_pastor.cpf_pastor" . $condicao;
    //
    $resultado = exQuery($conn,$sql);
    $saida = array();
    $saida = $resultado->fetch_all(MYSQLI_ASSOC);
    //
    //
    echo json_encode($saida); //envio todos os dados encontrados em formato JSON

}
function mostraPastores($conn,$obj){
    //
    //mostra as igrejas
    //$link é a conexao
    //
    $membro_nome = $obj->membro_nome;
    $nome_igreja = $obj->membro_igreja_nome;
    //
    $sql = "SELECT * FROM membros,membro_igreja WHERE membro_igreja.cpf_membro = membros.cpf AND membros.cpf NOT IN (SELECT cpf_pastor FROM igreja_pastor) AND membros.nome LIKE '%" .$membro_nome . "%'";
    //
    if($nome_igreja){
        //se uma igreja for selecionada...
        $sql .= " AND membro_igreja.nome_igreja = '" . $nome_igreja . "'";
    }
    //
    $resultado = exQuery($conn,$sql);
    $saida = array();
    $saida = $resultado->fetch_all(MYSQLI_ASSOC);
    //
    //$saida = ["msg"=>$sql];
    //
    //
    echo json_encode($saida); //envio todos os dados encontrados em formato JSON
}
function addPastor($conn,$obj){
    //
    //insere um pastor na tabela igreja_pastor.
    //
    //um pastor é um membro cujo CPF está na tabela IGREJA_PASTOR
    //
    //$link é a conexão
    //
    $pastores_cpf   = $obj->pastores_cpf; //membro q será o pastor
    //
    $pastor_igreja  = $obj->pastor_igreja; //igreja a qual ele (membro) é compromissado
    //
    $txt_dados  = "(" . $pastores_cpf . ",";
    $txt_dados  .= "'" . $pastor_igreja . "')";

    $sql = "INSERT INTO igreja_pastor (cpf_pastor, nome_igreja) VALUES " . $txt_dados;

    $resultado = exQuery($conn,$sql);
    //
    $saida = ["msg"=>mysqli_errno($conn)];
    //
    echo json_encode($saida); //envio todos os dados encontrados em formato JSON
}
//**************************************************************//
//**************************************************************//
//
//FUNÇÕES PARA CULTO
//
//**************************************************************//
//**************************************************************//
function mostraCulto($conn,$obj){
    //
    //mostra os cultos
    //
    $igreja_nome    = $obj->igreja_nome;
    $culto_data     = $obj->culto_data;
    $culto_preletor = $obj->culto_preletor;
    //
    $condicoes = "";
    //
    if($igreja_nome != 0){
        $condicoes .= " AND nome_igreja = '" . $igreja_nome . "'";
    }
    if($culto_data != ""){
        $condicoes .= " AND data like '%" . $culto_data . "%'";
    }
    if($culto_preletor != ""){
        $condicoes .= " AND preletor like '%" . $culto_preletor . "%'";
    }
    //
    $sql = "SELECT * FROM culto WHERE 1 " . $condicoes;
    //
    $resultado = exQuery($conn,$sql);
    $saida = array();
    $saida = $resultado->fetch_all(MYSQLI_ASSOC);
    //
    echo json_encode($saida);
}
//
function addCulto($conn,$obj){
    //add culto
    $igreja_nome        = $obj->igreja_nome;
    $culto_data         = $obj->culto_data;
    $culto_hora         = $obj->culto_hora;
    $culto_preletor     = $obj->culto_preletor;
    $culto_presentes    = $obj->culto_presentes;
    $culto_oferta       = $obj->culto_oferta;
    $culto_dizimo       = $obj->culto_dizimo;
    //
    $txt_dados  = "('" . $igreja_nome . "',";
    $txt_dados  .= "DATE('" . $culto_data . "'),";
    $txt_dados  .= "'" . $culto_hora . "',";
    $txt_dados  .= "'" . $culto_preletor . "',";
    $txt_dados  .= "" . $culto_presentes . ",";
    $txt_dados  .= "" . $culto_oferta . ",";
    $txt_dados  .= "" . $culto_dizimo . ")";

    $sql = "INSERT INTO culto (nome_igreja, data, horario, preletor, presentes, oferta, dizimo) VALUES " . $txt_dados;

    $resultado = exQuery($conn,$sql);
    //
    $saida = ["msg"=>mysqli_errno($conn)];
    //
    echo json_encode($saida); //envio todos os dados encontrados em formato JSON
}
//**************************************************************//
//**************************************************************//
//
//FUNÇÕES PARA CELULAS
//
//**************************************************************//
//**************************************************************//
function mostraCelulas($conn,$obj){

    $rede_cor = $obj->rede_cor;
    $nome_igreja = $obj->nome_igreja;
    $condicao = "";

    if($rede_cor != 0){
        $condicao .= " AND cor_rede = '" . $rede_cor . "'";
    }
    if($nome_igreja){
        $condicao .= " AND nome_igreja = '" . $nome_igreja . "'";
    }

    $sql = "SELECT * FROM rede_celula WHERE 1 " . $condicao;

    $saida = ["msg"=>$sql];


    //echo json_encode($saida);

    $resultado = exQuery($conn,$sql);
    $saida = array();
    $saida = $resultado->fetch_all(MYSQLI_ASSOC);
    //
    //
    echo json_encode($saida);
}
function mostraRedes_cel($conn,$obj){

    $nome_igreja = $obj->nome_igreja;


    $sql = "SELECT cor, lider FROM rede WHERE nome_igreja = '" . $nome_igreja . "'";

    $resultado = exQuery($conn,$sql);
    $saida = array();
    $saida = $resultado->fetch_all(MYSQLI_ASSOC);
    //
    //
    echo json_encode($saida);
}
//
function mostraCel($conn,$obj){
    //
    //mostra os cultos
    //
    $cel_nome   = $obj->cel_nome;
    $cel_cidade = $obj->cel_cidade;
    $cel_uf     = $obj->cel_uf;
    //
    $condicoes = "";
    //
    if($cel_nome != 0){
        $condicoes .= " AND nome like '%" . $cel_nome . "%'";
    }
    if($cel_cidade != ""){
        $condicoes .= " AND cidade like '%" . $cel_cidade . "%'";
    }
    if($cel_uf != "0"){
        $condicoes .= " AND uf = '" . $cel_uf . "'";
    }
    //
    $sql = "SELECT * FROM celula WHERE 1 " . $condicoes;
    //
    $resultado = exQuery($conn,$sql);
    $saida = array();
    $saida = $resultado->fetch_all(MYSQLI_ASSOC);
    //
    //
    echo json_encode($saida);
}
function addCel($conn,$obj){
    //add culto
    $cel_nome           = $obj->cel_nome;
    $cel_rua            = $obj->cel_rua;
    $cel_numero         = $obj->cel_numero;
    $cel_bairro         = $obj->cel_bairro;
    $cel_complemento    = $obj->cel_complemento;
    $cel_cidade         = $obj->cel_cidade;
    $cel_uf             = $obj->cel_uf;
    $cel_feira          = $obj->cel_feira;
    $cel_quantidade     = $obj->cel_quantidade;
    $rede_cor           = $obj->rede_cor;
    $membro_igreja_nome = $obj->membro_igreja_nome;
    //
    $txt_dados  = "('" . $cel_nome . "',";
    $txt_dados  .= "'" . $cel_rua . "',";
    $txt_dados  .= ""  . $cel_numero . ",";
    $txt_dados  .= "'" . $cel_bairro . "',";
    $txt_dados  .= "'" . $cel_complemento . "',";
    $txt_dados  .= "'" . $cel_cidade . "',";
    $txt_dados  .= "'" . $cel_uf . "',";
    $txt_dados  .= "'" . $cel_feira . "',";
    $txt_dados  .= ""  . $cel_quantidade . ")";

    $sql = "INSERT INTO celula (nome, rua, numero, bairro, complemento, cidade, uf, feira, n_membros) VALUES " . $txt_dados;

    $resultado = exQuery($conn,$sql);
    //
    //
    if($resultado){

        $txt_dados = "('" . $rede_cor . "',";
        $txt_dados .= "'" . $membro_igreja_nome . "',";
        $txt_dados .= "'" . $cel_nome . "',";
        $txt_dados .= "'" . $cel_cidade . "',";
        $txt_dados .= "'" . $cel_uf . "')";

        $sql = "INSERT INTO rede_celula (cor_rede,nome_igreja,nome_celula,cidade_celula,uf_celula) VALUES ". $txt_dados;

        $resultado = exQuery($conn,$sql);
    }
    //
    $saida = ["msg"=>mysqli_errno($conn)];
    //
    echo json_encode($saida); //envio todos os dados encontrados em formato JSON
}
//**************************************************************//
//**************************************************************//
//
//FUNÇÕES PARA REDES
//
//**************************************************************//
//**************************************************************//
function addRede($conn,$obj){
    //
    //função para add uma REDE
    //

    $rede_cor       = $obj->rede_cor;
    $igreja_nome    = $obj->igreja_nome;
    $membro_cpf     = $obj->membro_cpf;

    $txt_dados = "('" . $rede_cor . "',";
    $txt_dados .= "'" . $igreja_nome . "',";
    $txt_dados .= ""  . $membro_cpf . ")";

    $sql = "INSERT INTO rede (cor,nome_igreja,lider) VALUES " . $txt_dados;
    //
    $resultado = exQuery($conn,$sql);
    //
    $saida = ["msg"=>mysqli_errno($conn)];
    //
    echo json_encode($saida);
}

function mostraMembrosIgreja($conn, $obj){

    $nome_igreja  = $obj->nome_igreja;
    //
    $sql = "SELECT membros.nome nome, membros.cpf cpf FROM membros,membro_igreja WHERE membro_igreja.nome_igreja = '". $nome_igreja . "' AND membros.cpf = membro_igreja.cpf_membro";
    //
    $resultado = exQuery($conn,$sql);
    $saida = array();
    $saida = $resultado->fetch_all(MYSQLI_ASSOC);
    //
    //
    echo json_encode($saida);

}

function mostraRedes($conn, $obj){

    $nome_igreja = $obj->nome_igreja;
    $rede_cor = $obj->rede_cor;
    $lider_nome = $obj->lider_nome;

    $condicoes = "";
    //
    if($nome_igreja){
        $condicoes .= " AND rede.nome_igreja = '". $nome_igreja . "'" ;
    }
    if($rede_cor != ""){
        $condicoes .= " AND rede.cor like '%" . $rede_cor . "%'";
    }
    if($lider_nome != ""){
        $condicoes .= "AND membros.nome LIKE '%" . $lider_nome . "%'";
    }
    //
    $sql = "SELECT * FROM rede, membros where membros.cpf = rede.lider " . $condicoes;
    //

    //saida = ["msg",$sql];

    //echo json_encode($saida);
    $resultado = exQuery($conn,$sql);
    $saida = array();
    $saida = $resultado->fetch_all(MYSQLI_ASSOC);


    echo json_encode($saida);
}


$conn->close(); //sempre será executado se der um include ao "conecta.php"
?>
