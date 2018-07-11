module PrimitiveExtras.IO
where

import PrimitiveExtras.Prelude
import PrimitiveExtras.Types
import qualified PrimitiveExtras.UnliftedArray as A


generateUnliftedArray :: PrimUnlifted a => Int -> (Int -> IO a) -> IO (UnliftedArray a)
generateUnliftedArray = A.generate

replicateUnliftedArray :: PrimUnlifted a => Int -> IO a -> IO (UnliftedArray a)
replicateUnliftedArray = A.replicateIO

generateArray :: Int -> (Int -> IO a) -> IO (Array a)
generateArray size elementIO =
  do
    array <- newArray size undefined
    let
      loop index =
        if index < size
          then do
            element <- elementIO index
            writeArray array index element
            loop (succ index)
          else unsafeFreezeArray array
      in loop 0

replicateArray :: Int -> IO a -> IO (Array a)
replicateArray size elementIO =
  do
    array <- newArray size undefined
    let
      loop index =
        if index < size
          then do
            element <- elementIO
            writeArray array index element
            loop (succ index)
          else unsafeFreezeArray array
      in loop 0

generatePrimArray :: Prim a => Int -> (Int -> IO a) -> IO (PrimArray a)
generatePrimArray size elementIO =
  do
    array <- newPrimArray size
    let
      loop index =
        if index < size
          then do
            element <- elementIO index
            writePrimArray array index element
            loop (succ index)
          else unsafeFreezePrimArray array
      in loop 0

replicatePrimArray :: Prim a => Int -> IO a -> IO (PrimArray a)
replicatePrimArray size elementIO =
  do
    array <- newPrimArray size
    let
      loop index =
        if index < size
          then do
            element <- elementIO
            writePrimArray array index element
            loop (succ index)
          else unsafeFreezePrimArray array
      in loop 0
