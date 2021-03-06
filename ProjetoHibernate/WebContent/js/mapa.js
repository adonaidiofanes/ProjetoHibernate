var map;
var idInfoBoxAberto;
var infoBox = [];
var markers = [];
var pathProjeto = "/ProjetoHibernate/";

function initialize() {	
	var latlng = new google.maps.LatLng(-22.906005,-43.313255);
	
    var options = {
        zoom: 11,
		center: latlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    map = new google.maps.Map(document.getElementById("mapa"), options);
}

initialize();

function abrirInfoBox(id, marker) {
	if (typeof(idInfoBoxAberto) == 'number' && typeof(infoBox[idInfoBoxAberto]) == 'object') {
		infoBox[idInfoBoxAberto].close();
	}

	infoBox[id].open(map, marker);
	idInfoBoxAberto = id;
}

function carregarPontos(pontos) {
	
	//	Limpar Pontos no Mapa
	limparMarcadores();

		var latlngbounds = new google.maps.LatLngBounds();
		
		$.each(pontos, function(index, ponto) {
			
			var Cliente = pontos[index][1].tbCliente;
			var Agendamento = pontos[index][0].tbAgendamento;
			
			/* Verificar qual o tipo de marcardor de acordo com o tipo de serviço
				A – Aberto
				C – Cancelado
				P – Pendente
				R – Reagendado
				E - Efetuado			   
			*/
			var Marcador = pathProjeto + "img/marcador.png";
			switch( Agendamento.Cdstatus ){
				case "A" : Marcador = pathProjeto + "img/marcador_aberto.png"; break;
				case "C" : Marcador = pathProjeto + "img/marcador_cancelado.png"; break;
				case "P" : Marcador = pathProjeto + "img/marcador_pendente.png"; break;
				case "R" : Marcador = pathProjeto + "img/marcador_reagendado.png"; break;
				case "E" : Marcador = pathProjeto + "img/marcador_efetuado.png"; break;
			}
			
			var marker = new google.maps.Marker({
				position: new google.maps.LatLng(Agendamento.Latitude, Agendamento.Longitude),
//				title: "OS: " + Id + " Endereço: " + Endereco,
				title: "Ponto",
				icon: Marcador
			});
	
			
		// Verificar numero
		if (Cliente.Numero != undefined) { var NumeroEndereco = ", " + Cliente.Numero + " - "; } 
		else { var NumeroEndereco = " - "; }

		// Verificar CEP
		if (Cliente.CEP != undefined) { var CEP = ", " + Cliente.CEP; } 
		else { var CEP = ""; }
		
		// Verificar Complemento
		if (Cliente.Complemento != undefined) { var Complemento = Cliente.Complemento + " - "; } 
		else { var Complemento = ""; }

		var Endereco = Cliente.Endereco + NumeroEndereco + Cliente.Cidade + ", " + Cliente.UF;
			Endereco += CEP;
			
		var EnderecoCompleto = Cliente.Endereco + NumeroEndereco + Complemento + Cliente.Cidade + ", " + Cliente.UF;
			EnderecoCompleto += CEP;
			
		var tplConteudo = "<p><strong>OS: #" + Agendamento.IdOS + "</strong> - Último Contato: " + Agendamento.DtReporte +"<br>";
			tplConteudo += "<strong>Equipe:</strong> " + Agendamento.IdEquipe + " / <strong>Smartphone: </strong> " + Agendamento.Smartphone + "<br>";
			tplConteudo += "<strong>Status:</strong> "+ Agendamento.CdStatus +"<br>";
			tplConteudo += "<hr></p>";
			tplConteudo += "<p><strong>Cliente:</strong> "+ Cliente.NmCliente +"<br>";
			tplConteudo += "<strong>Endereço:</strong> "+ EnderecoCompleto +"<br>";
			tplConteudo += "<strong>Telefone / Celular:</strong> "+ Cliente.Telefone + " / " + Cliente.Celular +"<br>";
			tplConteudo += "<strong>Email:</strong> "+ Cliente.Email +"</p>";

			var myOptions = {
				content: tplConteudo,
				pixelOffset: new google.maps.Size(-150, 0)
        	};

			infoBox[Agendamento.IdOS] = new InfoBox(myOptions);
			infoBox[Agendamento.IdOS].marker = marker;
			
			infoBox[Agendamento.IdOS].listener = google.maps.event.addListener(marker, 'click', function (e) {
				abrirInfoBox(Agendamento.IdOS, marker);
			});
			
			markers.push(marker);
			
//			latlngbounds.extend(marker.position);
			
		});
		
		var markerCluster = new MarkerClusterer(map, markers);
		
//		map.fitBounds(latlngbounds);
}

function limparMarcadores() {
	if (markers) {
		for (i in markers) {
			markers[i].setMap(null);
		}
		markers.length = 0;
	}
	
	if(infoBox){
		for (i in infoBox) {
			infoBox[i].setMap(null);
		}
		infoBox.length = 0;		
	}
	
}

function porEndereco(pontos) {
	
	//	Limpar Pontos no Mapa
	limparMarcadores();
	
	//	Verificar se a busca retornou algum resultado!
	if(pontos.length != 0){

	var latlngbounds = new google.maps.LatLngBounds();

	for ( var i = 0; i < pontos.length; i++) {

		var Cliente = pontos[i][1].tbCliente;
		var Agendamento = pontos[i][0].tbAgendamento;

		// Verificar numero
		if (Cliente.Numero != undefined) { var NumeroEndereco = ", " + Cliente.Numero + " - "; } 
		else { var NumeroEndereco = " - "; }

		// Verificar CEP
		if (Cliente.CEP != undefined) { var CEP = ", " + Cliente.CEP; } 
		else { var CEP = ""; }
		
		// Verificar Complemento
		if (Cliente.Complemento != undefined) { var Complemento = Cliente.Complemento + " - "; } 
		else { var Complemento = ""; }

		var Endereco = Cliente.Endereco + NumeroEndereco + Cliente.Cidade + ", " + Cliente.UF;
			Endereco += CEP;
			
		var IdOS = Agendamento.IdOS;
		
		var NomeCliente = Cliente.NmCliente;
		var EnderecoCompleto = Cliente.Endereco + NumeroEndereco + Complemento + Cliente.Cidade + ", " + Cliente.UF;
			EnderecoCompleto += CEP;
			
		var EmailCliente  = Cliente.Email;
		var DtAgendamento = Agendamento.DtAgendamento;
		var IdEquipe = Agendamento.IdEquipe;
		var CdStatus = Agendamento.CdStatus;
		var Telefone = Cliente.Telefone;
		var Celular  = Cliente.Celular;
		
		var tplConteudo = "<p><strong>OS: #" + IdOS + "</strong></p>";
			tplConteudo += "<p><strong>Status:</strong> "+ CdStatus +"</p>";
			tplConteudo += "<p><strong>Cliente:</strong> "+ NomeCliente +"</p>";
			tplConteudo += "<p><strong>Endereço:</strong> "+ EnderecoCompleto +"</p>";
			tplConteudo += "<p><strong>Telefone / Celular:</strong> "+ Telefone + " / " + Celular +"</p>";
			tplConteudo += "<p><strong>Email:</strong> "+ EmailCliente +"</p>";
			tplConteudo += "<p><strong>Equipe:</strong> "+ IdEquipe + " / <strong>Smartphone: </strong>" + Agendamento.Smartphone + "</p>";
		
			gerarPontoEndereco(Endereco, IdOS, tplConteudo);
		
	}

//		var markerCluster = new MarkerClusterer(map, markers);

//		map.fitBounds(latlngbounds);
	} else {
		alert('Nenhum agendamento encontrado!');
	}
		
}

function gerarPontoEndereco(Endereco, Id, Conteudo) {
	
	var geocoder = new google.maps.Geocoder();
//	var latlngbounds = new google.maps.LatLngBounds();

	geocoder.geocode({
		'address' : Endereco + ', Brasil',
		'region' : 'BR'
	}, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
			map.setCenter(results[0].geometry.location);

			var MarcadorIcone = pathProjeto + "img/marcador.png";

			var marker = new google.maps.Marker({
				map : map,
				position : results[0].geometry.location,
				title: "OS: " + Id + " Endereço: " + Endereco,
				icon : MarcadorIcone
			});

			var myOptions = {
				content : Conteudo,
				pixelOffset : new google.maps.Size(-150, 0)
			};

			infoBox[Id] = new InfoBox(myOptions);
			infoBox[Id].marker = marker;

			infoBox[Id].listener = google.maps.event.addListener(marker,
					'click', function(e) {
						abrirInfoBox(Id, marker);
					});

			markers.push(marker);
			
			console.log("OK: " + Id);

		} else if (status === google.maps.GeocoderStatus.OVER_QUERY_LIMIT) {
			window.setTimeout(function(){
				gerarPontoEndereco(Endereco, Id, Conteudo);
			}, 2000);
			console.log("LIMIT: " + Id);
		} else {
			alert('Nao foi possível localizar o endereço: '
					+ status);
		}
		
		var markerCluster = new MarkerClusterer(map, markers);
		
	});
}