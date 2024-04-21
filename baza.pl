/* Rule to find duplicated elements on the list*/
removeCommon([], _, []).
removeCommon([H|T], List2, [H|Result]) :-
    \+ member(H, List2),
    removeCommon(T, List2, Result).
removeCommon([H|T], List2, Result) :-
    member(H, List2),
    select(H, List2, NewList2),
    removeCommon(T, NewList2, Result).
    
/* Rule to find pokemons of specified types */
findPokemonOfType([], []).
findPokemonOfType([Type|Rest], Pokemons) :-
    findall(Pokemon, (pokemontype(Pokemon, Types), member(Type, Types)), PokemonList),
    findPokemonOfType(Rest, RestPokemons),
    append(PokemonList, RestPokemons, Pokemons).

/*pokemon -> kontry w niego */
effectiveAgainst(Pokemon, Typy):-
    pokemontype(Pokemon, Typ),                                                         
    effectiveAgainstHelper(Typ, Typy).

effectiveAgainstHelper([], _).
effectiveAgainstHelper([Typ|Rest], Typy):-
   findall(Kontra, (efdamage(Kontra, Typ, KontraValue), KontraValue > 1.0), KontraList),
    write('Kontry dla '), write(Typ), write(': '), write(KontraList), nl,
    effectiveAgainstHelper(Rest, Typy).



/* Rule to find types that counter a given types */
findCounter([Type], Result) :-
    findall(Counter, (efdamage(Counter, Type, CounterValue), CounterValue > 1.0), CounterList),
    list_to_set(CounterList, Result),
    write('Efektywne kontry dla '), write(Type), write(' to: '), nl,
    write(Result), nl.

findCounter([Type1, Type2], NewResult) :-
    findall(Counter, (efdamage(Counter, Type1, CounterValue), CounterValue > 1.0), CounterList1),
    findall(Counter, (efdamage(Counter, Type2, CounterValue), CounterValue > 1.0), CounterList2),
    append(CounterList1, CounterList2, CounterList),
    removeNeutral(Type1, Type2, CounterList, FilteredCounterList),
    list_to_set(FilteredCounterList, UniqueCounterList),
    removeCommon(FilteredCounterList, UniqueCounterList, Result),
    write('Efektywne kontry dla '), write(Type1), write(' i '), write(Type2), write(' to: '), nl,
    write(UniqueCounterList), nl,
    
    (
        (Result = [] -> write(' Pokemon nie posiada kontr super efektywnych.'), append([normal], [], NewResult);
        write('Super efektywne kontry dla '), write(Type1), write(' i '), write(Type2), write(' to: '), nl,
         NewResult = Result, write(NewResult), nl)  
    ).

/* Rule to remove types that neutralize against any given types */
removeNeutral(_, _, [], []).
removeNeutral(Type1, Type2, [Counter|Rest], FilteredCounterList) :-
    (neutralAgainstAny(Counter, Type1, Type2) ->
        removeNeutral(Type1, Type2, Rest, FilteredCounterList)
    ; 
        FilteredCounterList = [Counter|FilteredRest],
        removeNeutral(Type1, Type2, Rest, FilteredRest)
    ).

/* Rule to check if the type is neutral against any of the given types */
neutralAgainstAny(Type, Type1, Type2) :-
    neutralAgainst(Type, Type1);
    neutralAgainst(Type, Type2).

/* Rule to check if the type is neutral against the given type */
neutralAgainst(Type, Against) :-
    efdamage(Against, Type, Modifier),
    Modifier =:= 1.0.

/* Rule to suggest pokemon 2 to team */
findTeamPokemon2(Pokemon) :-
    pokemontype(Pokemon, Type),
    findCounter(Type, Weaknesses),
    write('Proponuje pokemony typu: '), write(Weaknesses), write(' na miejsce nr. 2 w duzynie:' ), nl,
    findPokemonOfType(Weaknesses, Pokemons),
    write(Pokemons), nl.

/* Rule to suggest pokemon nr 3 to team */
findTeamPokemon3([Pokemon1, Pokemon2], Pokemons) :-
    pokemontype(Pokemon1, [Type1, _]),
    pokemontype(Pokemon2, [Type2, _]),
    (
        Type2 = normal ->
            findall(GhostPokemon, (pokemontype(GhostPokemon, [ghost, _])), GhostPokemonList),
            write('Ze wzgledu na wczesniej wybranego pokemona typu normal proponuje pokemony typu ghost na miejsce nr 3 w druzynie: '), nl,
            Pokemons = GhostPokemonList
        ;
            findCounter([Type1, Type2], Weaknesses),
            write('Proponuje pokemony typu: '), write(Weaknesses), write(' na miejsce nr. 3 w druzynie:' ), nl,
            findPokemonOfType(Weaknesses, Pokemons)
    ),
    write(Pokemons), nl.



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
/* 1ST GEN POKEMONS */
pokemontype(bulbasaur, [grass, poison]).
pokemontype(ivysaur, [grass, poison]).
pokemontype(venusaur, [grass, poison]).
pokemontype(charmander, [fire, fire]).
pokemontype(charmeleon, [fire, fire]).
pokemontype(charizard, [fire, flying]).
pokemontype(squirtle, [water, water]).
pokemontype(wartortle, [water, water]).
pokemontype(blastoise, [water, water]).
pokemontype(caterpie, [bug, bug]).
pokemontype(metapod, [bug, bug]).
pokemontype(butterfree, [bug, flying]).
pokemontype(weedle, [bug, poison]).
pokemontype(kakuna, [bug, poison]).
pokemontype(beedrill, [bug, poison]).
pokemontype(pidgey, [normal, flying]).
pokemontype(pidgeotto, [normal, flying]).
pokemontype(pidgeot, [normal, flying]).
pokemontype(rattata, [normal, normal]).
pokemontype(raticate, [normal, normal]).
pokemontype(spearow, [normal, flying]).
pokemontype(fearow, [normal, flying]).
pokemontype(ekans, [poison, poison]).
pokemontype(arbok, [poison, poison]).
pokemontype(pikachu, [electric, electric]).
pokemontype(raichu, [electric, electric]).
pokemontype(sandshrew, [ground, ground]).
pokemontype(sandslash, [ground, ground]).
pokemontype(nidoran, [poison, poison]).
pokemontype(nidorina, [poison, poison]).
pokemontype(nidoqueen, [poison, ground]).
pokemontype(nidoran, [poison, poison]).
pokemontype(nidorino, [poison, poison]).
pokemontype(nidoking, [poison, ground]).
pokemontype(clefairy, [normal, normal]).
pokemontype(clefable, [normal, normal]).
pokemontype(vulpix, [fire, fire]).
pokemontype(ninetales, [fire, fire]).
pokemontype(jigglypuff, [normal, normal]).
pokemontype(wigglytuff, [normal, normal]).
pokemontype(zubat, [poison, flying]).
pokemontype(golbat, [poison, flying]).
pokemontype(oddish, [grass, poison]).
pokemontype(gloom, [grass, poison]).
pokemontype(vileplume, [grass, poison]).
pokemontype(paras, [bug, grass]).
pokemontype(parasect, [bug, grass]).
pokemontype(venonat, [bug, poison]).
pokemontype(venomoth, [bug, poison]).
pokemontype(diglett, [ground, ground]).
pokemontype(dugtrio, [ground, ground]).
pokemontype(meowth, [normal, normal]).
pokemontype(persian, [normal, normal]).
pokemontype(psyduck, [water, water]).
pokemontype(golduck, [water, water]).
pokemontype(mankey, [fighting, fighting]).
pokemontype(primeape, [fighting, fighting]).
pokemontype(growlithe, [fire, fire]).
pokemontype(arcanine, [fire, fire]).
pokemontype(poliwag, [water, water]).
pokemontype(poliwhirl, [water, water]).
pokemontype(poliwrath, [water, fighting]).
pokemontype(abra, [psyhic, psyhic]).
pokemontype(kadabra, [psyhic, psyhic]).
pokemontype(alakazam, [psyhic, psyhic]).
pokemontype(machop, [fighting, fighting]).
pokemontype(machoke, [fighting, fighting]).
pokemontype(machamp, [fighting, fighting]).
pokemontype(bellsprout, [grass, poison]).
pokemontype(weepinbell, [grass, poison]).
pokemontype(victreebel, [grass, poison]).
pokemontype(tentacool, [water, poison]).
pokemontype(tentacruel, [water, poison]).
pokemontype(geodude, [rock, ground]).
pokemontype(graveler, [rock, ground]).
pokemontype(golem, [rock, ground]).
pokemontype(ponyta, [fire, fire]).
pokemontype(rapidash, [fire, fire]).
pokemontype(slowpoke, [water, psyhic]).
pokemontype(slowbro, [water, psyhic]).
pokemontype(magnemite, [electric, electric]).
pokemontype(magneton, [electric, electric]).
pokemontype(farfetchd, [normal, flying]).
pokemontype(doduo, [normal, flying]).
pokemontype(dodrio, [normal, flying]).
pokemontype(seel, [water, water]).
pokemontype(dewgong, [water, ice]).
pokemontype(grimer, [poison, poison]).
pokemontype(muk, [poison, poison]).
pokemontype(shellder, [water, water]).
pokemontype(cloyster, [water, ice]).
pokemontype(gastly, [ghost, poison]).
pokemontype(haunter, [ghost, poison]).
pokemontype(gengar, [ghost, poison]).
pokemontype(onix, [rock, ground]).
pokemontype(drowzee, [psyhic, psyhic]).
pokemontype(hypno, [psyhic, psyhic]).
pokemontype(krabby, [water, water]).
pokemontype(kingler, [water, water]).
pokemontype(voltorb, [electric, electric]).
pokemontype(electrode, [electric, electric]).
pokemontype(exeggcute, [grass, psyhic]).
pokemontype(exeggutor, [grass, psyhic]).
pokemontype(cubone, [ground, ground]).
pokemontype(marowak, [ground, ground]).
pokemontype(hitmonlee, [fighting, fighting]).
pokemontype(hitmonchan, [fighting, fighting]).
pokemontype(lickitung, [normal, normal]).
pokemontype(koffing, [poison, poison]).
pokemontype(weezing, [poison, poison]).
pokemontype(rhyhorn, [ground, rock]).
pokemontype(rhydon, [ground, rock]).
pokemontype(chansey, [normal, normal]).
pokemontype(tangela, [grass, grass]).
pokemontype(kangaskhan, [normal, normal]).
pokemontype(horsea, [water, water]).
pokemontype(seadra, [water, water]).
pokemontype(goldeen, [water, water]).
pokemontype(seaking, [water, water]).
pokemontype(staryu, [water, water]).
pokemontype(starmie, [water, psyhic]).
pokemontype(mrmime, [psyhic, fairy]).
pokemontype(scyther, [bug, flying]).
pokemontype(jynx, [ice, psyhic]).
pokemontype(electabuzz, [electric, electric]).
pokemontype(magmar, [fire, fire]).
pokemontype(pinsir, [bug, bug]).
pokemontype(tauros, [normal, normal]).
pokemontype(magikarp, [water, water]).
pokemontype(gyarados, [water, flying]).
pokemontype(lapras, [water, ice]).
pokemontype(ditto, [normal, normal]).
pokemontype(eevee, [normal, normal]).
pokemontype(vaporeon, [water, water]).
pokemontype(jolteon, [electric, electric]).
pokemontype(flareon, [fire, fire]).
pokemontype(porygon, [normal, normal]).
pokemontype(omanyte, [rock, water]).
pokemontype(omastar, [rock, water]).
pokemontype(kabuto, [rock, water]).
pokemontype(kabutops, [rock, water]).
pokemontype(aerodactyl, [rock, flying]).
pokemontype(snorlax, [normal, normal]).
pokemontype(articuno, [ice, flying]).
pokemontype(zapdos, [electric, flying]).
pokemontype(moltres, [fire, flying]).
pokemontype(dratini, [dragon, dragon]).
pokemontype(dragonair, [dragon, dragon]).
pokemontype(dragonite, [dragon, flying]).
pokemontype(mewtwo, [psyhic, psyhic]).
pokemontype(mew, [psyhic, psyhic]).
