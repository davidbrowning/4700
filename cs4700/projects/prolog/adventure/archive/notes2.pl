name(a, "A").
name(b, "B").
name(c, "C").
name(_,'').

location(here, a).
location(here, b).

listThings(L):-location(L,O),writeName(O),fail.
listThings(_).

writeName(T):-name(T,Q),write(Q),nl,!.

