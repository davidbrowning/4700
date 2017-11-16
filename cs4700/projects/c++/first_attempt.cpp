#include<functional>
#include<exception>
#include<iostream>
#include<typeinfo>

template<typename T>
T Expected(T t){
 try{
   return t;
 }
 catch(...){
   std::cout << "exception found" << std::endl;
//   auto eptr = std::current_exception();
//   return eptr;
 }
}

//template<typename T, typename U>
//Expected<U>  Expected<T>::apply(std::function<U(T)> f);

//std::exception_ptr<std::exception> e;
//std::current_exception<std::exception> e1;  

int main() 
{
  int t = 20;
  auto a = Expected<double>(t); 
  std::cout << a << " is a " << typeid(a).name() << std::endl;
  return 0;
}
