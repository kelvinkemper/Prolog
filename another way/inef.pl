:- [adt_luger].

% state(W1,W2,W3,V1,V2,V3,Boat)
% Start: state(e,e,e,e,e,e,e)
% Goal: state(w,w,w,w,w,w,w)
% W1,W2,W3 = werewolves 1 to 3; V1,V2,V3 = vampires 1 to 3
% boat = boat location

% unsafe will be when more werewolves on one side of river compared to vampires
% also included is if number of werewolves or vampires is negative
unsafe(state(X, X, X, X, Y, Y, Z)) :- opp(X,Y). % 3 Werewolves east, vamp1  east
unsafe(state(X, X, X, Y, X, Y, Z)) :- opp(X,Y). % 3 werewolves east, vamp2 east
unsafe(state(X, X, X, Y, Y, X, Z)) :- opp(X,Y). % 3 werewolves east, vamp3 east
unsafe(state(X, X, X, X, X, Y, Z)) :- opp(X,Y).
unsafe(state(X, X, X, Y, X, X, Z)) :- opp(X,Y).
unsafe(state(X, X, X, X, Y, X, Z)) :- opp(X,Y).
unsafe(state(X, X, Y, X, Y, Y, Z)) :- opp(X,Y).
unsafe(state(X, X, Y, Y, X, Y, Z)) :- opp(X,Y).
unsafe(state(X, X, Y, Y, Y, X, Z)) :- opp(X,Y).
unsafe(state())


% moves include movement of vampire/werewolf east or west:
    % 1 vampire and 1 werewolf moves 
    % 2 vampires move
    % 2 werewolves move
    % 1 vampire moves
    % 1 werewolf moves

move(state(EV, WV, EW, WW, X), state(New_EV, New_WV, New_EW, New_WW, Y)) :-
    New_EV is EV+1,
    New_WV is WV-1,
    New_EW is EW+1,
    New_WW is WW-1,
    opp(X, Y), safe(New_EV, New_WV, New_EW, New_WW).
    % writelist(['1 v and 1 w move', EV, WV, EW, WW, Boat]).
move(state(EV, WV, EW, WW, X), state(New_EV, New_WV, EW, WW, Y)) :-
    New_EV is EV+2,
    New_WV is WV-2,
    opp(X, Y), safe(New_EV, New_WV, EW, WW).
    % writelist(['2 v move', EV, WV, EW, WW, Boat]).
move(state(EV, WV, EW, WW, X), state(EV, WV, New_EW, New_WW, Y)) :-
    New_EW is EW+2,
    New_WW is WW-2,
    opp(X, Y), safe(EV, WV, New_EW, New_WW).
    % writelist(['2 w move', EV, WV, EW, WW, Boat]).    
move(state(EV, WV, EW, WW, X), state(New_EV, New_WV, EW, WW, Y)) :-
    New_EV is EV+1,
    New_WV is WV-1,
    opp(X, Y), safe(New_EV, New_WV, EW, WW).
    % writelist(['1 v move', EV, WV, EW, WW, Boat]).
move(state(EV, WV, EW, WW, X), state(EV, WV, New_EW, New_WW, Y)) :-
    New_EW is EW+1,
    New_WW is WW-1,
    opp(X, Y), safe(EV, WV, New_EW, New_WW).
   % writelist(['2 w move', EV, WV, EW, WW, Boat]).  


move(state(EV, WV, EW, WW, X), state(New_EV, New_WV, New_EW, New_WW, Y)) :-
    New_EV is EV-1,
    New_WV is WV+1,
    New_EW is EW-1,
    New_WW is WW+1,
    opp(X, Y), safe(New_EV, New_WV, New_EW, New_WW).
    % writelist(['1 v and 1 w move east to west', EV, WV, EW, WW, Boat]).
move(state(EV, WV, EW, WW,X), state(New_EV, New_WV, EW, WW, Y)) :-
    New_EV is EV-2,
    New_WV is WV+2,
    opp(X, Y), safe(New_EV, New_WV, EW, WW).
   % writelist(['2 v move e2w', EV, WV, EW, WW, Boat]).
move(state(EV, WV, EW, WW, X), state(EV, WV, New_EW, New_WW, Y)) :-
    New_EW is EW-2,
    New_WW is WW+2,
    opp(X, Y), safe(EV, WV, New_EW, New_WW).
    % writelist(['2 w move', EV, WV, EW, WW, Boat]).    
move(state(EV, WV, EW, WW, X), state(New_EV, New_WV, EW, WW, Y)) :-
    New_EV is EV-1,
    New_WV is WV+1,
    opp(X, Y), safe(New_EV, New_WV, EW, WW).
    % writelist(['1 v move', EV, WV, EW, WW, Boat]).
move(state(EV, WV, EW, WW, X), state(EV, WV, New_EW, New_WW, Y)) :-
    New_EW is EW - 1,
    New_WW is WW + 1,
    opp(X, Y), safe(EV, WV, New_EW, New_WW).
    % writelist(['2 w move', EV, WV, EW, WW, Boat]).  


%move(state(EV, WV, EW, WW, Boat), state(EV, WV, EW, WW)) :- 
%    writelist([ 'BACKTRACK at:', EV, WV, EW, WW, Boat]), fail.
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

go(Start, Goal) :- 
    empty_stack(Empty_been_stack),
    stack(Start, Empty_been_stack, Been_stack),
    path(Start, Goal, Been_stack).

test :- go(state(0,3,0,3,e), state(3,0,3,0,w)).