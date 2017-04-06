module Main exposing (..)

import Msg exposing (Msg)
import Model exposing (Model, initialModel)
import Update exposing (update)
import View exposing (view)
import Command exposing (fetchPlayers)
import Navigation exposing (Location)
import Routing


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel currentRoute, fetchPlayers )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Navigation.program Msg.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
