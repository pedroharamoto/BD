<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

require '../vendor/autoload.php';

$app = new \Slim\App;

$app->get('/', function (Request $request, Response $response, array $args) {
});

$app->post('/membro', function (Request $request, Response $response, array $args) {
	$data = $request->getParsedBody();
	$conn = getConnection();
	$stmt = $conn->prepare("insert into membro values(?, ?)");
	$stmt->bind_param('ss', $data['CPF'], $data["Nome"]);
	$stmt->execute();
	$stmt->close();
	$response->getBody()->write(json_encode($data));
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