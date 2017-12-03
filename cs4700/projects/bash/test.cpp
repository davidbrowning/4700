#include<iostream>

int main(){
  double j = 0;
  for (double i =0; i <= 1000; ++i){
    j += i;
  }
  std::cout << j << std::endl;
  return 0;
}

