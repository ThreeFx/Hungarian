module Main where

import Data.Algorithm.Munkres
import Data.Array
import Data.List

import System.Environment

test = test

main :: IO ()
main = do
         (studentFile:assignFile:wishListFile:_) <- getArgs
         students <- fmap lines $ readFile studentFile
         assignments <- fmap lines $ readFile assignFile
         wishList <- fmap (map (map read . words) . lines) $ readFile wishListFile
         let graph = constructGraph students assignments wishList in
           putStr $ unlines . decode students assignments wishList $ hungarianMethodBoxed graph
         --  print graph

-- Fill in penalty value for non-wished assignments
constructGraph :: [String] -> [String] -> [[Int]] -> Array (Int, Int) Int
constructGraph people assignments wishes = array ((1, 1), (length people, length assignments)) $ makeWishList
  where
--    makeWishList :: [((Int, Int), Int)]
    makeWishList = concatMap (constructRow (length assignments)) $ zip wishes [1..]
--    constructRow :: Int -> ([Int], Int) -> [((Int, Int), Int)]
    constructRow totalCol ([w1,w2,w3], row) = setWishes w1 w2 w3 $ zip (zip (repeat row) [1..totalCol]) $ repeat (10::Int)
--    setWishes :: Int -> Int -> Int -> [((Int, Int), Int)] -> [((Int, Int), Int)]
    setWishes w1 w2 w3 list = set 1 w1 $ set 2 w2 $ set 3 w3 $ list
--    set :: Int -> Int -> [((Int, Int), Int)] -> [((Int, Int), Int)]
    set value index list@(((row, col), _):xs) = take (index - 1) list ++ [((row, index), value)] ++ drop index list


decode :: [String] -> [String] -> [[Int]] -> ([(Int, Int)], Int) -> [String]
decode p a w (res, cost) = ("Total cost: " ++ show cost) : decode' p a res
  where
    decode' p a res =
      map (\(person, assignment) -> p !! (person - 1) ++ ": " ++ a !! (assignment - 1) ++ warn person assignment) res
    warn pers assi
      | assi `notElem` (w !! (pers - 1)) = " WARNING: " ++ p !! (pers - 1) ++ " did not wish for " ++ (a !! (assi - 1))
      | otherwise = ""
