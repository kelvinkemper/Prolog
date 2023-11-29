%%%%% From Luger AI Algorithms, Data Structures and Idioms in Prolog, Lisp, and Java Chapter 3.

empty_stack([ ]). 

stack(Top, Stack, [Top | Stack]).

member_stack(Element, Stack) :-
    member(Element, Stack).  

add_list_to_stack(List, Stack, Result) :-
    append(List, Stack, Result). 

reverse_print_stack(S) :-
    empty_stack(S). 
reverse_print_stack(S) :-
    stack(E, Rest, S),
    reverse_print_stack(Rest),
    write(E), nl.  

% % % % ADT QUEUE % % % %
empty_queue([ ]).  
enqueue(E, [ ], [E]).
enqueue(E, [H | T], [H | Tnew]) :-
    enqueue(E, T, Tnew).  

dequeue(E, [E | T], T). 
dequeue(E, [E | T], _). 

member_queue(Element, Queue) :- 
    member(Element, Queue). 

add_list_to_queue(List, Queue, Newqueue) :- 
    append(Queue, List, Newqueue). 

% % % % ADT PQ % % % %
insert_pq(State, [ ], [State]) :- !.
insert_pq(State, [H | Tail], [State, H | Tail]) :-
    precedes(State, H). 
insert_pq(State, [H | T], [H | Tnew]) :-
    insert_pq(State, T, Tnew).
precedes(X, Y) :- X < Y.     % < depends on problem 

insert_list_pq([ ], L, L). 
insert_list_pq([State | Tail], L, New_L) :- 
    insert_pq(State, L, L2),
    insert_list_pq(Tail, L2, New_L). 

% % % ADT SET % % %
empty_set([ ]). member_set(E, S) :-
    member(E, S). delete_if_in_set(E, [ ], [ ]).
delete_if_in_set(E, [E | T], T) :- !. delete_if_in_set(E, [H | T], [H | T_new]) :-
    delete_if_in_set(E, T, T_new), !.
add_if_not_in_set(X, S, S) :-
    member(X, S), !.
add_if_not_in_set(X, S, [X | S]).
union([ ], S, S). union([H | T], S, S_new) :-
    union(T, S, S2),
    add_if_not_in_set(H, S2, S_new),!.
subset([ ], _). 
subset([H | T], S) :-
    member_set(H, S),subset(T, S).
intersection([ ], _, [ ]).
intersection([H | T], S, [H | S_new]) :-
    member_set(H, S),
    intersection(T, S, S_new), !.
intersection([_ | T], S, S_new) :- 
    intersection(T, S, S_new), !.
set_difference([ ], _, [ ]).
set_difference([H | T], S, T_new) :-
     member_set(H, S), set_difference(T, S, T_new), !.
set_difference([H | T], S, [H | T_new]) :-
    set_difference(T, S, T_new), !.
equal_set(S1, S2) :-
    subset(S1, S2),
    subset(S2, S1). 


member(X,[X|_]).
member(X,[_|T]):-member(X,T).