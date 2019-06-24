% problem 3 : Reachable

path(A,B) :-
	walk(A,B,[]).

walk(A,B,Visited) :- 
	edge(A,X),
	not(memberchk(X,Visited)), 
	(	B = X;          
		walk(X,B,[A|Visited]) ).
	
reachable(G,H,P) :-
	path(G,H) -> assert(output(P, 'Yes'));
	assert(output(P, 'No')).

loop(P) :-
	P>0, 
	Q is P-1, 
	readln([W,Z]), 
	reachable(W,Z,P), 
	loop(Q).
loop(0).
 
outputloop(R) :-
	R > 0, 
	output(R,S), 
	write(S), 
	nl, 
	T is R - 1, 
	outputloop(T), 
	!.
outputloop(0). 
 
createEdge(N) :-
	N > 0, 
	M is N - 1, 
	readln([C,D]), 
	assert(edge(C,D)),
	assert(edge(D,C)), 
	createEdge(M),
	!.

createEdge(0).
	
main :-
	write('Input :'),
	nl,
	readln([_,E]),
	createEdge(E),
	readln([O]),
	loop(O),
	write('Output :'),
	nl,
	outputloop(O),
	halt.
	
:- initialization(main).
