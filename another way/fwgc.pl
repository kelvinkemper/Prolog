:- [adt_luger].

writelist([ ]). writelist([H | T]) :- write(H), nl, writelist(T).

unsafe(state(X, Y, Y, C)) :- opp(X, Y).
unsafe(state(X, W, Y, Y)) :- opp(X, Y).

move(state(X, X, G, C), state(Y, Y, G, C)) :- 
    opp(X, Y), not(unsafe(state(Y, Y, G, C))), 
    writelist(['try farmer - wolf', Y, Y, G, C]).
move(state(X, W, X, C), state(Y, W, Y, C)) :- 
    opp(X, Y), not(unsafe(state(Y, W, Y, C))), 
    writelist(['try farmer - goat', Y, W, Y, C]). 
move(state(X, W, G, X), state(Y, W, G, Y)) :- 
    opp(X, Y), not(unsafe(state(Y, W, G, Y))), 
    writelist(['try farmer - cabbage', Y, W, G, Y]).
move(state(X, W, G, C), state(Y, W, G, C)) :- 
    opp(X, Y), not(unsafe(state(Y, W, G, C))), 
    writelist(['try farmer by self', Y, W, G, C]).
move(state(F, W, G, C), state(F, W, G, C)) :- 
    writelist([ 'BACKTRACK at:', F, W, G, C]), fail.
path(Goal, Goal, Been_stack) :- 
    write('Solution Path Is: ' ), nl, 
    reverse_print_stack(Been_stack).
path(State, Goal, Been_stack) :- 
    move(State, Next_state), 
    not(member_stack(Next_state, Been_stack)), 
    stack(Next_state, Been_stack, New_been_stack), 
    path(Next_state, Goal, New_been_stack), !.
opp(e, w). 
opp(w, e).


go(Start, Goal) :- empty_stack(Empty_been_stack), stack(Start, Empty_been_stack, Been_stack),path(Start, Goal, Been_stack). 

test :- go(state(w,w,w,w), state(e,e,e,e)). 