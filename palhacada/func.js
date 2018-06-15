function carregar(pagina){

  var corpo = $('#corpo');

  corpo.empty();
  corpo.load(pagina);
};

function addIgreja(ordem,igreja_nome,igreja_qte_membros,igreja_rua,igreja_numero,igreja_complemento,igreja_cep,igreja_bairro,igreja_cidade,igreja_uf){
    //
    $("#plot").empty();
    //
    var dados = {
            "funcao" : ordem,
            "igreja_nome" : igreja_nome,
            "igreja_qte_membros" : igreja_qte_membros,
            "igreja_rua" : igreja_rua,
            "igreja_numero" : igreja_numero,
            "igreja_complemento" : igreja_complemento,
            "igreja_cep" : igreja_cep,
            "igreja_bairro" : igreja_bairro,
            "igreja_cidade" : igreja_cidade,
            "igreja_uf" : igreja_uf
    };
    parametros = JSON.stringify(dados);

    var texto_retorno = "";
    //
    var xmlhttp = new XMLHttpRequest();
    //
    //aqui estará o retorno
    //
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            retorno = this.responseText;
            //
            retorno = JSON.parse(retorno);
            //
            if(retorno.msg === false){
                texto_retorno = "ERRO!<br>"+igreja_nome+" já existe!";
            }
            else{
                console.log(retorno);
                texto_retorno = "Igreja " + igreja_nome + " cadastrada!";
            }
            //
            $("#plot").append(texto_retorno);
        }
    };
    //
    //
    //
    xmlhttp.open("POST", "query.php", true); //abro o arquivo PHP
    xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xmlhttp.send("data=" + parametros); //passo os dados(json) para o arquivo
}
//
function show_igrejas(){
    //
    //função para mostrar as igrejas cadastradas
    //
    $("#mostra_igrejas").empty();//limpo a div q irá mostrar
    var igreja_nome = $("#igreja_nome").val();

    if(!igreja_nome){
        igreja_nome = "";
    }
    //
    var dados = {
            "funcao" : 2,
            "igreja_nome" : igreja_nome
    };
    //
    parametros = JSON.stringify(dados);
    //
    var texto_retorno = ""; //corpo da div
    //
    //aqui vai começar o codigo para o AJAX-PHP
    //
    var xmlhttp = new XMLHttpRequest();
    //
    //aqui estará o retorno
    //
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            //
            //recebo todos o resultado da query realizada, em formato JSON
            //
            retorno = JSON.parse(this.responseText); //vou analisar cada elemento JSON retornado
            //
            //
            if(retorno.length == 0){
                //não encontrou nenhum resultado
                texto_retorno += "<p>Não há igrejas cadastradas!";
            }
            else{
                //
                //encontrou
                //irei criar a tabela para mostrar o resultado da query
                //
                texto_retorno += '<table class="table table-striped"><thead><tr><th>#</th><th>Nome</th><th>Cidade</th></tr></thead>';
                texto_retorno += '<tbody>';
                //
                for (i in retorno) {

                    texto_retorno += '<td>'+ parseInt(parseInt(i)+1) +'</td>';
                    texto_retorno +='<td>'+retorno[i].nome+'</td>';
                    texto_retorno +='<td>'+retorno[i].cidade+'</td>';
                    texto_retorno += '</tr>';

                }
                texto_retorno += '</tbody></table>';
            }
            $("#mostra_igrejas").append(texto_retorno);
        }
    };
    //
    //
    //
    xmlhttp.open("POST", "query.php", true); //abro o arquivo PHP
    xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xmlhttp.send("data=" + parametros); //passo os dados(json) para o arquivo
}
//
function envia(ordem){

    if(ordem == 1){ //adc igreja

        var igreja_nome = $("#igreja_nome").val();
        var igreja_qte_membros = $("#igreja_qte_membros").val();
        var igreja_rua = $("#igreja_rua").val();
        var igreja_numero = $("#igreja_numero").val();
        var igreja_complemento = $("#igreja_complemento").val();
        var igreja_cep = $("#igreja_cep").val();
        var igreja_bairro = $("#igreja_bairro").val();
        var igreja_cidade = $("#igreja_cidade").val();
        var igreja_uf = $("#igreja_uf").val();

        addIgreja(ordem,igreja_nome,igreja_qte_membros,igreja_rua,igreja_numero,igreja_complemento,igreja_cep,igreja_bairro,igreja_cidade,igreja_uf);
    }
}
