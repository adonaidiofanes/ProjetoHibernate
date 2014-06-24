$(document).ready(function() {

	/* ====================================================================
	 *  MASCARAS
	 * ==================================================================== */
	$(".dataHora").mask("99/99/9999 99:99:99");
	
	/* ====================================================================
	 *  BUSCAR REPORTE : MAPA
	 * ==================================================================== */
    $('#frmBuscarReporte #Buscar').click(function(e){
    	e.preventDefault();
        
    	var Controle = $("#Controle").val();
    	var slcServico = $("#slcServico").val();
    	
    	$.ajax({
            type: "POST",
            data: { Controle:Controle, slcServico:slcServico },
             
            url: "/ProjetoHibernate/ReporteServlet.do",
            dataType: "json",
            success: function(result){
            	$('#ajaxModal').modal('hide');
            	if( result.length > 0 ){
            		carregarPontos(result);
            	} else {
            		if( $("#modalRetorno") ){
            			$("#modalRetorno").remove();
            		}
            		$tplModal = $tplModalSmall.replace("@mensagem", "Nenhuma equipe encontrada!");
            		$("body").append($tplModal);
            		$('#modalRetorno').modal('show');
            		initialize();
            	}
            },
            beforeSend: function(){
            	if( $("#ajaxModal") ){ $("#ajaxModal").remove(); }
            	$("body").append($tplAjaxLoad);
                $('#ajaxModal').modal('show');
            },
        });
    });
   
	/* ====================================================================
	 *  BUSCAR ATENDIMENTO : MAPA
	 * ==================================================================== */
    $("#frmBuscarAgendamento #Buscar").click(function(e){
    	e.preventDefault();
        
    	var Controle = $("#Controle").val();
    	var slcServico = $("#slcServico").val();
    	
    	$.ajax({
            type: "POST",
            data: { Controle:Controle, slcServico:slcServico },
             
            url: "/ProjetoHibernate/AtendimentoServlet.do",
            dataType: "json",
            success: function(result){
            	$('#ajaxModal').modal('hide');
            	if( result.length > 0 ){
            		porEndereco(result);
            	} else {
            		if( $("#modalRetorno") ){ $("#modalRetorno").remove(); }
            		$tplModal = $tplModalSmall.replace("@mensagem", "Nenhum atendimento encontrado!");
            		$("body").append($tplModal);
            		$('#modalRetorno').modal('show');
            		initialize();
            	}
            },
            beforeSend: function(){
            	if( $("#ajaxModal") ){ $("#ajaxModal").remove(); }
            	$("body").append($tplAjaxLoad);
                $('#ajaxModal').modal('show');
            },
        });
    });
    
	/* ====================================================================
	 *  TEMPLATE DE MODAL
	 * ==================================================================== */
    var $tplModalSmall = "" +
		"<div class='modal fade' id='modalRetorno' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>" +
			"<div class='modal-dialog'>" + 
				"<div class='modal-content'>" +
					"<div class='modal-header'>" +
						"<button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button>" +
						"<h4 class='modal-title' id='myModalLabel'>Mensagem</h4>" +
					"</div>" +
					"<div class='modal-body'>@mensagem</div>" +
					"<div class='modal-footer'>" +
						"<button type='button' class='btn btn-default' data-dismiss='modal'>Fechar</button>" +
					"</div>" +
				"</div>" +
			"</div>" +
		"</div>";
    
	/* ====================================================================
	 *  TEMPLATE DE AJAX LOADING
	 * ==================================================================== */
    var $tplAjaxLoad = "" +
	"<div class='modal fade' id='ajaxModal' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>" +
	"<div class='modal-dialog'>" + 
		"<div class='modal-content'>" +
			"<div class='modal-body'><p class='text-center'><img src='/ProjetoHibernate/img/carregando.gif'></p><p class='text-center'>Carregando...</p></div>" +
		"</div>" +
	"</div>" +
	"</div>";
    
	/* ====================================================================
	 *  BUSCAR SERVICO : MONTAR MODAL COM FORM
	 * ==================================================================== */
//    $("#BuscarServico").on("click", function(e){
//    	e.preventDefault();
//    	$.ajax({
//            type: "POST",
//            url: "/ProjetoHibernate/servico/formBuscarServico.jsp",
//            dataType: "html",
//            success: function(result){
//            	$('#ajaxModal').modal('hide');
//            		if( $("#modalRetorno") ){ $("#modalRetorno").remove(); }
//            		$tplModal = result;
//            		$("body").append($tplModal);
//            		$('#modalRetorno').modal('show');
//            		$(".dataHora").mask("99/99/9999 99:99:99");
//            },
//            beforeSend: function(){
//            	if( $("#ajaxModal") ){ $("#ajaxModal").remove(); }
//            	$("body").append($tplAjaxLoad);
//                $('#ajaxModal').modal('show');
//            },
//        });
//    });
    
	/* ====================================================================
	 *  CADASTRAR SERVICO : MONTAR MODAL COM FORM
	 * ==================================================================== */
//    $("#CadastrarServico").on("click", function(e){
//    	e.preventDefault();
//    	$.ajax({
//            type: "POST",
//            url: "/ProjetoHibernate/servico/formCadastrarServico.jsp",
//            dataType: "html",
//            success: function(result){
//            		$('#ajaxModal').modal('hide');
//            		if( $("#modalRetorno") ){ $("#modalRetorno").remove(); }
//            		$tplModal = result;
//            		$("body").append($tplModal);
//            		$('#modalRetorno').modal('show');
//            		$(".dataHora").mask("99/99/9999 99:99:99");
//            		
//            		btnCadastrarServico();
//            		
//            },
//            beforeSend: function(){
//            	if( $("#ajaxModal") ){ $("#ajaxModal").remove(); }
//            	$("body").append($tplAjaxLoad);
//                $('#ajaxModal').modal('show');
//            },
//        });
//    });
//    
//    
//    function btnCadastrarServico(){
//		$("#btnCadastrarServico").on("click", function(e){
//			e.preventDefault();
//			var dados = $("#formCadastrarServico").serialize();
//			
////			Mandar Ajax
//	    	$.ajax({
//	            type: "POST",
//	            data: dados,
//	            url: "/ProjetoHibernate/ServicoServlet.do",
//	            dataType: "JSON",
//	            success: function(result){
//            		if( $("#modalRetorno") ){ $("#modalRetorno").remove(); }
//            		
//            		if( result == "OK" ){ $tplModal = $tplModalSmall.replace("@mensagem", "Servi�o cadastrado com sucesso!"); }
//            		else { $tplModal = $tplModalSmall.replace("@mensagem", "Erro ao cadastrar servi�o!"); }
//
//            		$("body").append($tplModal);
//            		$('#modalRetorno').modal('show');
//            		
//            		
////	            	$(".mensagemRetorno").show().html(msg);
//	            		
//	            },
//	            beforeSend: function(){
//	            	if( $("#ajaxModal") ){ $("#ajaxModal").remove(); }
//	            	$("body").append($tplAjaxLoad);
//	                $('#ajaxModal').modal('show');
//	            },
//	        });
//
//		});
//    }
    
    
    $(".confirm-delete").on("click", function(e){
    	e.preventDefault();
    	$("#ConfirmarApagarServico").modal('show');
    	var id = $(this).data('id');
    	$("#IdApagar").val(id);
    });
    
    
    // Atendimento Cadastrar
    if( $("#CadastrarAgendamento").length > 0 ){
    	$(".controle-cnpj").hide();
    	$(".controle-cpf").hide();
    	$("#TipoCliente").modal({backdrop : 'static', keyboard: false});
    }
    
    $("#cliente-cpf").on("click", function(e){
    	e.preventDefault();
    	$("#TipoCliente").modal("hide");
    	$(".controle-cnpj").hide();
    	$(".controle-cpf").show("fast");
    });
    
    $("#cliente-cnpj").on("click", function(e){
    	e.preventDefault();
    	$("#TipoCliente").modal("hide");
    	$(".controle-cpf").hide();
    	$(".controle-cnpj").show("fast");
    });
    
    
    $("#btnBuscarClienteAgendamento").on("click", function(e){
    	e.preventDefault();
    	
    	var Controle = "BuscarCliente";
    	var cpf = $("#cpf").val();
    	var cnpj = $("#cnpj").val();
    	
    	$.ajax({
            type: "POST",
            data: { Controle:Controle, cpf : cpf, cnpj : cnpj},
             
            url: "/ProjetoHibernate/ClienteServlet.do",
            dataType: "json",
            success: function(result){
            	
            	console.log("T:" + result);
            	
            	$('#ajaxModal').modal('hide');
            	
            	if( result.length > 0 ){
                	
            		if( cpf!="" ){
                		$("#Nome").val(result[0]);
                	} else {
                		$("#razao").val(result[0]);
                	}
            		
            		$("#idcliente").val(result[1]);
            		
            		$("#descricao").focus();
                	
            	} else {
            		if( $("#modalRetorno") ){
            			$("#modalRetorno").remove();
            		}
            		$tplModal = $tplModalSmall.replace("@mensagem", "Cliente n�o encontrado!");
            		$("body").append($tplModal);
            		$('#modalRetorno').modal('show');
            		$("#idcliente").val("");
            	}
            	
        	},
            beforeSend: function(){
            	if( $("#ajaxModal") ){ $("#ajaxModal").remove(); }
            	$("body").append($tplAjaxLoad);
                $('#ajaxModal').modal('show');
            },
            
    	});
    });

    // Retorno de ATENDIMENTO : Cadastrado com sucesso ou erro
    if( $("#retornoCadastroAtendimento").length > 0 ){
	    	// pegar o retorno e colocar dentro da modal
	    	var r = $("#retorno").html();
	    	$("#retorno").remove();
	    	$tpl = $tplModalSmall.replace("@mensagem", r);
	    	$tpl = $tpl.replace("<button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button>", "");
	    	$tpl = $tpl.replace("<button type='button'", "<button type='button' id='fecharBtnCalendario'");
	    	$("body").append($tpl);
	    	$("#modalRetorno").modal('show');
    }
    
    $("#fecharBtnCalendario").on("click", function(e){
    	e.preventDefault();
    	window.location="/ProjetoHibernate/atendimento/calendario/";
    });
    
    
	/* ====================================================================
	 *  VALIDACOES
	 * ==================================================================== */
    // LOGIN
    if( $("#frmLogin").length > 0 ){
	    $("#frmLogin").validate({
	    	rules:{
		    	matricula: {required: true},
		    	senha: {required: true, minlength: 3}
	    	},
	    	messages: {
	    		matricula: "Por favor preencha o campo matr�cula",
	    		senha: "Por favor preencha o campo senha"
	    	}
	    });
    }
    
    // SERVICO - CADASTRAR
    if( $("#formCadastrarServico").length > 0 ){
	    $("#formCadastrarServico").validate({
	    	rules:{
	    		nm_servico: {required: true},
	    		dt_vigencia: {required: true},
	    		qtd_emp: {required: true},
	    		qt_inicio: {required: true},
	    		qt_fim: {required: true}
	    	},
	    	messages: {
	    		nm_servico: "Por favor preencha o campo Nome do Servi�o",
	    		dt_vigencia: "Por favor preencha o campo Data de Vig�ncia",
	    		qtd_emp: "Por favor preencha o campo Quantidade de Empregados",
	    		qt_inicio: "Por favor preencha o campo Retorno In�cio Atendimento",
	    		qt_fim: "Por favor preencha o campo Retorno Fim Atendimento"
	    	}
	    });
    }
    
	/* ====================================================================
	 *  BOTAO IMPRIMIR
	 * ==================================================================== */
    $("#imprimir").on("click", function(e){
    	e.preventDefault();
        window.print();
    	return false;
    });

    
});