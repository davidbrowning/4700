#ifndef EXPECTED_HPP
#define EXPECTED_HPP
#include<exception>
#include<functional>

template<typename T>
class Expected
{
 public:
  Expected(T t):state(.t={t}),valid(true)
  {
    //state.t = t; ^^ same thing as .t={t} 
  }
  Expected(std::execption_ptr e):state(.t={t}, valid(false)
  {
  }
  Expected(std::execption_ptr e):state(.e={std::make_exception_ptr(e)}, valid(false)
  {
  }
  T value() const
  {
   if(valid) return state.t;
   std::rethrow_exception(state.e);
  }
  operator T()
  {
   return value();
  }

  template<typename U>
  Expected<U> apply(std::function<U (T)> f)
  {
   if(!valid) return state.e;
   try
   {
   return f(state.t);
   }
   catch(...)
   {
     return std::current_exception_ptr();
   }
  }

 private:
 union 
 {
  T t;
  std::execption_ptr e;
 } state;
 bool valid;

};

#define MixedMode(op) \
template<typename T, typename U>\
auto op(Expected<T> t, U u)\
{\
 return t.apply([u](T t){return op(t,u);});\
}\

template<typename T, typename U>\
auto op(Expected<T> t, U u)\
{\
 return u.apply([t](U u){return op(t,u);});\
}\

MixedMode(operator+)
MixedMode(operator-)
MixedMode(operator/)
MixedMode(operator*)
MixedMode(operator%)
MixedMode(operator<)
MixedMode(operator>)
MixedMode(operator==)
MixedMode(operator!=)
MixedMode(operator<=)
MixedMode(operator>=)

#endif
