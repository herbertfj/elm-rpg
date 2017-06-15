module Player.New exposing (..)

import Html exposing (..)
import Model exposing (Player)
import Msg exposing (Msg)
import Player.Edit


view : Player -> Html Msg
view newPlayer =
    div []
        [ Player.Edit.nav
        , Player.Edit.form newPlayer Msg.SaveNew
        ]
