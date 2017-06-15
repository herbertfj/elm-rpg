module Update exposing (..)

import Msg exposing (Msg)
import Model exposing (Model, Route(..))
import Navigation
import Routing exposing (parseLocation)
import Command exposing (createPlayerCmd, deletePlayerCmd, savePlayerCmd)
import Model exposing (..)
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

                    PlayersNewRoute ->
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

        Msg.SaveNew newPlayer ->
            ( model, createPlayerCmd newPlayer )

        Msg.OnPlayerCreate (Ok newPlayer) ->
            updatePlayers model newPlayer

        Msg.OnPlayerCreate (Err error) ->
            ( model, Cmd.none )

        Msg.DeletePlayer player ->
            ( model, deletePlayerCmd player )

        Msg.OnPlayerDelete playerId (Ok _) ->
            ( deletePlayer model playerId, Cmd.none )

        Msg.OnPlayerDelete _ (Err _) ->
            ( model, Cmd.none )


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


updatePlayers : Model -> Player -> ( Model, Cmd Msg )
updatePlayers model newPlayer =
    case model.players of
        RemoteData.Success players ->
            let
                updatedPlayers =
                    players
                        ++ [ newPlayer ]
                        |> RemoteData.Success
            in
                ( { model | players = updatedPlayers, edit = Nothing }
                , Navigation.newUrl Routing.playersPath
                )

        _ ->
            ( model, Cmd.none )


deletePlayer : Model -> PlayerId -> Model
deletePlayer model playerId =
    case model.players of
        RemoteData.Success players ->
            let
                isNotDeleted player =
                    player.id /= playerId

                updatedPlayers =
                    List.filter isNotDeleted players
                        |> RemoteData.Success
            in
                { model | players = updatedPlayers }

        _ ->
            model
