/* 
 *  We might do the assignment here...
 *   ... If considered harmful...
 *
 */

//template<typename E> ?
//
//if I'm an error, throw an error, otherwise
// if my function returns an error, throw the error
std::pair<E<double>,E<double>> solve(double a, double b, double c){
  auto determinate = getRoot(b*b-4*a*c);
  return std::make_pair((-b+det/(2*a),(-b-det)/(2*a));

E<double> getRoot (double x){
  if ( x < 0){
    return std::domain_error("imaginary root");
  }
  else{
    return sqrt(x);
  }
}

