module PrimitiveExtras.UnfoldM
where

import PrimitiveExtras.Prelude hiding (fold)
import PrimitiveExtras.Types
import DeferredFolds.UnfoldM
import qualified PrimitiveExtras.Fold as A
import qualified PrimitiveExtras.UnliftedArray as B


primMultiArrayAssocs :: (Monad m, Prim a) => PrimMultiArray a -> UnfoldM m (Int, a)
primMultiArrayAssocs pma =
  do
    index <- primMultiArrayIndices pma
    element <- primMultiArrayAt pma index
    return (index, element)

primMultiArrayIndices :: Monad m => PrimMultiArray a -> UnfoldM m Int
primMultiArrayIndices (PrimMultiArray ua) =
  intsInRange 0 (pred (sizeofUnliftedArray ua))

primMultiArrayAt :: (Monad m, Prim prim) => PrimMultiArray prim -> Int -> UnfoldM m prim
primMultiArrayAt (PrimMultiArray ua) index =
  B.at ua index empty primArray

primArray :: (Monad m, Prim prim) => PrimArray prim -> UnfoldM m prim
primArray ba = UnfoldM $ \f z -> foldlPrimArrayM' f z ba

smallArrayElements :: Monad m => SmallArray e -> UnfoldM m e
smallArrayElements array = UnfoldM $ \ step initialState -> let
  !size = sizeofSmallArray array
  iterate index !state = if index < size
    then do
      element <- indexSmallArrayM array index
      newState <- step state element
      iterate (succ index) newState
    else return state
  in iterate 0 initialState
