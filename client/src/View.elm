module View exposing (..)

import Html exposing (Html, div, text)
import Msg exposing (Msg)
import Model exposing (Model, Player, PlayerId)
import Player.Edit
import Player.List exposing (list, nav)
import RemoteData exposing (WebData)


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        Model.PlayersRoute ->
            maybeList model.players

        Model.PlayerRoute id ->
            playerEditPage model id

        Model.NotFoundRoute ->
            notFoundView


playerEditPage : Model -> PlayerId -> Html Msg
playerEditPage model playerId =
    case model.players of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading ..."

        RemoteData.Success players ->
            let
                maybePlayer =
                    players
                        |> List.filter (\player -> player.id == playerId)
                        |> List.head
            in
                case maybePlayer of
                    Just player ->
                        Player.Edit.view (choosePlayerEdit player model.edit)

                    Nothing ->
                        notFoundView

        RemoteData.Failure err ->
            text (toString err)


choosePlayerEdit : Player -> Maybe Player -> Player
choosePlayerEdit existingPlayer editPlayer =
    case editPlayer of
        Just edit ->
            edit

        Nothing ->
            existingPlayer


notFoundView : Html msg
notFoundView =
    div [] [ text "Not found" ]


maybeList : WebData (List Player) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading.."

        RemoteData.Success players ->
            Player.List.view players

        RemoteData.Failure error ->
            text (toString error)
