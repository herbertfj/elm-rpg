module Player.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href, value)
import Html.Events exposing (onClick, onInput)
import Model exposing (Player)
import Msg exposing (Msg)
import Routing exposing (playersPath)


view : Player -> Html Msg
view model =
    div []
        [ nav
        , form model
        ]


nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listBtn ]


form : Player -> Html Msg
form player =
    div [ class "m3" ]
        [ nameEditInput player
        , formLevel player
        , resolveForm player
        ]


resolveForm : Player -> Html Msg
resolveForm player =
    div [ class "clearfix py1" ]
        [ button [ class "btn", onClick (Msg.SaveEdit player) ] [ text "Save" ]
        , button [ class "btn", onClick Msg.CancelEdit ] [ text "Cancel" ]
        ]


nameEditInput : Player -> Html Msg
nameEditInput player =
    let
        message newName =
            Msg.ChangeEdit { player | name = newName }
    in
        input
            [ class "input col-3"
            , value player.name
            , onInput message
            ]
            []


formLevel : Player -> Html Msg
formLevel player =
    div [ class "clearfix py1" ]
        [ div [] [ text "Level" ]
        , div []
            [ btnLevelDecrease player
            , span [ class "h2 bold" ] [ text (toString player.level) ]
            , btnLevelIncrease player
            ]
        ]


btnLevelDecrease : Player -> Html Msg
btnLevelDecrease player =
    let
        message =
            Msg.ChangeEdit { player | level = player.level - 1 }
    in
        a [ class "btn ml1 h1", onClick message ]
            [ i [ class "fa fa-minus-circle" ] [] ]


btnLevelIncrease : Player -> Html Msg
btnLevelIncrease player =
    let
        message =
            Msg.ChangeEdit { player | level = player.level + 1 }
    in
        a [ class "btn ml1 h1", onClick message ]
            [ i [ class "fa fa-plus-circle" ] [] ]


listBtn : Html Msg
listBtn =
    a
        [ class "btn regular"
        , href playersPath
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]
