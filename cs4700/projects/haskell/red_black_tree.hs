-- This file was created from both 
--  In class demonstrations, and pulled from
--  https://functional.works-hub.com/blog/Persistent-Red-Black-Trees-in-Haskell
--
--

-- 1. No red node has a red parent or a red node has only black children.
-- 2. Every path from the root node to an empty node contains the same number of black nodes.
-- 3. The root and leaves of the tree are black.
--

data Color = Red | Black deriving Show
data Tree x = Empty | Node Color (Tree x) x (Tree x) deriving Show

height Empty = 0
height (Node _ l val r) = 1 + max(height l) (height r)

insert Empty val = Node Red Empty val Empty
insert (Node c left val right) x 
 | x == val = Node c left val right
 | x < val = balance(Node c (insert left x) val right)
 | x > val = balance(Node c left val (insert right x))

makeBlack (Node Red l v r) = Node Black l v r
makeBlack x = x

treeInsert t v = makeBlack (insert t v)

balance (Node Black (Node Red a x (Node Red b y c)) z d) = Node Red (Node Black a x b) y (Node Black c z d)
balance (Node Black (Node Red (Node Red a x b) y c) z d) = Node Red (Node Black a x b) y (Node Black c z d)
balance (Node Black a x (Node Red (Node Red b y c) z d)) = Node Red (Node Black a x b) y (Node Black c z d)
balance (Node Black a x (Node Red b y (Node Red c z d))) = Node Red (Node Black a x b) y (Node Black c z d)
balance t = t

prettyprint (Leaf)
    = "Empty root."
-- unlines concats a list with newlines
prettyprint (Branch left node right) = unlines (prettyprint_helper (Branch left node right n h))

prettyprint_helper (Branch left node right)
    = (show node) : (prettyprint_subtree left right)
        where
            prettyprint_subtree left right =
                ((pad "+- " "|  ") (prettyprint_helper right))
                    ++ ((pad "`- " "   ") (prettyprint_helper left))
            pad first rest = zipWith (++) (first : repeat rest)
prettyprint_helper (Leaf)
    = []

-- from here use foldl treeInsert Empty [5,1,4,4,2,7,3,8]
--(balance)
