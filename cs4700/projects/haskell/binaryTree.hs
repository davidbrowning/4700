data Color = Red | Black deriving Show
data Tree x = Empty | Node Color (Tree x) x (Tree x) deriving Show

height Empty = 0
height (Node _ l r) = 1 + max(height l) (height r)

insert Empty val = Node Red Empty val Empty
insert (Node c left val right) x 
 | x == val = Node c left val right
 | x < val = balance(Node c (insert left x) val right)
 | x > val = balance(Node c left val (insert right x))

makeBlack (Node Red l v r) = Node Black l v r
makeBlack x = x
treeInsert t v = makeBlack (insert t v)

balance (Node Black (Node Red a x (Node Red b y c)) z d) = Node Red (Node Black a x b) y (Node Black c z d)
balance t = t

-- from here use foldl insert Empty [5,1,4,4,2,7,3,8]
--(balance)
