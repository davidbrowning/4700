#ifndef EXPECTED_HPP
#define EXPECTED_HPP
#include<exception>
#include<functional>
#include<typeinfo>
#include<iostream>
#include<cmath>

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
   if(valid) return t;
   std::rethrow_exception(e);
  }
  operator T()
  {
   return value();
  }

  template<typename U>
  Expected<U> apply(std::function<U (T)> f)
  {
   if(!valid) return e;
   try
   {
   return f(t);
   }
   catch(...)
   {
     return std::current_exception();
   }
  };

 private:
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

void handle_eptr(std::exception_ptr eptr)
{
  try{
    if (eptr) {
      std::rethrow_exception(eptr);
    }
  } catch (const std::exception& e){
    std::cout << e.what() << std::endl;
  }
}

Expected<double> getRoot(double x)
{
  std::cout << "getting root of " << x << std::endl;
  if(x < 0) return std::domain_error("Imaginary root");
  std::cout << "sqrt(x): " << sqrt(x) << std::endl;
  return sqrt(x);
}

std::pair<Expected<double>, Expected<double>> solve(double a, double b, double c)
{
  try{
  auto determ = getRoot(b*b-4*a*c);
  std::cout << typeid(determ).name() << std::endl;
  //std::cout << "Determinant: " << determ.value << std::endl;
  return std::make_pair((-b + determ)/(2*a), (-b - determ)/(2*a));
  }
  catch(...){
    auto e = std::current_exception();
    handle_eptr(e);
  }
}

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

  return 0;
}
