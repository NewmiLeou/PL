% problem 1 : Goldbachs conjecture
% Every even integer greater than 2 can be expressed as the sum of two primes.


% Check if N is a prime:
% N is greater than 1.
% N is divisible only by 1 and itself.
% Check P from 2 to sqrt(N).

isPrime(N) :-
	N > 1,
	isPrime(N, 2).

isPrime(N, P) :-
	P =< sqrt(N),
	N mod P =\= 0,
	isPrime(N, P+1).

isPrime(N, P) :-
	P > sqrt(N).


% Find Num1 and Num2:
% Check if Num is greater than 2.
% Check if Num is even.
% Find (Num1, Num2) from (2, Num-2) to (Num/2, Num-Num/2).
% Check if Num1 and Num2 are both primes.

goldbach(Num) :-
	Num > 2,
	Num mod 2 =:= 0,
	NNum1 is 2,
	NNum2 is Num-2,
	goldbach(Num, NNum1, NNum2).

goldbach(Num, Num1, Num2) :-
	isPrime(Num1),
	isPrime(Num2),
    writef('\t'),
	write(Num1),
	write(' '),
	write(Num2),
	nl,
	NNum1 is Num1+1,
	NNum2 is Num2-1,
	goldbach(Num, NNum1, NNum2).

goldbach(Num, Num1, Num2) :-
	Num1 < Num/2,
	NNum1 is Num1+1,
	NNum2 is Num2-1,
	goldbach(Num, NNum1, NNum2).

goldbach(Num, Num1, _) :-
	Num1 >= Num/2.


main :-
	% Input
	write('Input: '),
	readln(Num),
	% Output: summands
	write('Output:'),
	goldbach(Num),
	halt.

:-initialization(main).