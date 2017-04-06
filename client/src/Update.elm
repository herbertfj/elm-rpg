module Update exposing (..)

import Msg exposing (Msg)
import Model exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msg.OnFetchPlayers response ->
            ( { model | players = response }, Cmd.none )
