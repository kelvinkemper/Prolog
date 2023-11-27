go(Start, Goal) :- 
    empty_stack(Empty_open),
    stack([Start, nil], Empty_open, Open_stack),
    empty_set(Closed_set),
    path(Open_stack, Closed_set, Goal). 

path(Open_stack, _, _) :-
    empty_stack(Open_stack),
    write('No solution found with these rules').
path(Open_stack, Closed_set, Goal) :-
    stack([State, Parent], _, Open_stack),
    State = Goal,
    write('A Solution is Found!'), nl,
    printsolution([State, Parent], Closed_set).
path(Open_stack, Closed_set, Goal) :-
    stack([State, Parent], Rest_open_stack,
        Open_stack),
    get_children(State, Rest_open_stack, Closed_set,
        Children),
    add_list_to_stack(Children, Rest_open_stack,
        New_open_stack),
union([[State, Parent]], Closed_set,
        New_closed_set),
path(New_open_stack, New_closed_set, Goal), !.
get_children(State, Rest_open_stack, Closed_set,
        Children) :-
bagof(Child, moves(State, Rest_open_stack,
        Closed_set, Child), Children).

moves(State, Rest_open_stack, Closed_set, [Next,
        State]) :-
    move(State, Next),
    not(unsafe(Next)), % test depends on problem
    not(member_stack([Next,_], Rest_open_stack)),
    not(member_set([Next,_], Closed_set)).


reverse_print_stack(S) :-
    empty_stack(S). 
reverse_print_stack(S) :-
    stack(E, Rest, S), reverse_print_stack(Rest), write(E), nl. 