README

Prolog Assignment- Vampires and Werewolves.

State Representation:
the state of the Vampire and Werewolves puzzle is in the form of:
state(WV, WW, EV, EW, Boat).
     
WV stands for West Vampires, WW stands for West Werewolves,
EV stands for East Vampires, EW stands for East Werewolves.
Boat stands for the boat location.

The values of WV, WW, EV, EW are integers while Boat can be either e or w which stands for east or west.

Move Rules:
The move rules are essentially subtracting a value from 1 to 2 of either a vampire or werewolve from
one side of the river then adding that same exact amount to the opposide of the river. Depending on the boat's
inital location, every move rule would ensure that it goes to the opposite side of the river.
I ended up with 10 total move rules. The first 5 move vampires werewolves, and the boat from east to west.
This includes moving 1 vampire, 1 vampire and 1 werewolf, 1 werewolf, 2 werewolves, and 2 vampires.
The second 5 move rules are the exact same just moving the set from west to east.
These rules were able to cover the entire state space as long as the unsafe predicates were followed.

Clever Trick?:
Initially my state representation was state(e,e,e,w,w,w,b) but this made creating the move rules and
unsafe predicates have an enormous amount of different way to represent them. Since the vampires and werewolves
are the same thing except the amount, representing them as numbers made more sense and would reduce the rules needed
to complete the problem.

Source file information:
Some of the source files such as the adt_luger.pl and a couple of predicates in the vampiresAndWerewolves.pl were
taken from Luger's supplementary AI Algorithms, Data Structures and Idioms in Prolog, Lisp, and Java book. 
adt_luger.pl - Chapter 3 and vampiresAndWerewolves.pl predicates from Chapter 4.

### How to run the file in SWI Prolog ###

## This will load the file in prolog.
?- [vampiresAndWerewolves]. 

## test. will run the puzzle from the start state(0,0,3,3,w) to goal state(3,3,0,0,e). 
## It will also provide the output solution.
?- test.


## showValidMoves will show all valid next states for the one you've input
## it uses the syntax
?-showValidMoves(state(1,1,3,3,w)).

## checkEquivalentState will check if 2 states are equivalent.
?- checkEquivalentState(state(3,3,0,0,e), state(3,3,0,0,e)).
True.
