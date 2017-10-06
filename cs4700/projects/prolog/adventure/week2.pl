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

%List out all child objects of inventory 
list_inventory(Thing):-has(Thing),tab(2),write_name(Thing),write(" -"),tab(1),write_short(Thing),nl,fail.
list_inventory(_).

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
c_look(Inv_item):-has(Inv_item),look(Inv_item),!.
c_look(Container):-container(Container),location(Container,X),here(X),look(Container),!.

%Unchecked version of move action
teleport(Place):-retract(here(_)),assert(here(Place)),!.

%Checked version of move action
move(Place):-here(Current),connection(Current,Place),teleport(Place),!.

%Completely unchecked Take
summon(Thing):-assert(has(Thing)),retract(location(Thing,_)).

%Unchecked Take
take(Thing):-not(heavy(Thing)),assert(has(Thing)),retract(location(Thing,_)),!,nl,write("You obtained: "),write(Thing),write("."),!.

%Checked Take
c_take(Thing):-not(heavy(Thing)),here(X),is_here(Thing,X),take(Thing),!.
c_take(Thing, Container):-location(Thing,Container),has(Container),take(Thing),!.

%Unchecked Put: put the thing in the room you're in. 
place(Thing):-has(Thing),retract(has(Thing)),here(Place),assert(location(Thing,Place)).
place(Thing,Location):-retract(has(Thing)),assert(location(Thing,Location)).

%Checked put: if in player's location, put thing
c_place(Thing,Location):-here(Location),place(Thing,Location),!.
c_place(Thing,Container):-container(Container),has(Container),place(Thing,Container),!.

%Unchecked (always successful) version of study action
study(Place):-room(Place),look(Place),!.
study(Container):-container(Container),write_name(Container),write(" :"),nl,write_long(Container),nl,list_things(Container),!.
study(Thing):-write_name(Thing),write(" :"),nl,write_long(Thing),!.

%Checked version of study action
c_study(Item):-here(X),is_here(Item,X),study(Item),!.
c_study(Item):-has(Item),study(Item),!.

%Inventory
inventory:-list_inventory(_),!.

%allows prefix notation so 'look bedroom.' is the same as 'look(bedroom).'
:-op(40,fx,look).
:-op(45,fx,study).
