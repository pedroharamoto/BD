<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

require '../vendor/autoload.php';

$app = new \Slim\App;

$app->get('/', function (Request $request, Response $response, array $args) {
});

$app->post('/membro', function (Request $request, Response $response, array $args) {
	$data = $request->getParsedBody();
	$mysqli = getConnection();
	$stmt = $mysqli->prepare("insert into membros values(?, ?)");
	$stmt->bind_param("ss", $data["cpf"], $data["nome"]);
	if($stmt->execute()){
		$response->getBody()->write(json_encode('{"response" : "OK"}'));
	} else {
		$response->getBody()->write($stmt->error);
	}
	$stmt->close();
	$mysqli->close();
	return $response;
});

function getConnection() {
	$servername = "localhost";
	$username = "root";
	$password = "";
	$dbname = "trabalho_bd";

	// Create connection
	$conn = new mysqli($servername, $username, $password, $dbname);

	// Check connection
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	} 
	return $conn;
}

$app->run();	