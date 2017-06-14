module Example exposing (..)

import Expect exposing (..)
import Fuzz
import Test exposing (..)


suite : Test
suite =
    describe "A string"
        [ test "should equal the same string" <|
            \_ ->
                "string"
                    |> equal "string"
        ]


fuzzSuite : Test
fuzzSuite =
    describe "An integer"
        [ fuzz Fuzz.int "should equal itself" <|
            \integer ->
                integer
                    |> equal integer
        ]
