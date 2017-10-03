
:-include(adventure).

% variables must begin w/capital letter!!
%  therefore anything w/capital letter is var
%  for the sake of this file, the syntax 
%  listThings(<someplace>) works as does look(Place). 
%  simply run prolog, then use [notes]. to load this
%  and the adventure file. 

listThings(Place):-location(X,Place),name(X, Name),short_desc(X,SD),format('~w: ~w',[Name,SD]),nl,fail. 
listThings(_).

listThingsLong(Thing):-name(Thing, Name),long_desc(Thing,LD),format('~w(~w) ~NContents: ~w~N',[Name,Thing,LD]),nl,fail. 
listThingsLong(_).

listConnections(Place):-door(Place,Connection),short_desc(Connection, SD),format('~w: ~w,',[Connection,SD]),nl,fail. 
listConnections(_).

writeShortDesc(Thing):-long_desc(Thing, SD), write(SD), nl. 

look(Place):-name(Place,Name),write(Name),nl,write("contains:"),nl,listThings(Place),nl,write("Connected Areas:"),nl,listConnections(Place),nl,write("Area Description:"),nl,writeShortDesc(Place),nl,!.

study(Thing):-listThingsLong(Thing),nl. 

% for checked commands do something like can_look(place), look(place)
%  for checked look, items in inventory are kosher. 
%  move: retract old here assert new here
%  move contains implicit look. 
%  e.g. teleport(P):-here(X), retract(here(X)), assert(here(P)), look(P).
%  take adds item to inventory and removes it from container requires
%   player and item to be in same location
%  put take two things takes item in inventory (might be a room) and where you 
%   intend to place a thing. 
%  retract/assert location has here.... will be dealing with recursion. 
%  CUT(!) demo/example
%

