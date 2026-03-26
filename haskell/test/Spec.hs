import Test.Hspec
import qualified SerializeSpec
import qualified DeserializeSpec
import qualified JsonTagOptionsSpec

main :: IO ()
main = hspec $ do
  SerializeSpec.spec
  DeserializeSpec.spec
  JsonTagOptionsSpec.spec
