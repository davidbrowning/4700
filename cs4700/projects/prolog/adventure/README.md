## Synopsis

For each of the "checked" statements, I have the statement by itself as the "unchecked" version and then I append c\_ to the beginning to indicate "checked". For example:

 * unchecked look: look(bedroom). 
 * checked look: c_look(bedroom). 
 * unchecked take: take(coat).
 * checked take: c_take(coat).

## Motivation

Week 2 in the prolog text based adventure game. 

## Tests

Two primary means of testing. 

1) 
$ ./run_all_tests.sh will
 * describe test
 * describe desired behavior
 * run test 
 * Note: this is a bash script which requires the command 'prolog' in the user's path to point to the prolog interpreter. 
 
 2) 
$ source ./run_tests.sh
 * User may then call $ t$a where a is greater than 0 and a is less than 17 (e.g. t14)

For week 4, run tests 27-32. (if you don't have bash, use the strings in run_tests.sh to test).  

## Contributors

Just Me

