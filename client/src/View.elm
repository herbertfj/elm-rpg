module View exposing (..)

import Html exposing (Html, div, text)
import Msg exposing (Msg)
import Model exposing (Model, Player)
import Player.List exposing (list, nav)
import RemoteData exposing (WebData)


view : Model -> Html Msg
view model =
    div []
        [ nav
        , maybeList model.players
        ]


maybeList : WebData (List Player) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading.."

        RemoteData.Success players ->
            list players

        RemoteData.Failure error ->
            text (toString error)
