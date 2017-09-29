
:-include(adventure).

% variables must begin w/capital letter!!
%  therefore anything w/capital letter is var
%  for the sake of this file, the syntax 
%  listThings(<someplace>) works as does look(Place). 
%  simply run prolog, then use [notes]. to load this
%  and the adventure file. 

listThings(Place):-location(X,Place),name(X, Name), write(Name), nl,fail. 
listThings(_). 

listConnections(Place):-door(Place,Connection),door(Place, Connection), write(Connection),write(","), nl,fail. 
listConnections(_). 

listShortDesc(Place):-short_desc(Place,SD),short_desc(Place, SD), write(SD),write("."), nl,fail. 
listSortDesc(_). 

look(Place):-name(Place,Name),write(Name),nl,write("contains:"),nl,listThings(Place),nl,write("Connected Areas:"),nl,listConnections(Place),nl,write("Area Description:"),nl,listShortDesc(Place),nl.
look(_). 

