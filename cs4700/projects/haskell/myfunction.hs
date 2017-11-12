doubleMe x = x + x
doubleUs x y = doubleMe x + doubleMe y
doubleSmallNumber x = if x > 100
 then x 
 else x*2
doubleSmallNumber2 x = (if x > 100 then x else x*2) + 1
boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]
