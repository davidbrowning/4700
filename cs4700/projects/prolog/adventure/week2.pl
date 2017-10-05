:-include(adventure).
%room connections are symmetric
connection(X,Y):-door(X,Y).
connection(X,Y):-door(Y,X).

%Write only the first name or description found
write_name(Object):-name(Object,N),write(N),!.
write_short(Object):-short_desc(Object,Desc),write(Desc),!.
write_long(Object):-long_desc(Object,Desc),write(Desc),!.

%List out all child objects of a location (may be a room or a container
list_things(Place):-location(X,Place),tab(2),write_name(X),write(" -"),tab(1),write_short(X),nl,fail.
list_things(_).

%List out all connections of a room
list_connections(Place):-connection(X,Place),tab(2),write_name(X),write(" -"),tab(1),write_short(X),nl,fail.
list_connections(_).

%Unchecked (always successful) version of look action
look(Place):-room(Place),write_name(Place),write(" :"),nl,write_long(Place),nl,
write('You see: '),nl,list_things(Place),write('You can go to: '),nl,list_connections(Place),!.
look(Container):-container(Container),write_name(Container),write(" :"),nl,write_short(Container),nl,write("It seems there may be something inside."),!.
look(Thing):-write_name(Thing),write(" :"),nl,write_short(Thing),!.

%Look with no arguments means look here.
look:-here(Place),look(Place).

%Recursively determine if a thing is in a location
is_here(Thing,Location):-location(Thing,Container),is_here(Container, Location).
is_here(Thing,Location):-Thing == Location,!.

%Checked version of look action
c_look(Thing):-here(X),is_here(Thing,X),look(Thing),!.
c_look(Place):-here(Place),look(Place),!.
c_look(Container):-container(Container),location(Container,X),here(X),look(Container),!.

%Unchecked version of move action
teleport(Place):-retract(here(_)),assert(here(Place)),!.

%Checked version of move action
move(Place):-here(Current),connection(Current,Place),teleport(Place),!.

%Unchecked (always successful) version of study action
study(Place):-room(Place),look(Place),!.
study(Container):-container(Container),write_name(Container),write(" :"),nl,write_long(Container),nl,list_things(Container),!.
study(Thing):-write_name(Thing),write(" :"),nl,write_long(Thing),!.

%allows prefix notation so 'look bedroom.' is the same as 'look(bedroom).'
:-op(40,fx,look).
:-op(45,fx,study).