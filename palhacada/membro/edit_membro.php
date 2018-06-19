
<?php

 include '../conecta.php';


 $sql = "SELECT * FROM membros,membro_igreja WHERE membros.cpf=membro_igreja.cpf_membro AND cpf = " . $_POST['membro_cpf'];

 $resultado = $conn->query($sql);
 $saida = array();
 $saida = $resultado->fetch_all(MYSQLI_ASSOC);


$ufs = ["AC","AL","AP","AM","BA","CE","DF","ES","GO","MA",
"MT","MS","MG","PA","PB","PR","PE","PI","RJ","RN","RS","RO","RR","SC","SP","SE","TO"];

?>

<!-- CORPO DO SITE -->

<div class="row border-bot">
  <div class="col-md-12">
      <p></p>
  </div>
</div>

<div class="row">

  <div class="col-md-12">

    <div class="row">

        <div class="row">
          <div class="col-md-6">
            <div class="input-group">
              <span class="input-group-addon" id="basic-addon1">Nome:</span>
              <input value="<?php echo $saida[0]["nome"]; ?>" id="membro_nome" type="text" class="form-control" placeholder="Nome do Membro" aria-describedby="basic-addon1">
            </div>
          </div>
          <div class="col-md-2">
            <div class="input-group">
              <span class="input-group-addon" id="basic-addon1">CPF:</span>
              <input id="membro_cpf" value="<?php echo $saida[0]["cpf"] ?>" type="text" class="form-control" placeholder="CPF" aria-describedby="basic-addon1">
            </div>
          </div>

          <div class="col-md-3">
              <div class="input-group">
                  <span class="input-group-addon" id="basic-addon1">Sexo:</span>
                  <select class="form-control" name="membro_sexo" id="membro_sexo">
                      <?php
                        if($saida[0]["sexo"] == 'F'){
                            $opt = '<option value="F" selected>Feminino</option>';
                            $opt .= '<option value="M">Masculino</option>';
                        }
                        else{
                            $opt = '<option value="F">Feminino</option>';
                            $opt .= '<option value="M" selected>Masculino</option>';
                        }
                       ?>
                      <option value="0">Selecione o Sexo</option>
                      <?php

                        echo $opt;

                       ?>
                  </select>
              </div>
          </div>
        </div>

        <div class="row">
          <p></p>
        </div>

        <div class="row">

            <div class="col-md-5">
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">E-mail:</span>
                    <input value="<?php echo $saida[0]["email"]; ?>" id="membro_email" type="text" class="form-control" placeholder="E-mail do Membro" aria-describedby="basic-addon1">
                </div>
            </div>

            <div class="col-md-3">
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">Telefone:</span>
                    <input value="<?php echo $saida[0]["telefone"]; ?>" id="membro_telefone" type="text" class="form-control" placeholder="Telefone" aria-describedby="basic-addon1">
                </div>
            </div>

            <div class="col-md-3">
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">Data:</span>
                    <input value="<?php echo $saida[0]["data_nasc"] ?>" id="membro_nasc" type="text" class="form-control" placeholder="Data de Nascimento" aria-describedby="basic-addon1">
                </div>
            </div>

        </div>

        <div class="row">
          <p></p>
        </div>

        <div class="row">

            <div class="col-md-5">
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">Rua:</span>
                    <input value="<?php echo $saida[0]["rua"]; ?>" id="membro_rua" type="text" class="form-control" placeholder="Rua do Membro" aria-describedby="basic-addon1">
                </div>
            </div>


            <div class="col-md-2">
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">N°:</span>
                    <input value="<?php echo $saida[0]["numero"]; ?>" id="membro_numero" type="text" class="form-control" placeholder="Número" aria-describedby="basic-addon1">
                </div>
            </div>

            <div class="col-md-5">
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">Complemento:</span>
                    <input value="<?php echo $saida[0]["complemento"]; ?>" id="membro_complemento" type="text" class="form-control" placeholder="Complemento do Endereço da Igreja" aria-describedby="basic-addon1">
                </div>
            </div>
        </div>

        <div class="row">
          <p></p>
        </div>

        <div class="row">
            <div class="col-md-4">
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">CEP:</span>
                    <input value="<?php echo $saida[0]["cep"]; ?>" id="membro_cep" type="text" class="form-control" placeholder="CEP do Membro" aria-describedby="basic-addon1">
                </div>
            </div>
        </div>

        <div class="row">
          <p></p>
        </div>

        <div class="row">

            <div class="col-md-5">
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">Bairro:</span>
                    <input value="<?php echo $saida[0]["bairro"]; ?>" id="membro_bairro" type="text" class="form-control" placeholder="Bairro do Membro" aria-describedby="basic-addon1">
                </div>
            </div>
            <div class="col-md-3">
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">Cidade:</span>
                    <input value="<?php echo $saida[0]["cidade"]; ?>" id="membro_cidade" type="text" class="form-control" placeholder="Cidade do Membro" aria-describedby="basic-addon1">
                </div>
            </div>
            <div class="col-md-4">
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">UF:</span>
                        <?php

                            $opt = '<select class="form-control" name="membro_uf" id="membro_uf">';
                            $opt .= '<option value="0">Selecione o Estado</option>';

                            foreach ($ufs as $uf) {
                                if($saida[0]["uf"] == $uf){
                                    $opt .= '<option value="' . $uf . '" selected>' .$uf . '</option>';
                                }
                                else{
                                    $opt .= '<option value="' . $uf . '">' .$uf . '</option>';
                                }
                            }
                            $opt .= '</select>';
                            echo $opt;
                        ?>
                </div>
            </div>
        </div>

        <div class="row">
            <p></p>
        </div>

        <div class="row">
            <div class="col-md-5">
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">Igreja:</span>
                    <?php

                    $sql = "SELECT nome FROM igreja";

                    $busc_igreja = $conn->query($sql);
                    $igrejas = array();
                    $igrejas = $busc_igreja->fetch_all(MYSQLI_ASSOC);
                    //
                    $opt = '<select class="form-control" name="membro_igreja" id="membro_igreja">';
                    $opt .= '<option value="0">Selecione a Igreja</option>';
                    //
                    foreach ($igrejas as $ig) {
                        if($ig["nome"] == $saida[0]["nome_igreja"]){
                            $opt .= '<option value="' . $ig["nome"] . '" selected>' .$ig["nome"] . '</option>';
                        }
                        else{
                            $opt .= '<option value="' . $ig["nome"] . '">' .$ig["nome"] . '</option>';
                        }
                    }
                    $opt .= '</select>';

                    echo $opt;

                    ?>
                </div>
            </div>

            <div class="col-md-4">
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">Células:</span>
                        <div id="lista_celulas">

                        </div>
                </div>
            </div>

            <div class="col-md-2">
                  <input class="btn btn-success" id="btn_salva_celula" onclick="envia(584)" type="button" value="Salva"></input>
            </div>


        </div>

    </div>

    <div class="row">
      <p></p>
    </div>
    <div class="row">
      <div class="col-md-6">
      </div>
      <div class="col-md-6">
        <div class="alinhamento">
          <input class="btn btn-success" id="btn_edit_membro" onclick="envia(33)" type="button" value="Editar"></input>
        </div>
      </div>
    </div>

    <div class="row">
      <p></p>
    </div>
    <div class="row">
      <div class="col-md-12">
        <a role="button" data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
          + Info
        </a>
        <div class="collapse" id="collapseExample">
          <div class="well">
            <p class="recuo">
                PÁGINA PARA EDITAR UM MEMBRO.
            </p>
          </div>
        </div>
      </div>
    </div>

  </div>

</div>

<div class="row">
    <div class="col-md-5">
        <p></p>
    </div>
    <div class="col-md-1">
        <p></p>
    </div>
    <div class="col-md-6">
        <div id="plot">
            <!-- retorno do ajax -->
        </div>
    </div>
</div>
<script type='text/javascript'>

    $(document).ready(function() {

        $("#membro_igreja").change(function(){
            show_lista_celula_igreja($(this).val());
        });

    });

    function show_lista_celula_igreja(nome_igreja){
        //
        //função para listar as igrejas na pagina de membros
        //
        $("#lista_celulas").empty();
        //
        var dados = {
                "funcao" : 978,
                "nome_igreja" : nome_igreja
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
                console.log(this.responseText);
                //
                retorno = JSON.parse(this.responseText); //vou analisar cada elemento JSON retornado
                //
                //
                var j = 0;
                //
                texto_retorno += '<select class="form-control" name="celulas" id="celulas">';
                if(retorno.length == 0){
                    //não encontrou nenhum resultado
                    texto_retorno += "<option value=0>Não há celulas cadastradas!</option>";
                }
                else{
                    //
                    //encontrou
                    //irei criar a tabela para mostrar o resultado da query
                    //
                    //
                    texto_retorno += '<option value=0>Selecione a célula</option>';
                    for (i in retorno) {
                        j = j + 1;
                        texto_retorno += '<option value="'+j+'">'+retorno[i].nome_celula+','+retorno[i].cidade_celula+ ' - ' + retorno[i].uf_celula + '</option>';
                    }
                    j = 0;
                    for(i in retorno){
                        j = j + 1;
                        texto_retorno += '<input type="hidden" value="'+retorno[i].nome_celula+'" id="nome_cel'+j+'">';
                        texto_retorno += '<input type="hidden" value="'+retorno[i].cidade_celula+'" id="cidade_cel'+j+'">';
                        texto_retorno += '<input type="hidden" value="'+retorno[i].uf_celula+'" id="uf_cel'+j+'">';
                    }
                }
                texto_retorno += '</select>';
                $("#lista_celulas").append(texto_retorno);

            }
        };
        //
        //
        //
        xmlhttp.open("POST", "query.php", true); //abro o arquivo PHP
        xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xmlhttp.send("data=" + parametros); //passo os dados(json) para o arquivo
    }
</script>
<?php


$conn->close(); //sempre será executado se der um include ao "conecta.php"

 ?>
