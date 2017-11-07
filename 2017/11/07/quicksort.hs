qsort [] = [] qsort (head:tail) = 
  qsort [less | less <- tail , less <= head] 
  ++ [head]
  ++ qsort [gr | gr <- tail , gr > head]

