:- consult('baza.pl').

init_myteam([]).

add_pokemon_to_myteam(Pokemon, Team, NewTeam) :-
    append(Team, [Pokemon], NewTeam).

display_myteam(Team) :-
    write('Twoja drużyna to: '), write(Team), nl.

test :-
    write('1. Podstawowe informacje'), nl,
    write('2. Kontra dla danego pokemona'), nl,
    write('3. Stwórz swoją drużynę'), nl,

    read(A1), nl,
    (   A1 == '1' ->
        write('Co chciałbyś wiedzieć?'), nl,
        write('1. Jaki jest typ mojego pokemona?'), nl,
        write('2. Jakie pokemony należą do tego typu?'), nl,
        write('3. Jaki typ pokemona wybrać przeciwko innemu typowi pokemonów?'), nl,
        read(A2), nl,
        (   A2 == '1' ->
                write('Wpisz nazwę swojego pokemona: '), nl,
                read(Pokemon), nl,
                pokemontype(Pokemon, Type),
                format('Typ pokemona ~w to ~w', [Pokemon, Type]), nl
            ;
            A2 == '2' ->
                write('Pokemony którego/których typów chcesz poznać?'), nl,
                read(Typ), nl,
                findPokemonOfType([Typ], Pokemon),
                  format('Pokemony typu ~w to ~w', [Typ, Pokemon])
            ;
            A2 == '3' ->
                write('Jaki na jaki typ pokemonów na które walczysz?'), nl,
                read(Typ), nl,
                findCounter([Typ], _)
        )
    ;
    A1 == '2' ->
           write('Wpisz pokemona którego kontrujemy '), nl,
           read(Pokemon), nl,
           effectiveAgainst(Pokemon, _)
    ;
    A1 == '3' ->
         write('Witaj w kreatorze drużyn'), nl,
         write('Prosze podaj swojego głównego pokemona: '), nl,
         read(Pokemon), nl,
         add_pokemon_to_myteam(Pokemon, [], Team1),
         findTeamPokemon2(Pokemon),
         write('Prosze podaj swojego drugiego pokemona: '), nl,
         read(Pokemon2), nl,
         add_pokemon_to_myteam(Pokemon2, Team1, Team2),
         findTeamPokemon3([Pokemon,Pokemon2], _),
         write('Prosze podaj swojego trzeciego pokemona: '), nl,
         read(Pokemon3), nl,
         add_pokemon_to_myteam(Pokemon3, Team2, FinalTeam),
         display_myteam(FinalTeam)
    ).

:- initialization(test).
