import Data.Tree hiding (Tree )
data Tree a b = Branch b (Tree a b) (Tree a b) 
              | Leaf a deriving (Eq,Ord,Show)

toDataTree (Leaf a) = Node a []
toDataTree (Branch b cs ds) = Node b [toDataTree cs, toDataTree ds]

d = Branch "1" (Branch "11" (Leaf "111") (Leaf "112")) 
               (Branch "12" (Leaf "121") (Leaf "122"))

e = toDataTree d
f = putStrLn $ drawTree e
