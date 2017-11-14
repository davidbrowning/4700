/*
 Monad consists of two major parts:
  1) lifting function takes values and functions in one domain and 'lifts' them into another
  1) Takes a value in one domain and turns it into a value in another domain
  1) Constructor takes a T and turns it into monad(T) sometimes you want the reverse (need to do for assignment)
  2) (T -> U) -> (M(T) -> M(U))

  base domain : any value of T 
   lifting into T's that we expect to be there, but they may not be. 

  3 was to handle errors 
   error codes (suck) too easy to ignore
    ...but it's easy
   exceptions (some advantages)
    a) can't ignore them
    completely impropriate in threading
    resource constrained environments (lots of memory required) and real time environments. 
   expected is basically between the two. 
    can pass between threads just fine
  
  Async functions
  Animation
  Very useful idea. 
  Math idea not necessarily a language idea

  Construct T from a T "just stick it inside.. good to go"
   or from exception pointer
  Apply function
   t.apply(f) :: expression will be an expected U
     take this function, look at your t, does it have a value? if so... do something
     if this t contains an error return an expeced U containing an error. 

   "programmable semicolons"
  Impliment all operaters in terms of apply
  t1 + t2 

*/

#include<std::function>
#include<std::exception>

template<typename T, typename U>
E<U>  E<T>::apply(std::function<U(T)> f)

std::exception_ptr e;
std::current_exception e1;  

try
{
 // Thing
}
catch(...)
{
  return std::current_exception;
} 

operator+(E<T> a, E<T> b)
{
 try
 {
  apply([b](+b); 
  auto B = b.value();
  a.apply([R](T t) {return t+B;});
  // dafuq?
 }
 catch (...) 
 {
 }
   
}


