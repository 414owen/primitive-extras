module PrimitiveExtras.Prelude
  ( module Exports,
    Product2 (..),
    modifyTVar',
    forMToZero_,
    forMFromZero_,
  )
where

import Control.Applicative as Exports
import Control.Arrow as Exports
import Control.Category as Exports
import Control.Concurrent as Exports
import Control.Exception as Exports
import Control.Foldl as Exports (Fold (..), FoldM (..))
import Control.Monad as Exports hiding (forM, forM_, mapM, mapM_, msum, sequence, sequence_)
import Control.Monad.Fix as Exports hiding (fix)
import Control.Monad.IO.Class as Exports
import Control.Monad.Primitive as Exports
import Control.Monad.ST as Exports
import Data.Bits as Exports
import Data.Bool as Exports
import Data.Char as Exports
import Data.Coerce as Exports
import Data.Complex as Exports
import Data.Data as Exports
import Data.Dynamic as Exports
import Data.Either as Exports
import Data.Fixed as Exports
import Data.Foldable as Exports
import Data.Function as Exports hiding (id, (.))
import Data.Functor as Exports hiding (unzip)
import Data.Functor.Identity as Exports
import Data.IORef as Exports
import Data.Int as Exports
import Data.Ix as Exports
import Data.List as Exports hiding (all, and, any, concat, concatMap, elem, find, foldl, foldl', foldl1, foldr, foldr1, isSubsequenceOf, mapAccumL, mapAccumR, maximum, maximumBy, minimum, minimumBy, notElem, or, product, sortOn, sum, uncons)
import Data.Maybe as Exports
import Data.Monoid as Exports hiding (First (..), Last (..))
import Data.Ord as Exports
import Data.Primitive as Exports
import Data.Primitive.Unlifted.Array as Exports
import Data.Primitive.Unlifted.Class as Exports
import Data.Profunctor.Choice as Exports
import Data.Profunctor.Strong as Exports
import Data.Profunctor.Unsafe as Exports
import Data.Proxy as Exports
import Data.Ratio as Exports
import Data.STRef as Exports
import Data.String as Exports
import Data.Traversable as Exports
import Data.Tuple as Exports
import Data.Unique as Exports
import Data.Version as Exports
import Data.Word as Exports
import Debug.Trace as Exports
import DeferredFolds.Unfoldl as Exports (Unfoldl (..))
import DeferredFolds.UnfoldlM as Exports (UnfoldlM (..))
import Focus as Exports (Focus (..))
import Foreign.ForeignPtr as Exports
import Foreign.Ptr as Exports
import Foreign.StablePtr as Exports
import Foreign.Storable as Exports hiding (alignment, sizeOf)
import GHC.Conc as Exports hiding (threadWaitRead, threadWaitReadSTM, threadWaitWrite, threadWaitWriteSTM, withMVar)
import GHC.Exts as Exports (groupWith, inline, lazy, sortWith)
import GHC.Generics as Exports (Generic)
import GHC.IO.Exception as Exports
import ListT as Exports (ListT (..))
import Numeric as Exports
import System.Environment as Exports
import System.Exit as Exports
import System.IO as Exports
import System.IO.Error as Exports
import System.IO.Unsafe as Exports
import System.Mem as Exports
import System.Mem.StableName as Exports
import System.Timeout as Exports
import Text.Printf as Exports (hPrintf, printf)
import Text.Read as Exports (Read (..), readEither, readMaybe)
import Unsafe.Coerce as Exports
import Prelude as Exports hiding (all, and, any, concat, concatMap, elem, foldl, foldl1, foldr, foldr1, id, mapM, mapM_, maximum, minimum, notElem, or, product, sequence, sequence_, sum, (.))

data Product2 a b = Product2 !a !b

{-# INLINE modifyTVar' #-}
modifyTVar' :: TVar a -> (a -> a) -> STM ()
modifyTVar' var f = do
  x <- readTVar var
  writeTVar var $! f x

{-# INLINE forMToZero_ #-}
forMToZero_ :: (Applicative m) => Int -> (Int -> m a) -> m ()
forMToZero_ !startN f =
  ($ pred startN) $ fix $ \loop !n -> if n >= 0 then f n *> loop (pred n) else pure ()

{-# INLINE forMFromZero_ #-}
forMFromZero_ :: (Applicative m) => Int -> (Int -> m a) -> m ()
forMFromZero_ !endN f =
  ($ 0) $ fix $ \loop !n -> if n < endN then f n *> loop (succ n) else pure ()
