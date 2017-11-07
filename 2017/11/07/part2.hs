data Tree x = Empty | Node (Tree x) x (Tree x) deriving Show
insert Empty val = Node Empty val Empty
insert (Node left val right) x | x == val = Node left val right 
| x < val Node (insert left x) val right
| x > val Node left val (insert right x)
