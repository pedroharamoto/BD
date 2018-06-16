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

    $sql = "SELECT membros.nome nome, membros.cpf cpf FROM membros,membro_igreja WHERE " . $condicao;
    //
    $resultado = exQuery($conn,$sql);
    $saida = array();
    $saida = $resultado->fetch_all(MYSQLI_ASSOC);
    //
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
function mostraPastores($conn,$obj){
    //
    //mostra as igrejas
    //$link é a conexao
    //
    $membro_nome = $obj->membro_nome;
    //
    $sql = "SELECT * FROM membros,membro_igreja WHERE membro_igreja.cpf_membro = membros.cpf AND membros.cpf NOT IN (SELECT cpf_pastor FROM igreja_pastor) AND membros.nome LIKE '%" .$membro_nome . "%'";
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





$conn->close(); //sempre será executado se der um include ao "conecta.php"
?>
