myteam().

:- dynamic(myteam/1).
initialize_myteam :-
    retractall(myteam(_)), % Usunięcie ewentualnych poprzednich wartości
    assert(myteam([])).    % Dodanie pustej listy jako wartość myteam

add_pokemon_to_myteam(Pokemon) :-
    retract(myteam(MyTeam)),   % Pobranie aktualnej listy
    append(MyTeam, [Pokemon], UpdatedTeam),
    assert(myteam(UpdatedTeam)).  % Zaktualizowanie faktu myteam
    
display_myteam :-
    myteam(MyTeam),  % Pobranie aktualnej listy Pokemonów
    write('Twoja drużyna Pokemonów: '), nl,
    display_pokemon_list(MyTeam).  % Wyświetlenie listy Pokemonów

% Predykat pomocniczy do wyświetlania listy Pokemonów
display_pokemon_list([]).
display_pokemon_list([Pokemon|Rest]) :-
    write('- '), write(Pokemon), nl,
    display_pokemon_list(Rest).       %rek listy




test:-
    initialize_myteam,
    write('   Witaj w pokedeksie, w czym mogę pomóc?'), nl,
    write('1. Pomoc strategiczna w dobraniu drużyny'), nl,
    write('2. Ogólne informacje o typach'), nl,
    write('3. Dodaj swóją drużynę'), nl,
    read(A1), nl,
    (  A1 == '1' ->
        write('Co chciałbyś wiedzieć?'), nl,
        write('1. Jaki jest typ mojego pokemona?'), nl,
        write('2. Na jakie typy muszę uważać podczas bitwy?'), nl,
        write('3. Pokemony jakiego typu najlepiej będą współgrać z moim kompanem?'), nl,
        read(A2), nl,
        (A2 == '1' ->
            write('Wpisz nazwę swojego pokemona: '), nl,
            read(Pokemon), nl,
            pokemontype(Pokemon, Type),
            format('Typ pokemona ~w to ~w', [Pokemon, Type]), nl
        ;
         A2 == '2' ->
                    write('Jakiego typu jest twój pokemon?: '), nl,
                    read(Typ), nl,
                    findall(Kontra, (efdamage(Typ, Kontra, Y), Y =:= 0.8), KontraList),
                    format('Typ pokemona ~w jest kontrowany przez typy: ~w', [Typ, KontraList]), nl
        ; A2 == '3' ->
            % dodać
            true
        ; write('Niepoprawny wybór, spróbuj ponownie.')
        )
    ; A1 == '2' ->
        % dodać logike
        true
    ;
    A1 == '3' ->
        write('Wpisz nazwę swojego pokemona/pokemonów: '), nl,
        read(Pokemon), nl,
        add_pokemon_to_myteam(Pokemon),
        display_myteam
    ;   write('Niepoprawny wybór, spróbuj ponownie.')
    ).

:- initialization(test).