%persona(Apodo, Edad, Peculiaridades).
persona(ale, 15, [claustrofobia, cuentasRapidas, amorPorLosPerros]).
persona(agus, 25, [lecturaVeloz, ojoObservador, minuciosidad]).
persona(fran, 30, [fanDeLosComics]).
persona(rolo, 12, []).

%esSalaDe(NombreSala, Empresa).
esSalaDe(elPayasoExorcista, salSiPuedes).
esSalaDe(socorro, salSiPuedes).
esSalaDe(linternas, elLaberintoso).
esSalaDe(guerrasEstelares, escapepepe).
esSalaDe(fundacionDelMulo, escapepepe).

%terrorifica(CantidadDeSustos, EdadMinima).
%familiar(Tematica, CantidadDeHabitaciones).
%enigmatica(Candados).

%sala(Nombre, Experiencia).
sala(elPayasoExorcista, terrorifica(100, 18)).
sala(socorro, terrorifica(20, 12)).
sala(linternas, familiar(comics, 5)).
sala(guerrasEstelares, familiar(futurista, 7)).
sala(fundacionDelMulo, enigmatica([combinacionAlfanumerica, deLlave, deBoton])).

% Punto 1
nivelDeDificultadDeLaSala(Sala,Dificultad):-
    sala(Sala,Experiencia),
    dificultadDeSala(Experiencia,Dificultad).

dificultadDeSala(terrorifica(CantidadDeSustos, EdadaMinima),Dificultad):-
    Dificultad is CantidadDeSustos - EdadaMinima.
dificultadDeSala(familiar(_,CantidadDeHabitaciones),CantidadDeHabitaciones).
dificultadDeSala(familiar(futurista,_),15).
dificultadDeSala(enigmatica(Candados),Dificultad):-
    length(Candados, Dificultad).    


% Punto 2
puedeSalir(Persona,NombreSala):-
    persona(Persona,_,Peculiaridades),
    not( member(claustrofobia, Peculiaridades)),
    sala(NombreSala,_),
    criterioDeSalida(NombreSala,Persona).

criterioDeSalida(Sala,_):-
    nivelDeDificultadDeLaSala(Sala,1).
criterioDeSalida(Sala,Persona):-
    persona(Persona,Edad,_),
    Edad > 13,
    nivelDeDificultadDeLaSala(Sala,Dificultad),
    Dificultad > 5.


% Punto 4

empresa(acer,[socorro,linternas]).
empresa(intel,[elPayasoExorcista,linternas]).
empresa(ryzen,[socorro,elPayasoExorcista]).
empresa(logitech,[socorro]).


esMacabraVersion1(Empresa) :-
    empresa(Empresa, Salas),
    forall(member(Sala, Salas), esTerrorifica(Sala)).

esMacabraVersion2(Empresa):-
    empresa(Empresa, Salas),
    not((member(Sala, Salas), not(esTerrorifica(Sala)))).
    
esTerrorifica(Sala) :- sala(Sala, terrorifica(_, _)).

