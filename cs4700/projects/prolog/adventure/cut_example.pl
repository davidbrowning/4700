name(a, "A").
name(_,'').

rite(O):-name(O,N),!, write(N).

