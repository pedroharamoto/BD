function carregar(pagina){

  var corpo = $('#corpo');

  corpo.empty();
  corpo.load(pagina);
};
//
//
//
function show_culto(ordem,igreja_nome,culto_data,culto_preletor){
    //
    //função para mostrar os pastores
    //
    $("#mostra_culto").empty();
    //
    var dados = {
        "funcao" : ordem,
        "igreja_nome" : igreja_nome,
        "culto_data" : culto_data,
        "culto_preletor" : culto_preletor
    };
    //
    parametros = JSON.stringify(dados);
    //
    var n = 0;
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
            console.log(this.responseText);
            //
            retorno = JSON.parse(this.responseText); //vou analisar cada elemento JSON retornado
            //
            //
            if(retorno.length == 0 || retorno == ""){
                //não encontrou nenhum resultado
                texto_retorno += "<p>Não há CULTOS para esta igreja!";
            }
            else{
                //
                //encontrou
                //irei criar a tabela para mostrar o resultado da query
                //
                texto_retorno += '<table class="table table-striped" style="width:100%;"><thead><tr><th style="width:30%;">Preletor</th><th style="width:70%;">Igreja</th></tr></thead>';
                texto_retorno += '<tbody>';
                //
                for (i in retorno) {

                    n = parseInt(parseInt(i)+1);

                    texto_retorno += '<tr>';
                    texto_retorno += '<td><a role="button" data-toggle="collapse" href="#collapse'+n+'" aria-expanded="false" aria-controls="collapse'+n+'">';
                    texto_retorno += '' + retorno[i].preletor + '';
                    texto_retorno += '</a></td>';
                    texto_retorno +='<td>';

                    texto_retorno += '' + retorno[i].nome_igreja + '';
                    texto_retorno += '<div class="collapse" id="collapse'+n+'">';
                    texto_retorno +=    '<div class="well">';
                    texto_retorno +=        '<p class="recuo">';
                    texto_retorno +=            '<b>Data:</b> '+ retorno[i].data + '';
                    texto_retorno +=        '</p>';

                    texto_retorno +=        '<p class="recuo">';
                    texto_retorno +=            '<b>Horário:</b> '+ retorno[i].horario + '';
                    texto_retorno +=        '</p>';

                    texto_retorno +=        '<p class="recuo">';
                    texto_retorno +=            '<b>Presentes:</b> ' + retorno[i].presentes;
                    texto_retorno +=        '</p>';

                    texto_retorno +=        '<p class="recuo">';
                    texto_retorno +=            '<b>Oferta:</b> ' + retorno[i].oferta;
                    texto_retorno +=        '</p>';

                    texto_retorno +=        '<p class="recuo">';
                    texto_retorno +=            '<b>Dízimo:</b> ' + retorno[i].dizimo;
                    texto_retorno +=        '</p>';
                    texto_retorno +=    '</div>';
                    texto_retorno += '</div>';

                    texto_retorno += '</td>';

                    texto_retorno += '</tr>';

                }
                texto_retorno += '</tbody></table>';
            }
            $("#mostra_culto").append(texto_retorno);
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
//
//
function addCulto(ordem,igreja_nome,culto_data,culto_hora,culto_preletor,culto_presentes,culto_oferta,culto_dizimo){
    //
    //função para add um culto
    //
    //
    var dados = {
        "funcao" : ordem,
        "igreja_nome" : igreja_nome,
        "culto_data" : culto_data,
        "culto_hora" : culto_hora,
        "culto_preletor" : culto_preletor,
        "culto_presentes" : culto_presentes,
        "culto_oferta" : culto_oferta,
        "culto_dizimo" : culto_dizimo
    };
    //
    //
    parametros = JSON.stringify(dados);
    //
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
            console.log(retorno);
            //
            //
            retorno = JSON.parse(retorno);
            //
            if(retorno.msg == 0){
                texto_retorno = "Culto criado!";
            }
            else{
                if(retorno.msg == 1062){
                    texto_retorno = "Culto já existe!";
                }
            }
            $("#plot").empty();
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
//
//
function show_lideres(ordem,membro_igreja_nome,membro_nome){
    //
    //função para mostrar os pastores
    //
    $("#mostra_membros_igrejas").empty();
    //
    var dados = {
        "funcao" : ordem,
        "membro_igreja_nome" : membro_igreja_nome,
        "membro_nome" : membro_nome
    };
    //
    parametros = JSON.stringify(dados);
    //
    var n = 0;
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
            //console.log(retorno);
            //
            //
            if(retorno.length == 0 || retorno == ""){
                //não encontrou nenhum resultado
                texto_retorno += "<p>Não há LíDERES nesta igreja!";
            }
            else{
                //
                //encontrou
                //irei criar a tabela para mostrar o resultado da query
                //
                texto_retorno += '<table class="table table-striped" style="width:75%;"><thead><tr><th style="width:5%;">#</th><th style="width:95%;">Nome</th><th>&nbsp;</th></tr></thead>';
                texto_retorno += '<tbody>';
                //
                for (i in retorno) {

                    n = parseInt(parseInt(i)+1);

                    texto_retorno += '<tr>';
                    texto_retorno += '<td>'+ n +'</td>';
                    texto_retorno +='<td>';

                    texto_retorno += '<a role="button" data-toggle="collapse" href="#collapse'+n+'" aria-expanded="false" aria-controls="collapse'+n+'">';
                    texto_retorno += '' + retorno[i].nome + '';
                    texto_retorno += '</a>';

                    texto_retorno += '<div class="collapse" id="collapse'+n+'">';
                    texto_retorno +=    '<div class="well">';
                    texto_retorno +=        '<p class="recuo">';
                    texto_retorno +=            'CPF: '+ retorno[i].cpf + '<br>';
                    texto_retorno +=        '</p>';
                    texto_retorno +=        '<p class="recuo">';
                    texto_retorno +=            'Igreja: '+ retorno[i].nome_igreja + '<br>';
                    texto_retorno +=        '</p>';

                    texto_retorno +=        '<p class="recuo">';
                    texto_retorno +=            'Endereço: ' + retorno[i].rua + ', ' + retorno[i].numero;
                    texto_retorno +=            ', ' + retorno[i].bairro + ', ' + retorno[i].cep;
                    texto_retorno +=        '</p>';
                    texto_retorno +=    '</div>';

                    texto_retorno +=    '<div class="row">';

                    texto_retorno +=     '<input type="hidden" id="membro_ig'+retorno[i].cpf+'" value="'+retorno[i].nome_igreja+'" type="text">';

                    texto_retorno +=        '<div class="col-md-10">';
                    texto_retorno +=            '<div id="msg_pastor'+retorno[i].cpf+'"></div>';
                    texto_retorno +=        '</div>';

                    texto_retorno +=        '<div class="col-md-10">';
                    texto_retorno +=            '<div class="alinhamento">';
                    texto_retorno +=                '<input class="btn btn-success" id="btn_promover" onclick="envia2(78,'+retorno[i].cpf+')" type="button" value="Promover"></input>';
                    texto_retorno +=            '</div>';
                    texto_retorno +=        '</div>';

                    texto_retorno +=    '</div>';

                    texto_retorno += '</div>';
                    texto_retorno += '</td>';

                    texto_retorno += '</tr>';

                }
                texto_retorno += '</tbody></table>';
            }
            $("#mostra_membros_igrejas").append(texto_retorno);
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
//
//
function addPastor(ordem,pastores_cpf,pastor_membro_igreja){
    //função para add um pastor a uma igreja
    $("#plot").empty();
    //
    var dados = {
        "funcao" : ordem,
        "pastores_cpf" : pastores_cpf,
        "pastor_igreja" : pastor_membro_igreja
    }
    //
    parametros = JSON.stringify(dados);
    //
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
            //
            retorno = JSON.parse(retorno);
            console.log(retorno.msg);
            //
            if(retorno.msg == 0){
                texto_retorno = "Membro promovido!";
            }
            else{
                if(retorno.msg == 1062){
                    texto_retorno = "Membro já é pastor!";
                }
            }
            $("#msg_pastor"+pastores_cpf).empty();
            $("#msg_pastor"+pastores_cpf).append(texto_retorno);
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
//
//
function addMembro(ordem,membro_igreja_nome,membro_nome,membro_cpf,membro_nasc,membro_sexo,membro_email,membro_telefone,membro_rua,membro_numero,membro_complemento,membro_cep,membro_bairro,membro_cidade,membro_uf){
    //função para add um membro
    $("#plot").empty();
    //
    var dados = {
            "funcao" : ordem,
            "membro_igreja_nome" : membro_igreja_nome,
            "membro_nome" : membro_nome,
            "membro_cpf" : membro_cpf,
            "membro_nasc" : membro_nasc,
            "membro_sexo" : membro_sexo,
            "membro_email" : membro_email,
            "membro_telefone" : membro_telefone,
            "membro_rua" : membro_rua,
            "membro_numero" : membro_numero,
            "membro_complemento" : membro_complemento,
            "membro_cep" : membro_cep,
            "membro_bairro" : membro_bairro,
            "membro_cidade" : membro_cidade,
            "membro_uf" : membro_uf
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
                texto_retorno = "ERRO!<br>"+membro_cpf+" já existe!";
            }
            else{
                texto_retorno = "Membro " + membro_cpf + " cadastrado!";
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
//
//
function addIgreja(ordem,igreja_nome,igreja_qte_membros,igreja_rua,igreja_numero,igreja_complemento,igreja_cep,igreja_bairro,igreja_cidade,igreja_uf){
    //função para add uma igreja
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
    //
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
function show_lista_igrejas(){
    //
    //função para listar as igrejas na pagina de membros
    //
    var dados = {
            "funcao" : 2
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
            //
            retorno = JSON.parse(this.responseText); //vou analisar cada elemento JSON retornado
            //
            //
            texto_retorno += '<select class="form-control" name="membro_igreja_nome" id="membro_igreja_nome">';
            if(retorno.length == 0){
                //não encontrou nenhum resultado
                texto_retorno += "<option value=0>Não há igrejas cadastradas!</option>";
            }
            else{
                //
                //encontrou
                //irei criar a tabela para mostrar o resultado da query
                //
                //
                texto_retorno += '<option value=0>Selecione a igreja</option>';
                for (i in retorno) {
                    texto_retorno += '<option value="'+retorno[i].nome+'">'+retorno[i].nome+','+retorno[i].cidade+ '</option>';
                }
            }
            texto_retorno += '</select>';
            $("#lista_igrejas").append(texto_retorno);
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
function show_pastores_mesmo(ordem,membro_igreja_nome,proc_pastor_nome){
    //
    //função para mostrar os pastores
    //
    $("#mostra_pastores").empty();
    //
    var dados = {
        "funcao" : ordem,
        "membro_igreja_nome" : membro_igreja_nome,
        "proc_pastor_nome" : proc_pastor_nome
    };
    //
    parametros = JSON.stringify(dados);
    //
    var n = 0;
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

            console.log(this.responseText);

            retorno = JSON.parse(this.responseText); //vou analisar cada elemento JSON retornado
            //
            //
            if(retorno.length == 0 || retorno == ""){
                //não encontrou nenhum resultado
                texto_retorno += "<p>Não há PASTORES nesta igreja!";
            }
            else{
                //
                //encontrou
                //irei criar a tabela para mostrar o resultado da query
                //
                texto_retorno += '<table class="table table-striped" style="width:100%;"><thead><tr><th style="width:5%;">#</th><th style="width:95%;">Nome</th></tr></thead>';
                texto_retorno += '<tbody>';
                //
                for (i in retorno) {

                    n = parseInt(parseInt(i)+1);

                    texto_retorno += '<tr>';
                    texto_retorno += '<td>'+ n +'</td>';
                    texto_retorno +='<td>';

                    texto_retorno += '<a role="button" data-toggle="collapse" href="#collapse'+n+'" aria-expanded="false" aria-controls="collapse'+n+'">';
                    texto_retorno += '' + retorno[i].nome + '';
                    texto_retorno += '</a>';

                    texto_retorno += '<div class="collapse" id="collapse'+n+'">';
                    texto_retorno +=    '<div class="well">';
                    texto_retorno +=        '<p class="recuo">';
                    texto_retorno +=            'CPF: '+ retorno[i].cpf + '<br>';
                    texto_retorno +=        '</p>';
                    texto_retorno +=        '<p class="recuo">';
                    texto_retorno +=            'Igreja: '+ retorno[i].nome_igreja + '<br>';
                    texto_retorno +=        '</p>';

                    texto_retorno +=        '<p class="recuo">';
                    texto_retorno +=            'Endereço: ' + retorno[i].rua + ', ' + retorno[i].numero;
                    texto_retorno +=            ', ' + retorno[i].bairro + ', ' + retorno[i].cep;
                    texto_retorno +=        '</p>';
                    texto_retorno +=    '</div>';

                    texto_retorno +=    '<div class="row">';

                    texto_retorno +=    '</div>';

                    texto_retorno += '</div>';
                    texto_retorno += '</td>';

                    texto_retorno += '</tr>';

                }
                texto_retorno += '</tbody></table>';
            }
            $("#mostra_pastores").append(texto_retorno);
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
function show_pastores(ordem,membro_igreja_nome,membro_nome){
    //
    //função para mostrar os pastores
    //
    $("#mostra_membros_igrejas").empty();
    //
    var dados = {
        "funcao" : ordem,
        "membro_igreja_nome" : membro_igreja_nome,
        "membro_nome" : membro_nome
    };
    //
    parametros = JSON.stringify(dados);
    //
    var n = 0;
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
            //console.log(retorno);
            //
            //
            if(retorno.length == 0 || retorno == ""){
                //não encontrou nenhum resultado
                texto_retorno += "<p>Não há PASTORES nesta igreja!";
            }
            else{
                //
                //encontrou
                //irei criar a tabela para mostrar o resultado da query
                //
                texto_retorno += '<table class="table table-striped" style="width:100%;"><thead><tr><th style="width:5%;">#</th><th style="width:95%;">Nome</th></tr></thead>';
                texto_retorno += '<tbody>';
                //
                for (i in retorno) {

                    n = parseInt(parseInt(i)+1);

                    texto_retorno += '<tr>';
                    texto_retorno += '<td>'+ n +'</td>';
                    texto_retorno +='<td>';

                    texto_retorno += '<a role="button" data-toggle="collapse" href="#collapse'+n+'" aria-expanded="false" aria-controls="collapse'+n+'">';
                    texto_retorno += '' + retorno[i].nome + '';
                    texto_retorno += '</a>';

                    texto_retorno += '<div class="collapse" id="collapse'+n+'">';
                    texto_retorno +=    '<div class="well">';
                    texto_retorno +=        '<p class="recuo">';
                    texto_retorno +=            'CPF: '+ retorno[i].cpf + '<br>';
                    texto_retorno +=        '</p>';
                    texto_retorno +=        '<p class="recuo">';
                    texto_retorno +=            'Igreja: '+ retorno[i].nome_igreja + '<br>';
                    texto_retorno +=        '</p>';

                    texto_retorno +=        '<p class="recuo">';
                    texto_retorno +=            'Endereço: ' + retorno[i].rua + ', ' + retorno[i].numero;
                    texto_retorno +=            ', ' + retorno[i].bairro + ', ' + retorno[i].cep;
                    texto_retorno +=        '</p>';
                    texto_retorno +=    '</div>';

                    texto_retorno +=    '<div class="row">';

                    texto_retorno +=     '<input type="hidden" id="membro_ig'+retorno[i].cpf+'" value="'+retorno[i].nome_igreja+'" type="text">';

                    texto_retorno +=        '<div class="col-md-10">';
                    texto_retorno +=            '<div id="msg_pastor'+retorno[i].cpf+'"></div>';
                    texto_retorno +=        '</div>';

                    texto_retorno +=        '<div class="col-md-10">';
                    texto_retorno +=            '<div class="alinhamento">';
                    texto_retorno +=                '<input class="btn btn-success" id="btn_promover" onclick="envia2(88,'+retorno[i].cpf+')" type="button" value="Promover"></input>';
                    texto_retorno +=            '</div>';
                    texto_retorno +=        '</div>';

                    texto_retorno +=    '</div>';

                    texto_retorno += '</div>';
                    texto_retorno += '</td>';

                    texto_retorno += '</tr>';

                }
                texto_retorno += '</tbody></table>';
            }
            $("#mostra_membros_igrejas").append(texto_retorno);
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
function show_membros(ordem,membro_igreja_nome,membro_nome){
    //
    //função para mostrar os membros de uma igreja
    //
    $("#mostra_membros_igrejas").empty();
    //
    var dados = {
            "funcao" : ordem,
            "membro_igreja_nome" : membro_igreja_nome,
            "membro_nome" : membro_nome
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
            if(retorno.length == 0 || retorno == ""){
                //não encontrou nenhum resultado
                texto_retorno += "<p>Não há membros nesta igreja!";
            }
            else{
                //
                //encontrou
                //irei criar a tabela para mostrar o resultado da query
                //
                texto_retorno += '<table class="table table-striped"><thead><tr><th>#</th><th>Nome</th><th>CPF</th></tr></thead>';
                texto_retorno += '<tbody>';
                //
                for (i in retorno) {

                    texto_retorno += '<tr>';
                    texto_retorno += '<td>';
                    texto_retorno += '<td>'+ parseInt(parseInt(i)+1) +'</td>';
                    texto_retorno +='<td>'+retorno[i].nome+'</td>';
                    texto_retorno +='<td>'+retorno[i].cpf+'</td>';
                    texto_retorno += '</tr>';

                }
                texto_retorno += '</tbody></table>';
            }
            $("#mostra_membros_igrejas").append(texto_retorno);
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

                    texto_retorno += '<tr>';
                    texto_retorno += '<td>';
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
function envia2(ordem,cpf){

    if(ordem == 88){ //add um pastor a igreja
        //
        var pastores_cpf = cpf;
        var pastor_membro_igreja = $("#membro_ig"+cpf).val();
        //
        //alert(pastores_cpf + " " + pastores_data_posse + " " + pastores_empossador + " " + pastor_igreja);
        //
        addPastor(ordem,pastores_cpf,pastor_membro_igreja);
    }
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
    else if(ordem == 3){ //adc membro

        var membro_igreja_nome  = $("#membro_igreja_nome").val();
        var membro_nome         = $("#membro_nome").val();
        var membro_cpf          = $("#membro_cpf").val();
        var membro_nasc         = $("#membro_nasc").val();
        var membro_sexo         = $("#membro_sexo").val();
        var membro_email        = $("#membro_email").val();
        var membro_telefone     = $("#membro_telefone").val();
        var membro_rua          = $("#membro_rua").val();
        var membro_numero       = $("#membro_numero").val();
        var membro_complemento  = $("#membro_complemento").val();
        var membro_cep          = $("#membro_cep").val();
        var membro_bairro       = $("#membro_bairro").val();
        var membro_cidade       = $("#membro_cidade").val();
        var membro_uf           = $("#membro_uf").val();
        //
        if(membro_igreja_nome == 0){
            alert('É necessário escolher uma igreja');
            $("#membro_igreja_nome").focus();
            return;
        }
        if(membro_sexo == 0){
            alert('É necessário informar o sexo');
            $("#membro_sexo").focus();
            return;
        }
        if(membro_nome == "") {
        	alert('Insira o nome completo.');
        	$("#membro_nome").focus();
            return;
        }
        //nao ta funcionando ou eu nao sei o meu cpf IUHDSAD,ASDASHKJSAHDAKJSHDSAKJH
        if (checa_cpf(membro_cpf) == false) {
        	alert('CPF inválido.');
        	$("#membro_cpf").focus();
            return;
        }
        if (membro_sexo == 0) {
        	alert('Por favor, escolha um sexo.');
        	$("#membro_sexo").focus();
            return;
        }
        if (membro_uf == 0) {
        	alert('Por favor, selecione um estado.');
        	$("#membro_uf").focus();
            return;
        }
        if (membro_cidade == ""){
        	alert('Cidade inválida.');
        	$("#membro_cidade").focus();
            return;
        }
        if (membro_bairro == ""){
        	alert('Bairro inválido.');
        	$("#membro_bairro").focus();
            return;
        }
        if (membro_cep.toString().length != 12){
        	alert('CEP inválido.');
        	$("#membro_cep").focus();
            return;
        }
        if (membro_numero == "") {
        	alert('Insira um número.');
        	$("#membro_numero").focus();
            return;
        }
        if (membro_rua == "") {
        	alert('Insira uma rua.');
        	$("#membro_rua").focus();
            return;
        }
        if (membro_telefone == "") {
        	alert('Insira um telefone.');
        	$("#membro_telefone").focus();
            return;
        }

        //data_nasc vai ser só confiança na máscara mesmo

        addMembro(ordem,membro_igreja_nome,membro_nome,membro_cpf,membro_nasc,membro_sexo,membro_email,membro_telefone,membro_rua,membro_numero,membro_complemento,membro_cep,membro_bairro,membro_cidade,membro_uf);
    }
    else if(ordem == 57){ //procura um membro de uma igreja dada
        //
        var membro_igreja_nome = $("#membro_igreja_nome").val();
        var membro_nome = $("#proc_membro_nome").val();
        //
        if (!membro_nome){
            membro_nome = "";
        }
        //
        //
        show_membros(ordem,membro_igreja_nome,membro_nome);
    }
    else if(ordem == 58){ //procura membros não pastores
        //
        var membro_igreja_nome = $("#membro_igreja_nome").val();
        var membro_nome = $("#proc_membro_nome").val();
        //
        if (!membro_nome){
            membro_nome = "";
        }
        //
        show_pastores(ordem,membro_igreja_nome,membro_nome);
    }
    else if(ordem == 59){ //procura membros pastores
        //
        var membro_igreja_nome = $("#membro_igreja_nome").val();
        var proc_pastor_nome = $("#proc_pastor_nome").val();
        //
        if (!membro_nome){
            membro_nome = "";
        }
        //
        show_pastores_mesmo(ordem,membro_igreja_nome,proc_pastor_nome);
    }
    else if(ordem == 68){ //procura membros não líderes
        //
        var membro_igreja_nome = $("#membro_igreja_nome").val();
        var membro_nome = $("#proc_membro_nome").val();
        //
        if (!membro_nome){
            membro_nome = "";
        }
        //
        show_pastores(ordem,membro_igreja_nome,membro_nome);
    }
    else if(ordem == 123){ //add um culto
        //
        var igreja_nome     = $("#membro_igreja_nome").val();
        var culto_data      = $("#culto_data").val();
        var culto_hora      = $("#culto_horario").val();
        var culto_preletor  = $("#culto_preletor").val();
        var culto_presentes = $("#culto_presentes").val();
        var culto_oferta    = $("#culto_oferta").val();
        var culto_dizimo    = $("#culto_dizimo").val();
        //
        addCulto(ordem,igreja_nome,culto_data,culto_hora,culto_preletor,culto_presentes,culto_oferta,culto_dizimo);
    }
    else if(ordem == 124){ //mostra cultos de igrejas e datas
        //
        var igreja_nome     = $("#membro_igreja_nome").val();
        var culto_data      = $("#culto_data").val();
        var culto_preletor  = $("#culto_preletor").val();
        //
        show_culto(ordem,igreja_nome,culto_data,culto_preletor);
    }


}
function checa_cpf(cpf) {
	//lista de CPFs inválidos, mas não por causa da fórmula
    var cpf = cpf.toString();
    //
	if (cpf == "00000000000" || cpf == "11111111111" ||cpf == "22222222222" ||cpf == "33333333333" ||cpf == "44444444444" ||cpf == "55555555555" ||cpf == "66666666666" ||cpf == "77777777777" ||cpf == "88888888888" ||cpf == "99999999999") {
		return false;
	}

	var soma = 0;
	var resto = 0;
	var j = 0;

	//1ª parte da verificação
	for (var i = 10; i > 1; i--){
		soma+=parseInt(cpf[j++])*i;
    }

    resto = (soma*10)%11;

    if (resto == 10){
		resto = 0;
	}
    if (parseInt(cpf[j]) != resto){
		return false;
    }
	//2ª parte da verificação
	soma = 0;
	j = 0;

	for (var i = 11; i > 1; i--){
		soma += parseInt(cpf[j++])*i;
	}
	resto = (soma*10)%11;
    if (resto == 10){
		resto = 0;
	}
    if (parseInt(cpf[j]) != resto){
		return false;
    }
	return true;
}
