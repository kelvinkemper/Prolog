:- [adt_luger].


writelist([ ]). writelist([H | T]) :- write(H), nl, writelist(T).

% state(WV, EV, WW, EW ,Boat)
% Start: state(0,3,0,3,w)
% Goal: state(3,0,3,0,e)
% EV = east vampires, WV = west vampires 
% EW = east werewolves , WW west werewolves
% boat = boat location

% unsafe will be when more werewolves on one side of river compared to vampires
% also included is if number of werewolves or vampires is negative
safe(EV,WV,EW,WW) :-
	EV>=0, EW>=0, WV>=0, WW>=0,
	(EV>=EW ; EV=0),
	(WV>=WW ; WV=0).

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