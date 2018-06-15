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
    $txt_dados  .= $igreja_numero . ",";
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
    $txt_dados  .= "" . $membro_nasc . ",";
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
    $saida = ["msg"=>$resultado]; //apenas para mandar sempre um json, aqui ainda não é um json
    //
    //
    echo json_encode($saida); //envio todos os dados encontrados em formato JSON
}

function mostraMembro(){

}















$conn->close(); //sempre será executado se der um include ao "conecta.php"
?>
