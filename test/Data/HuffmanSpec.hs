module Data.HuffmanSpec where

import Data.Huffman
import Data.Map.Strict as Map
import Data.Tree (Tree (Node))
import Test.Hspec

spec :: Spec
spec = do
  describe "genFrequencyMap" $ do
    it "returns the Map of frequency of characters" $ do
      let result = Map.fromList [('A', 3), ('B', 2), ('C', 1)]
      genFrequencyMap "ABCABA" `shouldBe` result
  describe "initialFrequency" $ do
    it "returns List of leaves" $ do
      let result =
            [ (Node (SingleChar 'd' 3) [])
            , (Node (SingleChar 'e' 2) [])
            , (Node (SingleChar 'f' 1) [])
            ]
      initialFrequency "dedfed" `shouldBe` result
  describe "genHuffmanTree" $ do
    context "when number of tree is 1" $ do
      it "returns tree" $ do
        let left = Node (SingleChar 'a' 2) []
            right = Node (SingleChar 'b' 1) []
            huffmanTree = Node (Sum 3) [right, left]
            trees = [huffmanTree]
        genHuffmanTree trees `shouldBe` huffmanTree
    context "when some trees exist" $
      it "combine trees with minimum frequency" $ do
        let trees = [leaf 'x' 700, leaf 'y' 7, leaf 'z' 70]
            huffmanTree =
              Node
                (Sum 777)
                [ leaf 'x' 700
                , Node
                    (Sum 77)
                    [ leaf 'z' 70
                    , leaf 'y' 7
                    ]
                ]
        genHuffmanTree trees `shouldBe` huffmanTree
  describe "huffmanCodeTable" $ do
    context "when apply to leaf" $
      it "return huffman code" $ do
        huffmanCodeTable (leaf 'a' 100) "001" `shouldBe` [('a', "001")]
 where
  leaf :: Char -> Int -> Tree HuffmanTreeNode
  leaf c x = Node (SingleChar c x) []
