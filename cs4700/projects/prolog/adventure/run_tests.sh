# test file
tf="[week2].\n"

# Test 1 load my file, test here(X)
function t1 () {
 echo "Test 1: Load File, Test here(X)."
 printf "
 $tf
 here(X).\n
 " | prolog -q
}

# Test 2: Load File, Test look(bedroom).
function t2 () {
 echo "Test 2: Load File, Test look(bedroom)."
 printf "
 $tf
 look(bedroom).\n
 " | prolog -q
}

# Test 3: Load File, Test c_look(bedroom). 
function t3 () {
 echo "Test 3: Load File, Test c_look(bedroom)."
 echo "Expected behavior: successful look operation on bedroom"
 printf "
 $tf
 c_look(bedroom).\n
 " | prolog -q
}

# Test 4: Load File, Test c_look(hall). 
function t4 () {
 echo "Test 4: Load File, Test c_look(hall)."
 echo "Expected behavior: false"
 printf "
 $tf
 c_look(hall).\n
 " | prolog -q
}

# Test 5: Load File, Test teleport to eslc_south, c_look(closet), here(eslc_south).
function t5 () {
  echo "Test 5: Load File, Test teleport to eslc_south, c_look(closet), here(eslc_south)."
 echo "Expected behavior: true, true, look(closet), true"
 printf "
 $tf
 teleport(eslc_south).\n
 c_look(closet).\n
 here(eslc_south).\n
 " | prolog -q
}

# Test 6: Load File, Test teleport to chemistry_lab, c_look(closet), here(eslc_south).
function t6 () {
  echo "Test 6: Load File, Test teleport to chemistry_lab, c_look(closet), here(eslc_south)."
 echo "Expected behavior: true, true, false, false"
 printf "
 $tf
 teleport(chemistry_lab).\n
 c_look(closet).\n
 here(eslc_south).\n
 " | prolog -q
}

# Test 7: Load File, Test move to hall, here(hall).
function t7 () {
  echo "Test 7: Load File, Test move to hall, here(hall)."
 echo "Expected behavior: true, true, true"
 printf "
 $tf
 move(hall).\n
 here(hall).\n
 " | prolog -q
}

alias srtst="source ./run_tests.sh"

functions=( t1 t2 t3 t4 t5 t6 t7 ) 
