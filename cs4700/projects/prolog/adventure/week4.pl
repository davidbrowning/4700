:-include(adventure).

:- dynamic quit/1.

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

%write('\33\[2J'),
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
teleport(Place):-retract(here(_)),assert(here(Place)),write('You Teleported!'),!.
u_move(Place):-retract(here(_)),assert(here(Place)),!.

%Checked version of move action
move(Place):-puzzle(Place),here(Current),connection(Current,Place),u_move(Place),look(Place),!.
move(outside):-outside.

outside:-here(Loc),door(Loc,X),outside(X),move(X),!.
outside:-here(Loc),door(X,Loc),outside(X),move(X),!.
outside:-write('No way to go outside'),!.

outside(plaza).
outside(avenue).
outside(eslc_north).
outside(eslc_south).
outside(quad).
outside(roof).
outside(tsc_patio).

%Completely unchecked Take
summon(Thing):-assert(has(Thing)),retract(location(Thing,_)),write('You wizard you').

%Unchecked Take
take(Thing):-not(heavy(Thing)),assert(has(Thing)),retract(location(Thing,_)),!,nl,write("You obtained: "),write(Thing),write("."),!.

%Checked Take
c_take(Thing):-not(heavy(Thing)),here(X),is_here(Thing,X),take(Thing),!.
c_take(Thing, Container):-location(Thing,Container),here(X),is_here(Container,X),take(Thing),!.
c_take(Thing, Container):-has(Container),take(Thing),!.

%Unchecked Put: put the thing in the room you're in. 
place(Thing):-has(Thing),retract(has(Thing)),here(Place),assert(location(Thing,Place)).
place(Thing,Location):-retract(has(Thing)),assert(location(Thing,Location)).

%Checked put: if in player's location, put thing
c_place(Thing,Location):-here(Location),place(Thing,Location),!.
c_place(Thing,Container):-container(Container),has(Container),place(Thing,Container),!.
c_place(Thing,Container):-container(Container),here(X),is_here(Container,X),place(Thing,Container),!.

%Unchecked (always successful) version of study action
study(Place):-room(Place),look(Place),!.
study(Container):-container(Container),write_name(Container),write(" :"),nl,write_long(Container),nl,list_things(Container),!.
study(Thing):-write_name(Thing),write(" :"),nl,write_long(Thing),!.

%Checked version of study action
c_study(Item):-here(X),is_here(Item,X),study(Item),!.
c_study(Item):-has(Item),study(Item),!.

%Inventory
inventory:-list_inventory(_),!.

force_transfer(Disk,Pylon):-retract(location(Disk,_)),assert(location(Disk,Pylon)),!.

win:-location(large_disk,pylon_c),location(medium_disk,pylon_c),location(small_disk,pylon_c),here(secret_lab),write("You win!!"),!.
win:-quit(true),nl,write("You quit... quitter"),nl,!.

transfer(small_disk,Pylon):-here(X),is_here(small_disk,X),retract(location(small_disk,_)),assert(location(small_disk,Pylon)),write('Transfer Successful'),!.
transfer(medium_disk,Pylon):-here(X),is_here(medium_disk,X),not(location(small_disk,Pylon)),location(medium_disk,CurrentLocation),not(location(small_disk,CurrentLocation)),retract(location(medium_disk,_)),assert(location(medium_disk,Pylon)),write('Transfer Successful'),!.
transfer(large_disk,Pylon):-here(X),is_here(large_disk,X),not(location(small_disk,Pylon)),not(location(medium_disk,Pylon)),location(large_disk,CurrentLocation),not(location(small_disk,CurrentLocation)),retract(location(large_disk,_)),assert(location(large_disk,Pylon)),write('Transfer Successful'),!.

has_ingredients([]).
has_ingredients([H|T]):-has(H), has_ingredients(T).

remove_ingredients([]):-!.
remove_ingredients([H|T]):-retract(has(H)), remove_ingredients(T).

make(Item):-create_recipe(E,I,Item),here(X),is_here(E,X),has_ingredients(I),remove_ingredients(I),assert(has(Item)),write('You made a '),write(Item),!.

verb(transfer, ["transfer" | X] - X).
verb(inventory, ["inventory" | X] - X).
verb(make, ["make" | X] - X).
verb(take, ["take" | X] - X).
verb(take, ["pick","up" | X] - X).
verb(take, ["retrieve" | X] - X).
verb(summon, ["summon" | X] - X).
verb(teleport, ["teleport" | X] - X).
verb(teleport, ["teleport","to" | X] - X).
verb(move, ["move" | X] - X).
verb(move,["move","to" | X] - X).
verb(move,["go","to" | X] - X).
verb(move,["go" | X] - X).
verb(look, ["look" | X] - X).
verb(look, ["look","at" | X] - X).
verb(study, ["study" | X] - X).
verb(study, ["read" | X] - X).
verb(quit,["quit" | X] -X).

prep(to,["to" | X] -X).
prep(from,["from" | X] -X).

do_it(move(X)):-move(X),!.
do_it(teleport(X)):-teleport(X),!.
do_it(inventory):-inventory,!.
do_it(transfer(X,Y)):-transfer(X,Y),!.
do_it(take(X)):-c_take(X),!.
do_it(make(X)):-make(X),!.
do_it(summon(X)):-summon(X),!.
do_it(look(X)):-c_look(X),!.
do_it(study(X)):-c_study(X),!.
do_it(look):-look,!.
do_it(quit):-retract(quit(false)), assert(quit(true)),!.

parse([V,O], L):-verb(V,L-NP), obj(O, NP-[]).
parse([V,O1,O2], L):-verb(V,L-NP), obj(O1, NP-PP), obj(O2, PP-[]).
parse([V], L):-verb(V,L-_).
%parse([V], L):-verb(V,L-NP), obj(["the", "hall"], NP-[]).

obj(outside,["outside" | X] -X).
obj(outside,["Outside" | X] -X).
obj(agricultural_science,["Agricultural","Sciences","Building" | X] -X).
obj(agricultural_science,["the","Agricultural","Sciences","Building" | X] -X).
obj(animal_science,["Animal","Science","Building" | X] -X).
obj(animal_science,["the","Animal","Science","Building" | X] -X).
obj(avenue,["A","tree","lined","avenue" | X] -X).
obj(bedroom,["Your","bedroom" | X] -X).
obj(bedroom_closet,["Your","Bedroom's","Closet" | X] -X).
obj(bone,["large","dragon","bone" | X] -X).
obj(bone,["dragon","bone" | X] -X).
obj(bone,["bone" | X] -X).
obj(bone,["the","bone" | X] -X).
obj(book_a,["Corpus","Hermiticum" | X] -X).
obj(book_b,["War","and","Peace" | X] -X).
obj(book_c,["Great","Expectations" | X] -X).
obj(bunsen_burner,["bunsen","burner" | X] -X).
obj(charged_bone,["charged","bone" | X] -X).
obj(charged_bone,["a","charged","bone" | X] -X).
obj(charged_bone,["charged","dragon","bone" | X] -X).
obj(charged_bone,["a","chunk","of","charged","dragon","bone" | X] -X).
obj(chemistry_lab,["Student","Chemistry","Lab" | X] -X).
obj(clean_clothes,["Your","Clothes" | X] -X).
obj(closet,["equipment","closet" | X] -X).
obj(closet,["the","equipment","closet" | X] -X).
obj(coat,["Dr.","Sundberg's","lab","coat" | X] -X).
obj(common_room,["Dorm","common","room" | X] -X).
obj(common_room,["common","room" | X] -X).
obj(computer_lab,["Student","Computer","Lab" | X] -X).
obj(dirty_clothes,["Your","Dirty","Clothes" | X] -X).
obj(elevator,["Elevator"| X] -X).
obj(engr,["ENGR","-","The","Main","Engineering","Building" | X] -X).
obj(engr,["ENGR" | X] -X).
obj(eslc_north,["Eccels","Science","Learning","Center"| X] -X).
obj(eslc_north,["the","Eccels","Science","Learning","Center"| X] -X).
obj(eslc_south,["Eccels","Science","Learning","Center" | X] -X).
obj(eslc_south,["the","Eccels","Science","Learning","Center" | X] -X).
obj(eslc_south,["ESLC","south" | X] -X).
obj(eslc_south,["eslc","south" | X] -X).
obj(eslc_north,["eslc","north" | X] -X).
obj(figurine,["alien","figurine" | X] -X).
obj(figurine,["the","alien","figurine" | X] -X).
obj(flask,["flask" | X] -X).
obj(flask,["glass","flask" | X] -X).
obj(flask,["the","glass","flask" | X] -X).
obj(fly,["fly" | X] -X).
obj(fly,["dead","fly" | X] -X).
obj(fly,["the","dead","fly" | X] -X).
obj(geology_building,["Geology","Building" | X] -X).
obj(goggles,["dark","saftey","goggles" | X] -X).
obj(goggles,["the","goggles" | X] -X).
obj(goggles,["goggles" | X] -X).
obj(green_beam,["The","Grean","Beam","enclosure" | X] -X).
obj(hall,["Hallway"| X] -X).
obj(hall,["the","Hallway"| X] -X).
obj(hub,["The","Hub" | X] -X).
obj(ice_cream,["Aggie","Creamery" | X] -X).
obj(ice_cream,["the","Aggie","Creamery" | X] -X).
obj(key,["key"| X] -X).
obj(key,["the","key"| X] -X).
obj(kitchen,["Kitchen"| X] -X).
obj(kitchen,["the","Kitchen"| X] -X).
obj(large_disk,["large","energy","disk" | X] -X).
obj(large_disk,["large","disk" | X] -X).
obj(large_disk,["the","large","energy","disk" | X] -X).
obj(laser,["laser","array" | X] -X).
obj(laser_lab,["Laser","Lab" | X] -X).
obj(laser_lab,["the","Laser","Lab" | X] -X).
obj(library,["Merill-Caizer","Library" | X] -X).
obj(library,["the","Merill-Caizer","Library" | X] -X).
obj(lost_homework,["Some","student's","lost","geometry","homework." | X] -X).
obj(medium_disk,["medium","energy","disk" | X] -X).
obj(medium_disk,["medium","disk" | X] -X).
obj(medium_disk,["the","medium","energy disk" | X] -X).
obj(movie,["Men","in","Black" | X] -X).
obj(note,["note"| X] -X).
obj(note,["the","note"| X] -X).
obj(observatory,["Observatory"| X] -X).
obj(observatory,["the","Observatory"| X] -X).
obj(old_main,["Old","Main" | X] -X).
obj(old_main,["the","Old","Main" | X] -X).
obj(plaza,["Engineering","plaza" | X] -X).
obj(plaza,["the","Engineering","plaza" | X] -X).
obj(potion,["potion"| X] -X).
obj(potion,["a","potion"| X] -X).
obj(potion,["the","potion"| X] -X).
obj(pylon_a,["red","pylon" | X] -X).
obj(pylon_a,["the","red","pylon" | X] -X).
obj(pylon_a,["to","red","pylon" | X] -X).
obj(pylon_a,["to","the","red","pylon" | X] -X).
obj(pylon_b,["blue","pylon" | X] -X).
obj(pylon_b,["the","blue","pylon" | X] -X).
obj(pylon_b,["to","blue","pylon" | X] -X).
obj(pylon_b,["to","the","blue","pylon" | X] -X).
obj(pylon_c,["green","pylon" | X] -X).
obj(pylon_c,["the","green","pylon" | X] -X).
obj(pylon_c,["to","green","pylon" | X] -X).
obj(pylon_c,["to","the","green","pylon" | X] -X).
obj(quad,["The","Quad" | X] -X).
obj(recipe,["alchemical","recipe" | X] -X).
obj(recipe,["the","alchemical","recipe" | X] -X).
obj(roof,["On","the","roof","of","the","SER","Building" | X] -X).
obj(roommate_room,["dormmate's","room" | X] -X).
obj(roommate_room,["dormmate","room" | X] -X).
obj(roommate_room,["Your","dormmate's","room" | X] -X).
obj(roommate_room,["Your","roommate's","room" | X] -X).
obj(secret_lab,["Dr.","Sundberg's","Secret","Lab" | X] -X).
obj(ser_1st_floor,["1st","Floor","of","SER","Building" | X] -X).
obj(ser_1st_floor,["1st","Floor"| X] -X).
obj(ser_2nd_floor,["2nd","Floor","of","SER","Building" | X] -X).
obj(ser_2nd_floor,["2nd","Floor"| X] -X).
obj(small_disk,["small","energy","disk" | X] -X).
obj(small_disk,["small","disk" | X] -X).
obj(special_collections,["Special","Collections","Room" | X] -X).
obj(tsc,["Taggart","Student","Center" | X] -X).
obj(tsc_patio,["Patio","of","the","TSC" | X] -X).
obj(tunnels_east,["Underground","Tunnels" | X] -X).
obj(tunnels_north,["Underground","Tunnels" | X] -X).
obj(tunnels_west,["Underground","Tunnels" | X] -X).
obj(hall,["hall" | X]-X).
obj(hall,["the","hall" | X]-X).
obj(bedroom,["bedroom" | X]-X).
obj(game,["game" | X] -X).
obj(agricultural_science,["agricultural_science" | X] -X).
obj(agricultural_science,["the","agricultural_science" | X] -X).
obj(agricultural_science,["the","agricultural_science","building" | X] -X).
obj(animal_science,["animal_science" | X] -X).
obj(animal_science,["animal_science","building" | X] -X).
obj(animal_science,["the","animal_science" | X] -X).
obj(animal_science,["the","animal_science","building" | X] -X).
obj(avenue,["avenue" | X] -X).
obj(avenue,["the","avenue" | X] -X).
obj(bedroom,["bedroom" | X] -X).
obj(bedroom,["the","bedroom" | X] -X).
obj(bedroom_closet,["bedroom","closet" | X] -X).
obj(bedroom_closet,["the","bedroom","closet" | X] -X).
obj(chemistry_lab,["chemistry","lab" | X] -X).
obj(chemistry_lab,["the","chemistry","lab" | X] -X).
obj(common_room,["common","room" | X] -X).
obj(common_room,["the","common","room" | X] -X).
obj(computer_lab,["computer","lab" | X] -X).
obj(computer_lab,["the","computer","lab" | X] -X).
obj(elevator,["elevator" | X] -X).
obj(elevator,["the","elevator" | X] -X).
obj(engr,["engr" | X] -X).
obj(engr,["the","engr" | X] -X).
obj(eslc_north,["eslc","north" | X] -X).
obj(eslc_north,["the","eslc","north" | X] -X).
obj(eslc_south,["eslc","south" | X] -X).
obj(eslc_south,["the","eslc","south" | X] -X).
obj(geology_building,["geology","building" | X] -X).
obj(geology_building,["the","geology","building" | X] -X).
obj(green_beam,["green","beam" | X] -X).
obj(green_beam,["the","green","beam" | X] -X).
obj(hall,["hall" | X] -X).
obj(hall,["the","hall" | X] -X).
obj(hall,["hallway" | X] -X).
obj(hall,["the","hallway" | X] -X).
obj(hub,["hub" | X] -X).
obj(hub,["the","hub" | X] -X).
obj(kitchen,["kitchen" | X] -X).
obj(kitchen,["the","kitchen" | X] -X).
obj(laser_lab,["laser","lab" | X] -X).
obj(laser_lab,["the","laser","lab" | X] -X).
obj(library,["library" | X] -X).
obj(library,["the","library" | X] -X).
obj(observatory,["observatory" | X] -X).
obj(observatory,["the","observatory" | X] -X).
obj(old_main,["old","main" | X] -X).
obj(old_main,["the","old","main" | X] -X).
obj(plaza,["plaza" | X] -X).
obj(plaza,["Engineering","plaza" | X] -X).
obj(plaza,["the","plaza" | X] -X).
obj(plaza,["the","Engineering","plaza" | X] -X).
obj(quad,["quad" | X] -X).
obj(quad,["the","quad" | X] -X).
obj(roof,["roof" | X] -X).
obj(roof,["the","roof" | X] -X).
obj(roommate_room,["roommate's","room" | X] -X).
obj(roommate_room,["your","roommate's", "room" | X] -X).
obj(secret_lab,["secret","lab" | X] -X).
obj(secret_lab,["the","secret","lab" | X] -X).
obj(ser_1st_floor,["ser","1st","floor" | X] -X).
obj(ser_1st_floor,["the","ser","1st","floor" | X] -X).
obj(ser_2nd_floor,["ser","2nd","floor" | X] -X).
obj(ser_2nd_floor,["the","ser","2nd","floor" | X] -X).
obj(special_collections,["special","collections" | X] -X).
obj(special_collections,["the","special","collections" | X] -X).
obj(tsc_patio,["tsc","patio" | X] -X).
obj(tsc_patio,["the","tsc","patio" | X] -X).
obj(tsc,["tsc" | X] -X).
obj(tsc,["the","tsc" | X] -X).
obj(tunnels_east,["tunnels","east" | X] -X).
obj(tunnels_east,["the","tunnels","east" | X] -X).
obj(tunnels_north,["tunnels","north" | X] -X).
obj(tunnels_north,["the","tunnels","north" | X] -X).
obj(tunnels_west,["tunnels","west" | X] -X).
obj(tunnels_west,["the","tunnels","west" | X] -X).
obj(closet,["closet" | X] -X).
obj(closet,["the","closet" | X] -X).
obj(coat,["coat" | X] -X).
obj(coat,["the","coat" | X] -X).
obj(book_a,["book","a" | X] -X).
obj(book_a,["Corpus", "Hermiticum" | X] -X).
obj(book_a,["the","book","a" | X] -X).
obj(book_b,["War","and","Peace" | X] -X).
obj(book_c,["Great","Expectations" | X] -X).
obj(pylon_a,["pylon","a" | X] -X).
obj(pylon_a,["the","pylon","a" | X] -X).
obj(pylon_b,["pylon","b" | X] -X).
obj(pylon_b,["the","pylon","b" | X] -X).
obj(pylon_c,["pylon","c" | X] -X).
obj(pylon_c,["the","pylon","c" | X] -X).
obj(laser,["laser" | X] -X).
obj(laser,["the","laser" | X] -X).
obj(bunsen_burner,["bunsen","burner" | X] -X).
obj(bunsen_burner,["the","bunsen","burner" | X] -X).

play:-assert(quit(false)),write('Welcome to text adventure. Feel free to \"look\" around'),nl,repeat,read_words(W),parse(C,W),Command =.. C, do_it(Command),nl,win.

%allows prefix notation so 'look bedroom.' is the same as 'look(bedroom).'
:-op(40,fx,look).
:-op(45,fx,study).


