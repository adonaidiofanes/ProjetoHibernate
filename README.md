ProjetoHibernate
================

> Projeto acadêmico desenvolvido na finalização do curso de Análise e Projeto de Sistemas pela PUC-Rio

Técnologias Utilizadas
----------------------
* Java EE
* Hibernate
* MySQL
* jQuery
* MVC com Designer Patterns

Informações sobre o projeto
---------------------------
Na busca de um tema que fosse ao mesmo tempo desafiador e adequado à aplicação dos conhecimentos adquiridos ao longo do curso surgiu a ideia de um dos membros do grupo de um sistema que monitorasse equipes externas. Na evolução da ideia visualizamos o uso de tecnologia móbile, assunto que supriu o aspecto de desafio buscado pela equipe.

O projeto, portanto, se destina a todos os interessados em soluções de sistemas utilizando tecnologia móbile e também para aqueles que se interessem por verificar a aplicabilidade de um sistema informatizado na otimização e melhora de produtividade de equipes que atuam em campo.

É comum empresas trabalharem com atendimento externo, como por exemplo: empresas de prestação de serviço de instalação (EX.: NET, Claro...) ou de manutenção de eletrodomésticos (ex.: TECVAL...). A grande dificuldade nesses casos é a gestão adequada das equipes de campo (agendamento, controle e localização das equipes), assim como a otimização da produtividade das equipes de campo com a ocupação das agendas que controlam a disponibilidade destas equipes.

Este projeto visa criar uma aplicação web de workforce para uso por empresas que necessitem controlar as equipes responsáveis por serviços externos e ocupar de forma otimizada a disponibilidade destas equipes, oferecendo uma solução flexível e parametrizável para controle e monitoramento da força de trabalho móvel, escalada para serviços previamente agendados ou serviços que precisem de atendimento imediato.

O sistema será parametrizável a ponto de tentar atender a qualquer empresa que use equipes e/ou profissionais externos em suas atividades, portanto as informações serão baseadas em uma empresa com essa característica. Escolhemos uma empresa fictícia do ramo de telefonia em função da maior facilidade de entendimento do portfólio de serviços de uma empresa desse setor.

A empresa fictícia criada para esse projeto, a TELEHAND, é especializada em venda de serviços de telefonia e internet e se utiliza do emprego de profissionais capacitados para atendimentos externos a clientes residenciais e empresariais nos serviços de instalação, desinstalação e manutenção de equipamentos. A empresa é de pequeno a médio porte e está iniciando suas atividades no município do Rio de janeiro, onde está sediada.

Configurações
-------------

* Banco de dados: https://github.com/adonaidiofanes/ProjetoHibernate/blob/master/ProjetoHibernate/WebContent/db_sge.sql
* Bibliotecas (que devem ser adicionadas ao BuildPath): https://github.com/adonaidiofanes/ProjetoHibernate/tree/master/ProjetoHibernate/WebContent/WEB-INF/lib
* Arquivo de configuração: https://github.com/adonaidiofanes/ProjetoHibernate/blob/master/ProjetoHibernate/src/hibernate.cfg.xml

Usuários e senhas padrões
-------------------------

| Papel  | Matricula  | Senha |
| :------------ |:---------------:| -----:|
| Administrador      | 1 | 123 |
| Técnico     | 2        |   tec1 |
| Coordenador | 3        |    coo1 |
| Supervisor | 4        |    sup1 |
| Atendente | 5        |    ate1 |

CPF's de usuários para teste
----------------------------
| CPF |
| :-- |
| 10000000001 |
| 10000000002 | 
| 10000000003 |
| 10000000004 |
