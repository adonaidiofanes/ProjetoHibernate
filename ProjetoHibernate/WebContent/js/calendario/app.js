(function($) {
	
	var pathProjeto = "/ProjetoHibernate/";

	/* ====================================================================
	 *  MONTAR CALENDARIO DE AGENDAMENTOS
	 * ==================================================================== */
	$("#CalendarioAgendamento").on("click", function(e) {
		e.preventDefault();

		var Controle = $("#Controle").val();
		var slcServico = $("#slcServico").val();
		
		if( $("#controlador") ){
			$("#controlador").hide("slow");
		}
		
		if( $(".titulo-calendario") ){
			$(".titulo-calendario").hide("slow");
		}

		$.ajax({
			type : "POST",
			data : {
				Controle : Controle,
				slcServico : slcServico
			},
			url : pathProjeto + "AgendaServlet.do",
			dataType : "JSON",
			success : function(result) {
				
				$('#ajaxModal').modal('hide');
				if ($("#modalRetorno")) {
					$("#modalRetorno").remove();
				}
				// Limpar calendario
				$("#calendar").empty();
				
				// Verificar se retornou sucesso
				if( result.success == 1 && result.result.length > 0){
					// Gerar Calendario, Trabalhar com o resultado da query
					gerarCalendario(result.result);
					
					// Mostrar titulo do mes e controlador
					$("#controlador, .titulo-calendario").show("slow");
					
					
				}
				else {
					var msg = "Nenhum agendamento encontrado!";
					$tpl = $tplModalSmall.replace("@mensagem",msg);
					$("body").append($tpl);
					$("#modalRetorno").modal('show');
				}

			},
			beforeSend : function() {
				if ($("#ajaxModal")) {
					$("#ajaxModal").remove();
				}
				$("body").append($tplAjaxLoad);
				$('#ajaxModal').modal('show');
			},
		});
	});

	function gerarCalendario(json) {
		
		// Gerar dia atual
		var d = new Date();
		var mes = d.getMonth()+1;
		var dia = d.getDate();
		var dataHoje = d.getFullYear() + '-' +
		    ((''+mes).length<2 ? '0' : '') + mes + '-' +
		    ((''+dia).length<2 ? '0' : '') + dia;

		// Configuracoes responsaveis pela geracao do calendario
		"use strict";

		var options = {
			events_source : json,
			view : 'month',
			tmpl_path : 'tmpls/',
			tmpl_cache : false,
			day : dataHoje,
			language : 'pt-BR',
			onAfterViewLoad : function(view) {
				$('.page-header h3.titulo-calendario').text(this.getTitle());
				$('.btn-group button').removeClass('active');
				$('button[data-calendar-view="' + view + '"]').addClass(
						'active');
			},
			classes : {
				months : {
					general : 'label'
				}
			},
			//modal : '#myModal',
		};

		var calendar = $('#calendar').calendar(options);

		$('.btn-group button[data-calendar-nav]').each(function() {
			var $this = $(this);
			$this.click(function() {
				calendar.navigate($this.data('calendar-nav'));
			});
		});

		$('.btn-group button[data-calendar-view]').each(function() {
			var $this = $(this);
			$this.click(function() {
				calendar.view($this.data('calendar-view'));
			});
		});

		$('#events-modal .modal-header, #events-modal .modal-footer').click(
				function(e) {
					//e.preventDefault();
					//e.stopPropagation();
				});
	}// Fim gerarCalendario()
	
	/* ====================================================================
	 *  TEMPLATE DE AJAX LOADING
	 * ==================================================================== */
    var $tplAjaxLoad = "" +
	"<div class='modal fade' id='ajaxModal' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>" +
	"<div class='modal-dialog'>" + 
		"<div class='modal-content'>" +
			"<div class='modal-body'><p class='text-center'><img src='"+pathProjeto+"img/carregando.gif'></p><p class='text-center'>Carregando...</p></div>" +
		"</div>" +
	"</div>" +
	"</div>";

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
	 *  TEMPLATE DE MODAL PARA RETORNO DE FORMULARIO
	 * ==================================================================== */
	$tplModalFormAgendamento = '<div class="modal hide fade" id="events-modal">' + 
	'<div class="modal-header">' +
		'<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>' +
		'<h3>Evento</h3>' +
	'</div>' +
	'<div class="modal-body" style="height: 400px">' +
	'</div>' +
	'<div class="modal-footer">' +
		'<a href="#" data-dismiss="modal" class="btn">Fechar</a>' +
	'</div>' +
	'</div>';
    
}(jQuery));