:- dynamic here/1.
:- dynamic has/1.
:- dynamic location/2.
here(bedroom).

room(animal_science).
room(avenue).
room(bedroom).
room(chemistry_lab).
room(common_room).
room(computer_lab).
room(eslc_north).
room(eslc_south).
room(elevator).
room(geology_building).
room(green_beam).
room(hall).
room(hub).
room(kitchen).
room(laser_lab).
room(library).
room(observatory).
room(old_main).
room(plaza).
room(quad).
room(roof).
room(roommate_room).
room(ser_1st_floor).
room(ser_2nd_floor).
room(secret_lab).
room(special_collections).
room(tsc_patio).
room(tunnels_east).
room(tunnels_north).
room(tunnels_west).

door(eslc_north,chemistry_lab).
door(eslc_north,tsc_patio).
door(eslc_south,eslc_north).
door(hub,tunnels_west).
door(old_main,computer_lab).
door(ser_1st_floor,elevator).
door(ser_2nd_floor,laser_lab).
door(ser_2nd_floor,elevator).
door(tsc_patio,hub).
door(tunnels_east,ser_1st_floor).
door(tunnels_north,animal_science).
door(tunnels_north,tunnels_west).
door(tunnels_west,secret_lab).
door(tunnels_west,tunnels_east).
door(avenue,quad).
door(bedroom,hall).
door(hall,common_room).
door(hall,roommate_room).
door(kitchen,hall).
door(library,special_collections).
door(library,plaza).
door(plaza,common_room).
door(plaza,ser_1st_floor).
door(plaza,avenue).
door(quad,animal_science).
door(quad,eslc_south).
door(quad,geology_building).
door(quad,old_main).
door(quad,tsc_patio).
door(roof,green_beam).
door(roof,elevator).
door(roof,observatory).

location(closet,eslc_south).
location(goggles,closet).
location(note,bedroom).
location(book_a,special_collections).
location(book_b,special_collections).
location(book_c,special_collections).
location(recipe,book_a).
location(bone,geology_building).
location(fly,roommate_room).
location(key,coat).
location(coat,green_beam).
location(large_disk,pylon_a).
location(medium_disk,pylon_a).
location(small_disk,pylon_a).
location(pylon_a,secret_lab).
location(pylon_b,secret_lab).
location(pylon_c,secret_lab).
location(flask,chemistry_lab).
location(bunsen_burner,chemistry_lab).
location(laser,laser_lab).

container(closet).
container(coat).
container(book_a).
container(pylon_a).
container(pylon_b).
container(pylon_c).

equipment(laser).
equipment(bunsen_burner).

create_recipe(laser,[bone],charged_bone).
create_recipe(bunsen_burner,[flask,charged_bone,fly],potion).

name(animal_science,"Animal Science Building").
name(avenue,"A tree lined avenue").
name(bedroom,"Your bedroom").
name(bone,"large dinosaur bone").
name(charged_bone,"a chunk of dragon bone").
name(book_a,"Corpus Hermiticum").
name(book_b,"War and Peace").
name(book_c,"Great Expectations").
name(bunsen_burner,"bunsen burner").
name(chemistry_lab,"Student Chemistry Lab").
name(closet,"equipment closet").
name(coat,"Dr. Sundberg's lab coat").
name(common_room,"Dorm common room").
name(computer_lab,"Student Computer Lab").
name(elevator,"Elevator").
name(potion,"potion").
name(eslc_north,"Eccels Science Learning Center").
name(eslc_south,"Eccels Science Learning Center").
name(flask,"glass flask").
name(fly,"dead fly").
name(geology_building,"Geology Building").
name(goggles,"dark saftey goggles").
name(green_beam,"The 'Grean Beam' enclosure").
name(hall,"Hallway").
name(hub,"The Hub").
name(key,"key").
name(kitchen,"Kitchen").
name(large_disk,"large energy disk").
name(laser,"laser array").
name(laser_lab,"Laser Lab").
name(library,"Merill-Caizer Library").
name(medium_disk,"medium energy disk").
name(note,"note").
name(observatory,"Observatory").
name(old_main,"Old Main").
name(plaza,"Engineering plaza").
name(pylon_a,"red pylon").
name(pylon_b,"blue pylon").
name(pylon_c,"green pylon").
name(quad,"The Quad").
name(recipe,"alchemical recipe").
name(roof,"On the roof of the SER Building").
name(roommate_room,"Your dormmate's room").
name(secret_lab,"Dr. Sundberg's Secret Lab").
name(ser_1st_floor,"1st Floor of SER Building").
name(ser_2nd_floor,"2nd Floor of SER Building").
name(small_disk,"small energy disk").
name(special_collections,"Special Collections Room").
name(tsc_patio,"Patio of the TSC").
name(tunnels_east,"Underground Tunnels").
name(tunnels_north,"Underground Tunnels").
name(tunnels_west,"Underground Tunnels").
name(_,"").

short_desc(animal_science,"a cozy-looking, white-bricked old building.").
short_desc(avenue,"").
short_desc(bedroom,"").
short_desc(potion,"An oily black potion").
short_desc(bone,"a large dark stone").
short_desc(charged_bone,"A small piece of 'dragon' bone").
short_desc(book_a,"a copy of 'Corpus Hermiticum' a book on alchemy").
short_desc(book_b,"a copy of 'War and Peace'").
short_desc(book_c,"a copy of 'Great Expectations'").
short_desc(bunsen_burner,"A stand with a tube connected to a natural gas supply").
short_desc(chemistry_lab,"A lab with fume hoods and various chemical instuments").
short_desc(closet,"Basically a hole in a wall").
short_desc(coat,"A large white lab coat with lots of pockets").
short_desc(common_room,"A typical scene of college living, an ever growing pile of pizza boxes in the corner, you know they will not be thrown out until they begin to develop consciousness.").
short_desc(computer_lab,"Many computers lined up and a desk at front of room").
short_desc(elevator,"You are in a plain metal box.  There are buttons labeled with various locations.").
short_desc(eslc_north,"You are on the north side of the ESLC.").
short_desc(eslc_south,"You are on the south side of the ESLC.").
short_desc(flask,"a glass flask suitable for mixing reagents").
short_desc(fly,"the partialy squished body of a dead house fly").
short_desc(geology_building,"Large building with rocks and trees surrounding it").
short_desc(goggles,"dark eye protection left over from the 'Great American Eclipse'").
short_desc(green_beam,"Dr. Sundberg is standing at a large machine which is emitting a bright beam of green light.  You overhear a conversation indicating that he has set up a wormhole generator in his secret lab.  This will allow the alien invasion force to reach earth.").
short_desc(hall,"Long pathway that has pictures hanging on wall").
short_desc(hub,"Smells of coffee and pizza linger in the air. Students congregate around tables slaving away at endless homework.").
short_desc(key,"an ornate key glowing with alien energies").
short_desc(kitchen,"").
short_desc(large_disk,"a large disk glowing with alien energy").
short_desc(laser,"Pulsating with energy, this laser could be used to imbue something with energy").
short_desc(laser_lab,"Lasers shine in a beautiful array of cornea charing horror, good thing you have goggles on!").
short_desc(library,"Endless floors of books full of knowledge. A smiling librarian greets you as you enter, "welcome to the library" she says.").
short_desc(medium_disk,"a medium sized disk glowing with alien energy").
short_desc(note,"a handwritten note from your roommate").
