module ViewSpec exposing (..)

import Expect exposing (..)
import Fuzz
import Model
import Test exposing (..)
import Test.Html.Query exposing (..)
import Test.Html.Selector exposing (tag, text)
import View
import RemoteData


suite : Test
suite =
    describe "View"
        [ describe "PlayersRoute"
            [ describe "when data is still loading"
                [ test "displays loading text" <|
                    \_ ->
                        let
                            view =
                                View.view
                                    { players = RemoteData.Loading
                                    , route = Model.PlayersRoute
                                    , edit = Nothing
                                    }
                        in
                            view
                                |> fromHtml
                                |> has [ text "Loading.." ]
                ]
            ]
        ]
