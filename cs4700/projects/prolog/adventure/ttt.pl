:- dynamic cell/2. 
:- dynamic turn/1. 
% -arity
nextturn(x,o).
nextturn(o,x).

can_move(Location):-cell(Location,_),!,fail.
can_move(_).

win(Player):-cell(upperLeft,Player),cell(upperCenter,Player),cell(upperRight,Player).
win(Player):-cell(centerLeft,Player),cell(centerCenter,Player),cell(centerRight,Player).
win(Player):-cell(lowerLeft,Player),cell(lowerCenter,Player),cell(lowerRight,Player).
win(Player):-cell(upperLeft,Player),cell(centerLeft,Player),cell(lowerLeft,Player).
win(Player):-cell(upperCenter,Player),cell(centerCenter,Player),cell(lowerCenter,Player).
win(Player):-cell(upperRight,Player),cell(centerRight,Player),cell(lowerRight,Player).
win(Player):-cell(upperRight,Player),cell(centerCenter,Player),cell(lowerLeft,Player).
win(Player):-cell(upperLeft,Player),cell(centerCenter,Player),cell(lowerRight,Player).

move(Location,Player):-can_move(Location),asserta(cell(Location,Player)).

play(Location):-turn(Player),move(Location,Player),retract(turn(Player)),asserta(turn(Other)).

% go get this from repo, i broke something . 
