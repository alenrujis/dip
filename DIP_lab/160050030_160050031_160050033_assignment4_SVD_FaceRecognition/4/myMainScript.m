 A = [1 2 3;3 5 7;7 5 9];
[U,S,V]=MySVD(A);
Result =U*S*V';



difference=all(all(A-Result));
