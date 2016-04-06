import String
import Graphics.Element exposing (Element, show)

import ElmTest exposing (..)

tests : Test
tests =
  suite "A test Suite"
    [ test "Addition" (assertEqual (3 + 7) 10),
      test "String.left" (assertEqual "a" (String.left 1 "abcdefg")),
      test "This test should pass" (assert True) 
    ]

main : Element
main =
  elementRunner tests
