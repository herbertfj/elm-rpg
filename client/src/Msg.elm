module Msg exposing (..)

import Model exposing (Player)
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
