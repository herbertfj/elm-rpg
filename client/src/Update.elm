module Update exposing (..)

import Msg exposing (Msg)
import Model exposing (Model)
import Routing exposing (parseLocation)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msg.OnFetchPlayers response ->
            ( { model | players = response }, Cmd.none )

        Msg.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )
