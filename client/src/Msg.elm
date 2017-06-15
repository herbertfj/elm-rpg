module Msg exposing (..)

import Model exposing (Player, PlayerId)
import Navigation exposing (Location)
import RemoteData exposing (WebData)
import Http


type Msg
    = OnFetchPlayers (WebData (List Player))
    | OnLocationChange Location
    | OnPlayerSave (Result Http.Error Player)
    | ChangeEdit Player
    | CancelEdit
    | SaveEdit Player
    | SaveNew Player
    | OnPlayerCreate (Result Http.Error Player)
    | DeletePlayer Player
    | OnPlayerDelete PlayerId (Result Http.Error String)
