/* Predykat wypisujący typ danego Pokemona */
showPokemonType(Pokemon) :-
    pokemontype(Pokemon, Type),
    write(Type).


/* Define the predicate for checking effectiveness */
effectiveAgainst(Pokemon, TargetType) :-
    pokemontype(Pokemon, Type),
    (pokemontype(Pokemon, SecondType),efdamage(TargetType, Type,  FirstModifier), efdamage(TargetType, SecondType, SecondModifier),
    Modifier is FirstModifier * SecondModifier;
    efdamage(Type, TargetType, Modifier)),
    Modifier > 1.

/* Rule to suggest Pokemon based on effectiveness */
suggestPokemon(Pokemon) :-
    pokemontype(Pokemon, _),
    effectiveAgainst(Pokemon, TargetType),
    findall(TargetPokemon, (pokemontype(TargetPokemon, TargetType), TargetPokemon \= Pokemon), Suggestions),
    write('Effective Pokemon against '), write(Pokemon), write(' are: '), nl,
    write(Suggestions), nl.

/* Predicate to handle user input and provide suggestions */
suggestEffectivePokemon :-
    write('Enter the Pokemon you are facing: '),
    read(Pokemon),
    suggestPokemon(Pokemon).


/* TYPES */
type(grass).
type(poison).
type(fire).
type(flying).
type(water).
type(bug).
type(normal).
type(electric).
type(ground).
type(fighting).
type(psyhic).
type(rock).
type(ice).
type(ghost).
type(dragon).
type(steel).

/* EFFECTIVE and UNEFFECTIVE DAMAGE */

/* GRASS */
efdamage(grass, water, 1.25).
efdamage(grass, ground, 1.25).
efdamage(grass, rock, 1.25).
efdamage(grass, bug, 0.8).
efdamage(grass, fire, 0.8).
efdamage(grass, flying, 0.8).
efdamage(grass, poison, 0.8).
efdamage(grass, grass, 0.8).
efdamage(grass, dragon, 0.8).
efdamage(grass, steel, 0.8).
/* FIRE */
efdamage(fire, grass, 1.25).
efdamage(fire, bug, 1.25).
efdamage(fire, ice, 1.25).
efdamage(fire, steel, 1.25).
efdamage(fire, water, 0.8).
efdamage(fire, rock, 0.8).
efdamage(fire, fire, 0.8).
efdamage(fire, dragon, 0.8).
/* BUG */
efdamage(bug, grass, 1.25).
efdamage(bug, psychic, 1.25).
efdamage(bug, fighting, 0.8).
efdamage(bug, flying, 0.8).
efdamage(bug, poison, 0.8).
efdamage(bug, ghost, 0.8).
efdamage(bug, steel, 0.8).
efdamage(bug, fire, 0.8).
/* DRAGON */
efdamage(dragon, dragon, 1.25).
efdamage(dragon, steel, 0.8).
/* ELECTRIC */
efdamage(electric, flying, 1.25).
efdamage(electric, water, 1.25).
efdamage(electric, electric, 0.8).
efdamage(electric, grass, 0.8).
efdamage(electric, dragon, 0.8).
efdamage(electric, ground, 0.8).
/* FIGHTING */
efdamage(fighting, ice, 1.25).
efdamage(fighting, normal, 1.25).
efdamage(fighting, rock, 1.25).
efdamage(fighting, steel, 1.25).
efdamage(fighting, bug, 0.8).
efdamage(fighting, flying, 0.8).
efdamage(fighting, poison, 0.8).
efdamage(fighting, psychic, 0.8).
efdamage(fighting, ghost, 0.5).
/* FLYING */
efdamage(flying, bug, 1.25).
efdamage(flying, fighting, 1.25).
efdamage(flying, grass, 1.25).
efdamage(flying, electric, 0.8).
efdamage(flying, rock, 0.8).
efdamage(flying, steel, 0.8).
/* GHOST */
efdamage(ghost, ghost, 1.25).
efdamage(ghost, psychic, 1.25).
efdamage(ghost, fighting, 1.25).
efdamage(ghost, normal, 0.5).
/* GROUND */
efdamage(ground, electric, 1.25).
efdamage(ground, fire, 1.25).
efdamage(ground, poison, 1.25).
efdamage(ground, rock, 1.25).
efdamage(ground, steel, 1.25).
efdamage(ground, bug, 0.8).
efdamage(ground, grass, 0.8).
efdamage(ground, flying, 0.8).
/* ICE */
efdamage(ice, dragon, 1.25).
efdamage(ice, flying, 1.25).
efdamage(ice, grass, 1.25).
efdamage(ice, ground, 1.25).
efdamage(ice, ice, 0.8).
efdamage(ice, steel, 0.8).
efdamage(ice, fire, 0.8).
efdamage(ice, water, 0.8).
/* POISON */
efdamage(poison,grass, 1.25).
efdamage(poison, bug, 1.25).
efdamage(poison, poison, 0.8).
efdamage(poison, ground, 0.8).
efdamage(poison, rock, 0.8).
efdamage(poison, ghost, 0.8).
efdamage(poison, steel, 0.8).
/* NORMAL */
efdamage(normal, ghost, 0).
efdamage(normal, steel, 0.8).
efdamage(normal, rock, 0.8).
/* PSYCHIC */
efdamage(psychic, fighting, 1.25).
efdamage(psychic, poison, 1.25).
efdamage(psychic, psychic, 0.8).
efdamage(psychic, steel, 0.8).
/* ROCK */
efdamage(rock, bug, 1.25).
efdamage(rock, fire, 1.25).
efdamage(rock, flying, 1.25).
efdamage(rock, ice, 1.25).
efdamage(rock, fighting, 0.8).
efdamage(rock, ground, 0.8).
efdamage(rock, steel, 0.8).
/* STEEL */
efdamage(steel, ice, 1.25).
efdamage(steel, rock, 1.25).
efdamage(steel, steel, 0.8).
efdamage(steel, electric, 0.8).
efdamage(steel, fire, 0.8).
efdamage(steel, water, 0.8).
/* WATER */
efdamage(water, fire, 1.25).
efdamage(water, ground, 1.25).
efdamage(water, rock, 1.25).
efdamage(water, water, 0.8).
efdamage(water, grass, 0.8).
efdamage(water, dragon, 0.8).

/* 1ST GEN POKEMONS */
pokemontype(bulbasaur, grass).
pokemontype(ivysaur, grass).
pokemontype(venusaur, grass).
pokemontype(venusaur, poison).
pokemontype(charmander, fire).
pokemontype(charmeleon, fire).
pokemontype(charizard, fire).
pokemontype(charizard, flying).
pokemontype(squirtle, water).
pokemontype(wartortle, water).
pokemontype(blastoise, water).
pokemontype(caterpie, bug).
pokemontype(metapod, bug).
pokemontype(butterfree, bug).
pokemontype(butterfree, flying).
pokemontype(weedle, bug).
pokemontype(weedle, poison).
pokemontype(kakuna, bug).
pokemontype(kakuna, poison).
pokemontype(beedrill, bug).
pokemontype(beedrill, poison).
pokemontype(beedrill, flying).
pokemontype(pidgey, normal).
pokemontype(pidgey, flying).
pokemontype(pidgeotto, normal).
pokemontype(pidgeotto, flying).
pokemontype(pidgeot, normal).
pokemontype(pidgeot, flying).
pokemontype(rattata, normal).
pokemontype(raticate, normal).
pokemontype(spearow, normal).
pokemontype(spearow, flying).
pokemontype(fearow, normal).
pokemontype(fearow, flying).
pokemontype(ekans, poison).
pokemontype(arbok, poison).
pokemontype(pikachu, electric).
pokemontype(raichu, electric).
pokemontype(sandshrew, ground).
pokemontype(sandslash, ground).
pokemontype(nidoran, poison).
pokemontype(nidorina, poison).
pokemontype(nidoqueen, poison).
pokemontype(nidoqueen, ground).
pokemontype(nidoran, poison).
pokemontype(nidorino, poison).
pokemontype(nidoking, poison).
pokemontype(nidoking, ground).
pokemontype(clefairy, normal).
pokemontype(clefable, normal).
pokemontype(vulpix, fire).
pokemontype(ninetales, fire).
pokemontype(jigglypuff, normal).
pokemontype(wigglytuff, normal).
pokemontype(zubat, poison).
pokemontype(zubat, flying).
pokemontype(golbat, poison).
pokemontype(golbat, flying).
pokemontype(oddish, grass).
pokemontype(oddish, poison).
pokemontype(gloom, grass).
pokemontype(gloom, poison).
pokemontype(vileplume, grass).
pokemontype(vileplume, poison).
pokemontype(paras, bug).
pokemontype(paras, grass).
pokemontype(parasect, bug).
pokemontype(parasect, grass).
pokemontype(venonat, bug).
pokemontype(venonat, poison).
pokemontype(venomoth, bug).
pokemontype(venomoth, poison).
pokemontype(venomoth, flying).
pokemontype(diglett, ground).
pokemontype(dugtrio, ground).
pokemontype(meowth, normal).
pokemontype(persian, normal).
pokemontype(psyduck, water).
pokemontype(golduck, water).
pokemontype(mankey, fighting).
pokemontype(primeape, fighting).
pokemontype(growlithe, fire).
pokemontype(arcanine, fire).
pokemontype(poliwag, water).
pokemontype(poliwhirl, water).
pokemontype(poliwrath, water).
pokemontype(poliwrath, fighting).
pokemontype(abra, psyhic).
pokemontype(kadabra, psyhic).
pokemontype(alakazam, psyhic).
pokemontype(machop, fighting).
pokemontype(machoke, fighting).
pokemontype(machamp, fighting).
pokemontype(bellsprout, grass).
pokemontype(bellsprout, poison).
pokemontype(weepinbell, grass).
pokemontype(weepinbell, poison).
pokemontype(victreebel, grass).
pokemontype(victreebel, poison).
pokemontype(tentacool, water).
pokemontype(tentacool, poison).
pokemontype(tentacruel, water).
pokemontype(tentacruel, poison).
pokemontype(geodude, rock).
pokemontype(geodude, ground).
pokemontype(graveler, rock).
pokemontype(graveler, ground).
pokemontype(golem, rock).
pokemontype(golem, ground).
pokemontype(ponyta, fire).
pokemontype(rapidash, fire).
pokemontype(slowpoke, water).
pokemontype(slowpoke, psyhic).
pokemontype(slowbro, water).
pokemontype(slowbro, psyhic).
pokemontype(magnemite, electric).
pokemontype(magneton, electric).
pokemontype(farfetchd, normal).
pokemontype(farfetchd, flying).
pokemontype(doduo, normal).
pokemontype(doduo, flying).
pokemontype(dodrio, normal).
pokemontype(dodrio, flying).
pokemontype(seel, water).
pokemontype(dewgong, water).
pokemontype(dewgong, ice).
pokemontype(grimer, poison).
pokemontype(muk, poison).
pokemontype(shellder, water).
pokemontype(cloyster, water).
pokemontype(cloyster, ice).
pokemontype(gastly, ghost).
pokemontype(haunter, ghost).
pokemontype(gengar, ghost).
pokemontype(gengar, poison).
pokemontype(onix, rock).
pokemontype(onix, ground).
pokemontype(drowzee, psyhic).
pokemontype(hypno, psyhic).
pokemontype(krabby, water).
pokemontype(kingler, water).
pokemontype(voltorb, electric).
pokemontype(electrode, electric).
pokemontype(exeggcute, grass).
pokemontype(exeggcute, psyhic).
pokemontype(exeggutor, grass).
pokemontype(exeggutor, psyhic).
pokemontype(cubone, ground).
pokemontype(marowak, ground).
pokemontype(hitmonlee, fighting).
pokemontype(hitmonchan, fighting).
pokemontype(lickitung, normal).
pokemontype(koffing, poison).
pokemontype(weezing, poison).
pokemontype(rhyhorn, ground).
pokemontype(rhyhorn, rock).
pokemontype(rhydon, ground).
pokemontype(rhydon, rock).
pokemontype(chansey, normal).
pokemontype(tangela, grass).
pokemontype(kangaskhan, normal).
pokemontype(horsea, water).
pokemontype(seadra, water).
pokemontype(goldeen, water).
pokemontype(seaking, water).
pokemontype(staryu, water).
pokemontype(starmie, water).
pokemontype(starmie, psyhic).
pokemontype(mrmime, psyhic).
pokemontype(mrmime, flying).
pokemontype(scyther, bug).
pokemontype(scyther, flying).
pokemontype(jynx, ice).
pokemontype(jynx, psyhic).
pokemontype(electabuzz, electric).
pokemontype(magmar, fire).
pokemontype(pinsir, bug).
pokemontype(tauros, normal).
pokemontype(magikarp, water).
pokemontype(gyarados, water).
pokemontype(gyarados, flying).
pokemontype(lapras, water).
pokemontype(lapras, ice).
pokemontype(ditto, normal).
pokemontype(eevee, normal).
pokemontype(vaporeon, water).
pokemontype(jolteon, electric).
pokemontype(flareon, fire).
pokemontype(porygon, normal).
pokemontype(omanyte, rock).
pokemontype(omanyte, water).
pokemontype(omastar, rock).
pokemontype(omastar, water).
pokemontype(kabuto, rock).
pokemontype(kabuto, water).
pokemontype(kabutops, rock).
pokemontype(kabutops, water).
pokemontype(aerodactyl, rock).
pokemontype(aerodactyl, flying).
pokemontype(snorlax, normal).
pokemontype(articuno, ice).
pokemontype(articuno, flying).
pokemontype(zapdos, electric).
pokemontype(zapdos, flying).
pokemontype(moltres, fire).
pokemontype(moltres, flying).
pokemontype(dratini, dragon).
pokemontype(dragonair, dragon).
pokemontype(dragonite, dragon).
pokemontype(dragonite, flying).
pokemontype(mewtwo, psyhic).
pokemontype(mew, psyhic).
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