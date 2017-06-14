module Update exposing (..)

import Msg exposing (Msg)
import Model exposing (Model, Route(..))
import Navigation
import Routing exposing (parseLocation)
import Command exposing (savePlayerCmd)
import Model exposing (Model, Player)
import RemoteData


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
                case newRoute of
                    PlayerRoute id ->
                        ( { model | edit = Nothing, route = newRoute }, Cmd.none )

                    _ ->
                        ( { model | route = newRoute }, Cmd.none )

        Msg.OnPlayerSave (Ok player) ->
            ( updatePlayer model player, Navigation.newUrl Routing.playersPath )

        Msg.OnPlayerSave (Err error) ->
            ( model, Cmd.none )

        Msg.ChangeEdit newEdit ->
            ( { model | edit = Just newEdit }, Cmd.none )

        Msg.CancelEdit ->
            ( { model | edit = Nothing }, Navigation.newUrl Routing.playersPath )

        Msg.SaveEdit editedPlayer ->
            ( model, savePlayerCmd editedPlayer )


updatePlayer : Model -> Player -> Model
updatePlayer model updatedPlayer =
    let
        pick currentPlayer =
            if updatedPlayer.id == currentPlayer.id then
                updatedPlayer
            else
                currentPlayer

        updatePlayerList players =
            List.map pick players

        updatedPlayers =
            RemoteData.map updatePlayerList model.players
    in
        { model | players = updatedPlayers }
