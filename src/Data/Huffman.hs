module Data.Huffman where

import Data.Map.Strict as Map

genFrequencyMap :: String -> Map.Map Char Integer
genFrequencyMap cs =
  let cs' = zip cs $ repeat 1
   in Map.fromListWith (+) cs'

orderByFrequency :: String -> String
orderByFrequency cs =
  let m = genFrequencyMap cs
   in Prelude.map fst . assocs $ m