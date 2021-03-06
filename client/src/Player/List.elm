module Player.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import Msg exposing (Msg)
import Model exposing (Player)
import Routing exposing (playerNewPath, playerPath)


view : List Player -> Html Msg
view players =
    div []
        [ nav
        , list players
        , newPlayer
        ]


nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Players" ] ]


list : List Player -> Html Msg
list players =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Name" ]
                    , th [] [ text "Level" ]
                    , th [] [ text "Actions" ]
                    ]
                ]
            , tbody [] (List.map playerRow players)
            ]
        ]


playerRow : Player -> Html Msg
playerRow player =
    tr []
        [ td [] [ text player.name ]
        , td [ class "center" ] [ text (toString player.level) ]
        , td []
            [ editBtn player
            , deleteBtn player
            ]
        ]


editBtn : Player -> Html Msg
editBtn player =
    let
        path =
            playerPath player.id
    in
        a
            [ class "btn regular"
            , href path
            ]
            [ i [ class "fa fa-pencil mr1" ] [], text "Edit" ]


newPlayer : Html Msg
newPlayer =
    div []
        [ a [ class "btn", href playerNewPath ]
            [ text "New" ]
        ]


deleteBtn : Player -> Html Msg
deleteBtn player =
    let
        message =
            Msg.DeletePlayer player
    in
        a
            [ class "btn regular"
            , onClick message
            ]
            [ i [ class "fa fa-times mr1" ] [], text "Delete" ]
