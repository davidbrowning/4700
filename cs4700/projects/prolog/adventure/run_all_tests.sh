source run_tests.sh

for f in ${functions[*]}; 
do 
  $f;
  read -p "Continue?" i
done
