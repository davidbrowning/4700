# test file
tf="[week4]."

# Test 1 load my file, test here(X)
function t1 () {
 printf " Test 1: Test here(X).
 $tf
 here(X).
 "
 printf "
 $tf
 here(X).
 " | prolog -q
}

# Test 2:  Test look(bedroom).
function t2 () {
 echo "Test 2:  Test look(bedroom)."
 printf "
 $tf
 look(bedroom).
 "
 printf "
 $tf
 look(bedroom).
 " | prolog -q
}

# Test 3:  Test c_look(bedroom). 
function t3 () {
 echo "Test 3:  Test c_look(bedroom)."
 echo "Expected behavior: successful look operation on bedroom"
 printf "
 $tf
 c_look(bedroom).
 " | prolog -q
}

# Test 4:  Test c_look(hall). 
function t4 () {
 echo "Test 4:  Test c_look(hall)."
 echo "Expected behavior: false"
 printf "
 $tf
 c_look(hall).
 " | prolog -q
}

# Test 5:  Test teleport to eslc_south, c_look(closet), here(eslc_south).
function t5 () {
  echo "Test 5:  Test teleport to eslc_south, c_look(closet), here(eslc_south)."
 echo "Expected behavior: true, true, look(closet), true"
 printf "
 $tf
 teleport(eslc_south).
 c_look(closet).
 here(eslc_south).
 " | prolog -q
}

# Test 6:  Test teleport to chemistry_lab, c_look(closet), here(eslc_south).
function t6 () {
  echo "Test 6:  Test teleport to chemistry_lab, c_look(closet), here(eslc_south)."
 echo "Expected behavior: true, true, false, false"
 printf "
 $tf
 teleport(chemistry_lab).
 c_look(closet).
 here(eslc_south).
 " | prolog -q
}

# Test 7:  Test move to hall, here(hall).
function t7 () {
  echo "Test 7:  Test move to hall, here(hall)."
 echo "Expected behavior: true, true, true"
 printf "
 $tf
 move(hall).
 here(hall).
 " | prolog -q
}

# Test 8:  teleport to green_beam, here(green_beam), look(key).
function t8 () {
 printf "Test 8:
 $tf
 teleport(green_beam).
 here(green_beam).
 c_look(key).
 "
 echo "Expected behavior: true, true, true, true"
 printf "
 $tf
 teleport(green_beam).
 here(green_beam).
 c_look(key).
 " | prolog -q
}

# Test 9:  teleport to green_beam, here(green_beam), look(key).
function t9 () {
 printf " Test 9:
 $tf
 here(green_beam).
 take(key).
 location(key,_).
 has(key).
 "
 echo "Expected behavior: true, false, true, false, true"
 printf "
 $tf
 here(green_beam).
 take(key).
 location(key,_).
 has(key).
 " | prolog -q
}

# Test 10:  teleport to green_beam, here(green_beam), c_take(key), location(key,_), has(key).
function t10 () {
 printf " Test 10:
 $tf
 teleport(green_beam).
 here(green_beam).
 c_take(key).
 location(key,_).
 has(key).
 " 
 echo "Expected behavior: true, true, true, true, false, true"
 printf "
 $tf
 teleport(green_beam).
 here(green_beam).
 c_take(key).
 location(key,_).
 has(key).
 " | prolog -q
}

# Test 11:  teleport to green_beam, here(green_beam), c_take(coat), location(coat,_), has(coat).
function t11 () {
 printf " Test 11:
 $tf
 teleport(green_beam).
 here(green_beam).
 c_take(coat).
 location(coat,_).
 has(coat).
 " 
 echo "Expected behavior: true, true, true, true, false, true"
 printf "
 $tf
 teleport(green_beam).
 here(green_beam).
 c_take(coat).
 location(coat,_).
 has(coat).
 " | prolog -q
}

function t12 () {
 printf " Test 12:
 $tf
 c_study(note).
 c_take(note).
 c_study(note).
 " 
 echo "Expected behavior: true, true, true, true"
 printf "
 $tf
 c_study(note).
 c_take(note).
 c_study(note).
 " | prolog -q
}

function t13 () {
 printf "Test 13:  
 teleport(green_beam).
 c_take(coat).
 c_take(key,coat).
 c_study(key).
"
 echo "Expected behavior: true, true, true, true, true"
 printf "
 $tf
 teleport(green_beam).
 c_take(coat).
 c_take(key,coat).
 c_study(key).
 " | prolog -q
}

function t14 () {
 printf "Test 14:  
 teleport(green_beam).
 c_take(coat).
 c_take(key,coat).
 place(coat).
 c_place(key,coat).
 "
 echo "Expected behavior: true, true, true, true, true, true"
 printf "
 $tf
 teleport(green_beam).
 c_take(coat).
 c_take(key,coat).
 place(coat).
 c_place(key,green_beam).
 " | prolog -q
}

function t15 () {
 printf "Test 15:  
 $tf
 teleport(green_beam).
 c_take(coat).
 teleport(bedroom).
 c_place(coat,bedroom).
 c_take(key,coat).
 c_place(key,coat).
 c_place(coat,green_beam).
 c_look(coat).
 c_study(coat).
 "
 echo "Expected behavior: true, true, true, true, true, true, true"
 printf "
 $tf
 teleport(green_beam).
 c_take(coat).
 teleport(bedroom).
 c_place(coat,bedroom).
 c_take(key,coat).
 c_look(coat).
 c_place(key,coat).
 c_place(coat,green_beam).
 c_look(coat).
 c_study(coat).
 " | prolog -q
}

function t16 () {
 printf "
 $tf
 take(note).
 take(goggles).
 take(book_a).
 take(book_b).
 inventory.
 teleport(green_beam).
 c_take(coat).
 inventory.
 "
 printf "Expected behavior: true, true, true, true, true, items in inventory, true, true, items in inventory "
 printf "
 $tf
 take(note).
 take(goggles).
 take(book_a).
 take(book_b).
 inventory.
 teleport(green_beam).
 c_take(coat).
 inventory.
 " | prolog -q
}

function t17 () {
  printf "
  $tf
  win.
  "
  printf "Expected behavior:
  true
  false
  Execution Results:\n\n"

  printf "
  $tf
  win.
  " | prolog -q
}

function t18 () {
  printf "
  $tf
  teleport(secret_lab).
  win.
  force_transfer(large_disk,pylon_c).
  win.
  force_transfer(medium_disk,pylon_c).
  win.
  force_transfer(small_disk,pylon_c).
  win.
  "
  printf "Expected behavior
  $tf | true
  teleport(secret_lab). | true
  win. | false
  force_transfer(large_disk,pylon_c). | true
  win. | false
  force_transfer(medium_disk,pylon_c). | true
  win. | false
  force_transfer(small_disk,pylon_c). | true
  win. | true
  
  Execution Results:\n\n"

  printf "
  $tf
  teleport(secret_lab).
  win.
  force_transfer(large_disk,pylon_c).
  win.
  force_transfer(medium_disk,pylon_c).
  win.
  force_transfer(small_disk,pylon_c).
  win.
  " | prolog -q
}

function t19 () {
  printf "
  \n
  $tf
  teleport(secret_lab).
  transfer(small_disk,pylon_c).
  "
  printf "
  Expected Behavior: 
  $tf | true
  teleport(secret_lab). | true
  transfer(small_disk,pylon_c). | true
  \n
  Results: \n\n
  \n"
  printf "
  $tf
  teleport(secret_lab).
  transfer(small_disk,pylon_c).
  " | prolog -q
}

function t20 () {
  printf "
  \n
  $tf
  teleport(secret_lab).
  transfer(medium_disk,pylon_c).
  "
  printf "
  Expected Behavior: 
  $tf | true
  teleport(secret_lab). | true
  transfer(medium_disk,pylon_c). | false
  \n
  Results: \n\n
  \n"
  printf "
  $tf
  teleport(secret_lab).
  transfer(medium_disk,pylon_c).
  " | prolog -q
}

function t21 () {
  printf "
  \n
  $tf
  teleport(secret_lab).
  transfer(small_disk,pylon_b).
  transfer(medium_disk,pylon_c).
  "
  printf "
  Expected Behavior: 
  $tf | true
  teleport(secret_lab). | true
  transfer(small_disk,pylon_b). | true
  transfer(medium_disk,pylon_c). | true
  \n
  Results: \n\n
  \n"
  printf "
  $tf
  teleport(secret_lab).
  transfer(small_disk,pylon_b).
  transfer(medium_disk,pylon_c).
  " | prolog -q
}

function t22 () {
  printf "
  \n
  $tf
  teleport(secret_lab).
  transfer(large_disk,pylon_c).
  "
  printf "
  Expected Behavior: 
  $tf | true
  teleport(secret_lab). | true
  transfer(large_disk,pylon_c). | false
  \n
  Results: \n\n
  \n"
  printf "
  $tf
  teleport(secret_lab).
  transfer(large_disk,pylon_c).
  " | prolog -q
}

function t22 () {
  printf "
  \n
  $tf
  teleport(secret_lab).
  transfer(small_disk,pylon_c).
  transfer(medium_disk,pylon_b).
  transfer(small_disk,pylon_b).
  transfer(large_disk,pylon_c).
  "
  printf "
  Expected Behavior: 
  $tf | true
  teleport(secret_lab). | true
  transfer(small_disk,pylon_c). | true
  transfer(medium_disk,pylon_b). | true
  transfer(small_disk,pylon_b). | true
  transfer(large_disk,pylon_c). | true
  \n
  Results: \n\n
  \n"
  printf "
  $tf
  teleport(secret_lab).
  transfer(small_disk,pylon_c).
  transfer(medium_disk,pylon_b).
  transfer(small_disk,pylon_b).
  transfer(large_disk,pylon_c).
  " | prolog -q
}

function t23 () {
  printf "
  \n
  $tf
  teleport(secret_lab).
  transfer(small_disk,pylon_c).
  transfer(medium_disk,pylon_b).
  transfer(small_disk,pylon_b).
  transfer(large_disk,pylon_c).
  transfer(small_disk,pylon_a).
  transfer(medium_disk,pylon_c).
  transfer(small_disk,pylon_c).
  win.
  "
  printf "
  Expected Behavior: 
  $tf | true
  teleport(secret_lab). | true
  transfer(small_disk,pylon_c). | true
  transfer(medium_disk,pylon_b). | true
  transfer(small_disk,pylon_b). | true
  transfer(large_disk,pylon_c). | true
  transfer(small_disk,pylon_a). | true
  transfer(medium_disk,pylon_c). | true
  transfer(small_disk,pylon_c). | true
  win.
  \n
  Results: \n\n
  \n"
  printf "
  $tf
  teleport(secret_lab).
  transfer(small_disk,pylon_c).
  transfer(medium_disk,pylon_b).
  transfer(small_disk,pylon_b).
  transfer(large_disk,pylon_c).
  transfer(small_disk,pylon_a).
  transfer(medium_disk,pylon_c).
  transfer(small_disk,pylon_c).
  win.
  " | prolog -q
}

function t24 () {
  printf "
  \n
  $tf
  teleport(ser_2nd_floor).
  move(laser_lab).
  take(goggles).
  move(laser_lab).
  "
  printf "
  Expected Behavior: 
  $tf | true
  teleport(ser_2nd_floor). | true
  move(laser_lab). | false
  take(goggles). | true
  move(laser_lab). | true
  \n
  Results: \n\n
  \n"
  printf "
  $tf
  teleport(ser_2nd_floor).
  move(laser_lab).
  take(goggles).
  move(laser_lab).
  " | prolog -q
}

function t25 () {
  test_string="
  \n
  $tf
  take(bone).
  has(bone).
  has_ingredients([bone]). 
  "
  printf "$test_string"
  printf "
  Expected Behavior: 
  $tf | true
  take(bone). | true
  has(bone). | true
  has_ingredients([bone]). | true
  \n
  Results: \n\n
  \n"
  printf "$test_string" | prolog -q
}

function t26 () {
  test_string="
  \n
  $tf
  take(bone).
  has(bone).
  has_ingredients([bone]). 
  teleport(laser_lab).
  make(charged_bone).
  has(bone).
  has(charged_bone).
  "
  printf "$test_string"
  printf "
  Expected Behavior: 
  $tf | true
  take(bone). | true
  has(bone). | true
  has_ingredients([bone]). | true
  teleport(laser_lab). | true
  make(charged_bone). | true
  has(bone). | false
  has(charged_bone). | true
  \n
  Results: \n\n
  \n"
  printf "$test_string" | prolog -q
}

function t27 () {
  test_string="
  \n
  $tf
  play.
  move to hall
  move to bedroom
  quit
  \n
  play.
  quit game
  \n
  "
  printf "Expected Behavior:
  $tf | true
  play. | true -- enters game loop
  move to hall | -- player moves to hall, look.
  move to bedroom | true -- player move to bedroom, look.
  quit | true -- exits game loop
  play. | true -- enters game loop
  quit game | true -- exits game loop
  "

  printf "$test_string" | prolog -q
}

function t28 () {
  test_string="
  \n
  $tf
  play.
  move to the hall
  quit
  \n
  "
  printf "Expected Behavior:
  $tf | true
  play. | true -- enters game loop
  move to the hall | -- player moves to hall, look.
  quit | true -- exits game loop
  "
  printf "$test_string" | prolog -q
}

function t29 () {
  test_string="
  \n
  $tf
  play.
  teleport to secret lab
  study blue pylon
  transfer small disk blue pylon
  study blue pylon
  quit
  \n
  "
  printf "Expected Behavior:
  $tf | true
  play. | true -- enters game loop
  teleport to secret lab | true
  study blue pylon | true -- nothing there
  transfer small disk blue pylon | true
  study blue pylon | true --small disk there
  quit | true -- exits game loop
  "
  printf "$test_string" | prolog -q
}

function t30 () {
  test_string="
  \n
  $tf
  play.
  teleport to secret lab
  transfer small disk to green pylon
  transfer medium disk to blue pylon
  transfer small disk to blue pylon
  transfer large disk to green pylon
  transfer small disk to red pylon
  transfer medium disk to green pylon
  transfer small disk to green pylon
  \n
  "
  printf "Expected Behavior:
  $tf | true
  play. | true -- enters game loop
  teleport to secret lab | You Teleported!
  transfer small disk to green pylon | Transfer Successful
  transfer medium disk to blue pylon | Transfer Successful
  transfer small disk to blue pylon | Transfer Successful
  transfer large disk to green pylon | Transfer Successful
  transfer small disk to red pylon | Transfer Successful
  transfer medium disk to green pylon | Transfer Successful
  transfer small disk to green pylon |  Transfer Successful
You win! 
  \n
  "
  printf "$test_string" | prolog -q
}

function t31 () {
  test_string="
  \n
  $tf
  play.
  summon flask
  teleport to laser lab
  summon dragon bone
  make a charged bone
  summon fly
  teleport to the chemistry lab
  look
  inventory
  make a potion
  inventory
  quit
  \n
  "
  printf "Expected Behavior:
  $tf | true
  play. | true -- enters game loop
  summon flask | You wizard you
  summon bone | You wizard you
  teleport to laser lab | You Teleported!
  make a charged bone | You made a charged bone
  teleport to chemistry lab | You Teleported!
  summon fly | You wizard you
  inventory | list of ^^ things
  make a potion | You made a potion
  inventory | oily black potion
  quit | true -- exits game loop
  "
  printf "$test_string" | prolog -q
}

function t32 () {
  test_string="
  \n
  $tf
  play.
  teleport to common room
  go outside
  quit
  \n
  "

  printf "Expected Behavior:
  $tf | true
  play. | true -- enters game loop
  teleport to common room | You Teleported!
  go outside | move to engineering plaza
  quit | true -- exits game loop
  "
  printf "$test_string" | prolog -q
}

alias srtst="source ./run_tests.sh"

functions=( t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 t22 t23 t24 t25 t26 t27 t28 t29 t30 t31) 
