<?php

include "conecta.php";

$ordem = $_POST["ordem"];

if($ordem == 1){
    addIgreja($link);
}

function exQuery($link, $txt){
    //função para executar uma query
    //$link é a conexão
    //$txt é a query

    $query = mysqli_query($link,$txt);

    if (!$query) {
        die('Invalid query: ' . mysql_error());
    }

}

function addIgreja($link){
    //
    //insere uma igreja
    //$link é a conexão
    //
    $igreja_nome        = $_POST["igreja_nome"];
    $igreja_qte_membros = $_POST["igreja_qte_membros"];
    $igreja_rua         = $_POST["igreja_rua"];
    $igreja_numero      = $_POST["igreja_numero"];
    $igreja_complemento = $_POST["igreja_complemento"];
    $igreja_cep         = $_POST["igreja_cep"];
    $igreja_bairro      = $_POST["igreja_bairro"];
    $igreja_cidade      = $_POST["igreja_cidade"];
    $igreja_uf          = $_POST["igreja_uf"];

    $txt_dados  = "('" . $igreja_nome . "',";
    $txt_dados  .= $igreja_qte_membros . ",";
    $txt_dados  .= "'" . $igreja_rua . "',";
    $txt_dados  .= $igreja_numero . ",";
    $txt_dados  .= "'" . $igreja_complemento . "',";
    $txt_dados  .= "'" . $igreja_bairro . "',";
    $txt_dados  .= "'" . $igreja_cidade . "',";
    $txt_dados  .= "'" . $igreja_uf . "',";
    $txt_dados  .= "'" . $igreja_cep . "')";

    $txt_query = "INSERT INTO igreja (nome,n_membros,rua,numero,complemento,bairro,cidade,uf,cep) VALUES " . $txt_dados;

    exQuery($link,$txt_query);

}





mysqli_close($link);
?>
