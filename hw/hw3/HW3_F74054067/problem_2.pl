% problem 2 : Lowest Common Ancestor

ancestor(A,B) :- 
	parent(A,B). %if A is B_parent then A is B_ancestor
ancestor(A,B) :- 
	parent(X,B),ancestor(A,X). %if X is B_parent and A is X_ancestor then A is B_ancesor

lca(A,B,P) :- 
  A==B -> assert(output(P,A));
  ancestor(A,B) -> assert(output(P,A));
  parent(X,A),lca(X,B,P).
 
lcaloop(P) :-
	P > 0, 
	Q is P-1, 
	readln([W,Z]), 
	lca(W,Z,P), 
	lcaloop(Q).
lcaloop(0).

outputloop(R) :-
	R > 0, 
	output(R,S), 
	write(S), nl, 
	T is R - 1, 
	outputloop(T), 
	!.
outputloop(0).
 
createNode(N) :-
	N > 0, 
	M is N - 1, 
	readln([C,D]), 
	assert(parent(C,D)), 
 
	createNode(M),
	!.

createNode(0).
	
main :-
	write('Input : '),
	nl,
	readln([N]),	
	M is N - 1,
	createNode(M),
	readln([O]),
	lcaloop(O),
	write('Output :'),
	nl,
	outputloop(O),
	halt.

	
:- initialization(main).
