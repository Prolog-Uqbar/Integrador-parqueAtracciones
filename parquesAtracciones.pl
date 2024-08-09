%%%%%%
%                 PERSONAS PARQUES Y ATRACCIONES

%Personas
persona(nina,22,1.6).
persona(marcos,8,1.32).
persona(osvaldo,13,1.29).
persona(ana,13,1.6).

perteneceGrupoEtario(Persona,Grupo):-
    persona(Persona,Edad,_),
    grupoEtario(Grupo,E1,E2),
    between(Edad,E1,E2).

% Estos ejemplos son arbitrarios, podríamos ampliar los límites, 
% agregar otros grupos etarios 
% o incluso solapar los intervalos porque no es necesario que sean excluyentes
grupoEtario(ninio,0,12).
grupoEtario(adolescente,13,18). 
grupoEtario(joven,19,30).
grupoEtario(adulto,30,100).

% Tambien se puede saber el grupo dierectamente en los hechos.
persona(nina,joven,22,1.6).
persona(marcos,ninio,8,1.32).
persona(osvaldo,adolescente,13,1.29).
persona(ana,adolescente,13,1.6).

%parques
tieneAtraccion(parqueDeLaCosta,trenFantasma).
tieneAtraccion(parqueDeLaCosta,montaniaRusa).
tieneAtraccion(parqueDeLaCosta,maquinaTiquetera).
tieneAtraccion(parqueAcuatico,toboganGigante).
tieneAtraccion(parqueAcuatico,rioLento).
tieneAtraccion(parqueAcuatico,piscinaDeOlas).

requisito(trenFantasma,edad(12)).
requisito(montaniaRusa,altura(1.3)).
requisito(toboganGigante,altura(1.5)).
requisito(piscinaDeOlas,edad(5)).
% Los requisitos de cada atracción son independientes de en qué parque estén
% Si una misma atracción estuviera en diferentes parques, sus requisitos son los mismos
% La atracción sin requisitos directamente no está como hecho.



% Punto 1

puedeSubir(Persona, Atraccion):-
    persona(Persona,_,_,_),
    tieneAtraccion(_,Atraccion),
    requisito(Atraccion,Requisito),
    cumpleRequisito(Persona,Requisito).

puedeSubir(Persona, Atraccion):-
        persona(Persona,_,_,_),
        tieneAtraccion(_,Atraccion),
        not(requisito(Atraccion,_)).

%Asumiendo que una atracción puede tener varios requisitos, la misma regla ya considera cuando no tiene requisitos
puedeSubir(Persona, Atraccion):-
    persona(Persona,_,_,_),
    tieneAtraccion(_,Atraccion),
    forall(requisito(Atraccion,Requisito),cumpleRequisito(Persona,Requisito)).
    
cumpleRequisito(Persona,edad(Minima)):- persona(Persona,E,_), E >= Minima.
cumpleRequisito(Persona,altura(Minima)):- persona(Persona,_,A), A >= Minima.


% Alternativa, modelando todo con un mismo predicado, explicitando no tener requisitos.
tieneAtraccion(parqueAcuatico,piscinaDeOlas,edad(5)).
tieneAtraccion(parqueAcuatico,rioLento, sinRequisitos).

puedeSubir(Persona, Atraccion):-
    persona(Persona,_,_,_),
    tieneAtraccion(_,Atraccion, Requisito),
    cumpleRequisito(Persona,Requisito).

%Se agrega caso
cumpleRequisito(_,sinRequisitos).

%punto 2
esParaElle(Parque,Persona):-
    persona(Persona,_,_,_),
    tieneAtraccion(Parque,_),
    forall(tieneAtraccion(Parque,Atraccion),puedeSubir(Persona,Atraccion)).

%punto 3
malaIdea(Grupo,Parque):-
    tieneAtraccion(Parque,_),
    grupoEtario(Grupo,_,_),
    not(hayUnaAtraccionParaTodes(Grupo,Parque)).

hayUnaAtraccionParaTodes(Grupo,Parque):-
    tieneAtraccion(Parque,Atraccion),
    forall(perteneceGrupoEtario(Persona,Grupo),puedeSubir(Persona,Atraccion)).

% Alternativas equivalentes forall/not
malaIdea(Grupo,Parque):-
    tieneAtraccion(Parque,_),
    grupoEtario(Grupo,_,_),
    forall(tieneAtraccion(Parque,Atraccion), algunoSeLaPierde(Grupo,Atraccion)).

algunoSeLaPierde(Grupo,Atraccion):-
    perteneceGrupoEtario(Persona,Grupo),
    not(puedeSubir(Persona,Atraccion)).

hayUnaAtraccionParaTodes(Grupo,Parque):-
    tieneAtraccion(Parque,Atraccion),
    not(algunoSeLaPierde(Grupo,Atraccion)).

%%%%%%
%                               PROGRAMAS

programaLogico(Programa):-
    enElMismoParque(Programa),
    todosDistintos(Programa).

enElMismoParque(Programa).
    parque(_,Atracciones),
    forall(member(Atraccion,Programa),member(Atraccion,Atracciones)).

todosDistintos([]).
todosDistintos([Cabeza|Cola]) :- 
    not(member(Cabeza, Cola)), 
    todosDistintos(Cola).

% Alternativa
programaLogico(Programa):-
    enElMismoParque(Programa),
    not(hayRepetidos(Programa)).

hayRepetidos([X|XS]):- member(X,XS).
hayRepetidos([_|XS]):- hayRepetidos(XS).

%%

hastaAca(_,[],[]).
hastaAca(P,[X|_],[]):- not(puedeSubir(P,X)).
hastaAca(P,[X|XS],[X|YS]):- puedeSubir(P,X),hastaAca(P,XS,YS).

%%%%%%%%%%%%%%%%%%%%%
%                           PASAPORTES

puedeSubirPasaporte(Persona, Atraccion) :-
    puedeSubir(Persona,Atraccion),
    tienePasaporte(Persona,Pasaporte),
    habilita(Pasaporte,Atraccion).

% habilita(Pasaporte,Atraccion)
habilita(premium, _).
habilita(basico(Credito),Atraccion):-
    juegoComun(Atraccion,Costo),
    Credito >= Costo.
habilita(flex(Credito,Atraccion),Atraccion):-
    juegoPremium(Atraccion).
habilita(flex(Credito,_),Atraccion):-
    habilita(basico(Credito),Atraccion).

% juegoComun(Atraccion, Costo).
juegoComun(trenFantasma, 5).
juegoComun(maquinaTiquetera, 2).
juegoComun(rioLento, 3).
juegoComun(piscinaOlas, 4).

juegoPremium(montaniaRusa).
juegoPremium(toboganGigante).

% Pasaportes
tienePasaporte(nina, premium).
tienePasaporte(marcos, basico(10)).
tienePasaporte(osvaldo, flex(15, montaniaRusa)).
tienePasaporte(ana, basico(14)).
