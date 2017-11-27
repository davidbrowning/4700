#ifndef EXPECTED_HPP
#define EXPECTED_HPP
#include<exception>
#include<stdexcept>
#include<functional>
#include<typeinfo>
#include<iostream>
#include<cmath>
#include<cstdlib>

// got from cpprefrence
void handle_eptr(std::exception_ptr eptr) // passing by value is ok
{
    try {
        if (eptr) {
            std::rethrow_exception(eptr);
        }
    } catch(const std::exception& e) {
        std::cout << "Caught exception \"" << e.what() << "\"\n";
    }
}

template<typename T>
class Expected
{
 public:
  Expected(T tt) 
  {
    t = tt;
    valid = true;
  }
  Expected(std::exception ex)
  {
    std::cout << "I got an exception, therefore I'm going to return\n"
      << " an exception pointer to: " << ex.what() << std::endl;
    e = std::make_exception_ptr(ex);
    valid = false;
  }
  Expected(std::exception_ptr ex)
  {
    e = ex;
    valid = false;
  }
  T value() const
  {
   if(valid){ return t;}
   std::rethrow_exception(e);
  }
  operator T()
  {
   return value();
  }

  template<typename U>
  Expected<U> apply(std::function<U (T)> f)
  {
   if(!valid){ return e;}
   try
   {
     return f(t);
   }
   catch(...)
   {
     return std::current_exception();
   }
  };

// private:
  T t;
  std::exception_ptr e;
  bool valid;

};

// second function used to be u.apply(f)

#define MixedMode(opname,op) \
template<typename T, typename U>\
auto opname(Expected<T> t, U u)\
{\
 std::function<U(T)> f = [u](T t){return t op u;};\
 return t.apply(f);\
}\
\
template<typename T, typename U>\
auto opname(U u,Expected<T> t)\
{\
 std::function<U(T)> f = [u](T t){return u op t;};\
 return t.apply(f);\
}\

MixedMode(operator+,+)
MixedMode(operator-,-)
MixedMode(operator/,/)
MixedMode(operator*,*)
MixedMode(operator%,%)
MixedMode(operator<,<)
MixedMode(operator>,>)
MixedMode(operator==,==)
MixedMode(operator!=,!=)
MixedMode(operator<=,<=)
MixedMode(operator>=,>=)

#endif

Expected<double> getRoot(double x)
{
  std::cout << "getting root of " << x << std::endl;
  if(x < 0) return std::domain_error("Imaginary root");
  std::cout << "sqrt(x): " << sqrt(x) << std::endl;
  return sqrt(x);
}

std::pair<Expected<double>, Expected<double>> solve(double a, double b, double c)
{
  auto determ = getRoot(b*b-4*a*c);
  std::cout << "Type that was returned from getRoot: " << typeid(determ).name() << std::endl;
  return std::make_pair((-b + determ)/(2*a), (-b - determ)/(2*a));
}

Expected<bool> eq(double x, double y)
{
  return (x == y);
}

Expected<bool> mod(int x, int y)
{
  return (x % y);
}

Expected<bool> lt(int x, int y)
{
  return (x < y);
}

Expected<bool> gt(int x, int y)
{
  return (x > y);
}

Expected<bool> lte(int x, int y)
{
  return (x <= y);
}

Expected<bool> gte(int x, int y)
{
  return (x >= y);
}

Expected<bool> ne(int x, int y)
{
  return (x != y);
}

Expected<bool> ee(int x, int y)
{
  return (x == y);
}

Expected<double> divide_expecteds(double x, double y)
{
  if(y == 0){
    return std::domain_error("invalid denomenator");
  }
  return (x / y);
}


//// got from cpprefrence
//void handle_eptr(std::exception_ptr eptr) // passing by value is ok
//{
//    try {
//        if (eptr) {
//            std::rethrow_exception(eptr);
//        }
//    } catch(const std::exception& e) {
//        std::cout << "Caught exception \"" << e.what() << "\"\n";
//    }
//}
//
struct mom {
  std::string name;
  int age;
};

int main(){
  double a = 2.0;
  double b = 11.0;
  double c = 6.0;
  std::cout 
    << "a: " << a << std::endl 
    << "b: " << b << std::endl 
    << "c: " << c << std::endl;
  std::cout << "solving quadratic..." << std::endl;
  auto p = solve(a,b,c);
  std::cout << "first case: " 
            << p.first << std::endl 
            << "second case: " 
            << p.second << std::endl;
  std::cout << std::endl;
  if(eq(10.0, 10.0)){
    std::cout << "bool works! ten equals ten!" << std::endl;
  }
  if(mod(8,2) == 0){
    std::cout << "mod works! 8 % 2 is 0" << std::endl;
  }
  if(lt(2,8) == true){
    std::cout << "less than works! 2 < 8" << std::endl;
  }
  if(gt(8,2) == true){
    std::cout << "greater than works! 8 > 2" << std::endl;
  }
  if(lte(8,8) == true){
    std::cout << "less than equal to  works! 8 <= 8" << std::endl;
  }
  if(gte(8,8) == true){
    std::cout << "greater than equal to works! 8 >= 8" << std::endl;
  }
  if(ne(7,8) == true){
    std::cout << "not equal to works! 7 != 8" << std::endl;
  }
  if(ee(8,8) == true){
    std::cout << "equal to works! 8 == 8" << std::endl << std::endl;
  }
  try{
//    auto bs1 = Expected<double>(bs);
//    if(root_breaker == bs1){
//      std::cout << "if this would work, this assignment would make some kind of"
//      << "sense" << std::endl;
//    }
    std::cout << "\nAssigning the root Expected result of a 'getRoot' of negative\n"
      <<" one to a variable called 'root_breaker'" << std::endl;
    auto root_breaker = getRoot(-1);
    auto exp = root_breaker.e;
//    auto bs = std::make_exception_ptr(std::domain_error("Imaginary root"));
//    if(typeid(bs).name() == typeid(root_breaker.e).name()){
//      std::cout << "The type of exception's name is the same"
//        << " as an exception pointer to a domain error" 
//        << std::endl << typeid(root_breaker.e).name()
//        << std::endl << std::endl;
//    }
    std::cout << "\nI don't understand how the root_breaker's return type or \n"  
      << " return information is of any value, however I have done my best here" 
      << std::endl;
  }
  catch(...)
  {
    auto e = std::current_exception();
    handle_eptr(e);
  }

  int some_number = 4;
  Expected<mom> m = mom();
  auto resp = (some_number == m);


  return EXIT_SUCCESS;
}
