

data Tree a = Leaf a | Branch (Tree a) (Tree a)

map :: ( a -> b ) -> [a] -> [b]
map _ [] = []
map f (x:xs) = f x : map f xs

treeMap :: (a -> b) -> Tree a -> Tree b
treeMap :: (a -> b) -> Tree a -> Tree b
treeMap f (Leaf x) = Leaf (f x)
treeMap f (Branch left right) = Branch (treeMap f left) (treeMap f right)

foldr :: (a -> b -> b) -> b -> [a] -b
foldr f z [] = z
foldr f z (x:xs) = f x (foldr f z xs)

treeFold :: (b -> b -> b) -> (a -> b) -> Tree a -> b
treeFold fbranch fleaf = g where g (Leaf x) = fleaf x
                                 g (Branch  left right) = fbranch (g left) (g right)

tree1 :: Tree Integer
tree1 = Branch (Branch (Branch (Leaf 1) (Branch (Leaf 2) (Leaf 3))) (Branch (Leaf 4) (Branch (Leaf 5) (Leaf 6))))  

