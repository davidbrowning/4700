
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

writeShortDesc(Thing):-short_desc(Thing, SD), write(SD), nl. 

look(Place):-name(Place,Name),write(Name),nl,write("contains:"),nl,listThings(Place),nl,write("Connected Areas:"),nl,listConnections(Place),nl,write("Area Description:"),nl,writeShortDesc(Place),nl,!.

study(Thing):-listThingsLong(Thing),nl. 

