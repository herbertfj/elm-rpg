module Main exposing (..)

import Html exposing (Html, div, text, program)
import Msg exposing (Msg)
import Model exposing (Model, initialModel)
import Update exposing (update)
import View exposing (view)
import Command exposing (fetchPlayers)


init : ( Model, Cmd Msg )
init =
    ( initialModel, fetchPlayers )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
