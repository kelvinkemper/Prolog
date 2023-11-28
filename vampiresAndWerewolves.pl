:- [bfs],[adt_luger].


% state(WV, WW, EV, EW, Boat)
% Start: state(0,0,3,3,w)
% Goal: state(3,3,0,0,e)
% WV = west vampires , EV = east vampires
% WW west werewolves, EW = east werewolves 
% boat = boat location

% unsafe will be when more werewolves on one side of river compared to vampires
% also if number of werewolves or vampires is negative
unsafe(WV, WW, EV, EW) :- 
	(EV < EW, EV > 0);
	(WV < WW, WV > 0);
    EV<0, EW<0, WV<0, WW<0.

% moves include movement of vampire/werewolf east or west:
    % 1 vampire and 1 werewolf moves
    % 2 vampires move
    % 2 werewolves move
    % 1 vampire moves
    % 1 werewolf move
% 5 of these total for west to east then another 5 for going east to west

move(state(WV, WW, EV, EW, e), state(New_WV, New_WW, New_EV, New_EW, w)) :-
    EV > 0, EW > 0,
    New_EV is EV-1,
    New_WV is WV+1,
    New_EW is EW-1,
    New_WW is WW+1,
    not(unsafe(New_WV, New_WW, New_EV, New_EW)),
    writelist(['east->west boat, -1 east vamp and wolf, +1 west vamp and wolf']).

move(state(WV, WW, EV, EW, e), state(New_WV, WW, New_EV, EW, w)) :-
    EV > 1,
    New_EV is EV-2,
    New_WV is WV+2,
    not(unsafe(New_WV, WW, New_EV, EW)),
    writelist(['east->west boat, -2 east vamp, +2 west vamp']).
    
move(state(WV, WW, EV, EW, e), state(WV, New_WW, EV, New_EW, w)) :-
    EW > 1,
    New_EW is EW-2,
    New_WW is WW+2,
    not(unsafe(WV, New_WW, EV, New_EW)),
    writelist(['east->west boat, -2 east wolf, +2 west wolf']).
        
move(state(WV, WW, EV, EW, e), state(New_WV, WW, New_EV, EW, w)) :-
    EV > 0,
    New_EV is EV-1,
    New_WV is WV+1,
    not(unsafe(New_WV, WW, New_EV, EW)),
    writelist(['east->west boat, -1 east vamp, +1 west vamp']).

move(state(WV, WW, EV, EW, e), state(WV, New_WW, EV, New_EW, w)) :-
    EW > 0,
    New_EW is EW-1,
    New_WW is WW+1,
    not(unsafe(WV, New_WW, EV, New_EW)),
    writelist(['east->west boat, -1 east wolf, +1 west wolf']).
    
move(state(WV, WW, EV, EW, w), state(New_WV, New_WW, New_EV, New_EW, e)) :-
    WV > 0, WW > 0,
    New_EV is EV+1,
    New_WV is WV-1,
    New_EW is EW+1,
    New_WW is WW-1,
    not(unsafe(New_WV, New_WW, New_EV, New_EW)),
    writelist(['west->east, -1 west vamp and wolf and +1 east vamp andwolf']).
   
move(state(WV, WW, EV, EW, w), state(New_WV, WW, New_EV, EW, e)) :-
    WV > 1,
    New_EV is EV+2,
    New_WV is WV-2,
    not(unsafe(New_WV, WW, New_EV, EW)),
    writelist(['west->east, -2 west vamps and +2 east vamps']).
  
move(state(WV, WW, EV, EW, w), state(WV, New_WW, EV, New_EW, e)) :-
    WW > 1,
    New_EW is EW+2,
    New_WW is WW-2,
    not(unsafe(WV, New_WW, EV, New_EW)),
    writelist(['west->east, -2 west wolves and +2 east wolves']).
    
move(state(WV, WW, EV, EW, w), state(New_WV, WW, New_EV, EW, e)) :-
    WV > 0,
    New_EV is EV+1,
    New_WV is WV-1,
    not(unsafe(New_WV, WW, New_EV, EW)),
    writelist(['west->east, -1 west vamp and +1 east vamp']).
    
move(state(WV, WW, EV, EW, w), state(WV, New_WW, EV, New_EW, e)) :-
    WW > 0,
    New_EW is EW + 1,
    New_WW is WW - 1,
    not(unsafe(WV, New_WW, EV, New_EW)),
    writelist(['west->east, -1 west wolf and +1 east wolf']).


% path predicates taken from Luger Chapter 4.2 
% base case path predicate, when current state is goal state,
% reverse print the stack to show solution
path(Goal, Goal, Been_stack) :- 
    write('Solution Path Is: ' ), nl, 
    reverse_print_stack(Been_stack).

% checks whether a state is a valid next state.
% not member checks Next_state has been a visited before
% add to stack if above is true
% recursively do it again
path(State, Goal, Been_stack) :- 
    move(State, Next_state), 
    not(member_stack(Next_state, Been_stack)), 
    stack(Next_state, Been_stack, New_been_stack),
    path(Next_state, Goal, New_been_stack), !.


go(Start, Goal) :- 
    empty_stack(Empty_been_stack),
    stack(Start, Empty_been_stack, Been_stack),
    path(Start, Goal, Been_stack).

test :- go(state(0,0,3,3,e), state(3,3,0,0,w)).

writelist([ ]). writelist([H | T]) :- write(H), nl, writelist(T).

showValidMoves(State, ValidMoves) :-
    findall(NextState, move(State,NextState), ValidMoves).

checkEquivalentState(state(WV, WW, EV, EW, B), state(New_WV, New_WW, New_EV, New_EW, New_B)) :-
    WV = New_WV,
    WW = New_WW,
    EV = New_EV,
    EW = New_EW,
    B = New_B.

% test_initial_move :-
%    InitialState = state(0,0,3,3,e),
%    move(InitialState, NextState),
%    writelist(NextState).

