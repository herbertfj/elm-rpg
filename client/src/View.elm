module View exposing (..)

import Html exposing (Html, div, text)
import Msg exposing (Msg)
import Model exposing (Model)
import Player.List


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    Player.List.view model.players
