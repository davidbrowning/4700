# test file
tf="[week2]."

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

alias srtst="source ./run_tests.sh"

functions=( t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 ) 
