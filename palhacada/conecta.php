<?php
//$link é a variaveis de conexão
//mysqli_conect("127.0.0.1","usuario","senha","BASE")
$link = mysqli_connect("localhost", "root", "", "bd1");

if (!$link) {
    echo "Error: Falha ao conectar-se com o banco de dados MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    exit;
}

//echo "Sucesso: Sucesso ao conectar-se com a base de dados MySQL." . PHP_EOL;


//mysqli_close($link); é preciso adicionar essa linha no query.php
?>
