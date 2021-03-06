module View.Toolbar
    exposing
        ( view
        , postMessage
        )

import Control.Command as Control exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msg as App exposing (..)
import Router.Msg as Router exposing (..)
import View.UI.Buttons as Buttons exposing (..)
import View.UI.Nav as Nav exposing (..)


-- VIEW


view : List (Html App.Msg) -> Html App.Msg
view items =
    toolbar items


toolbar : List (Html App.Msg) -> Html App.Msg
toolbar items =
    let
        toolbarStyle =
            [ ( "background-color", "whitesmoke" ) ]

        render item =
            Nav.item [] [ item ]
    in
        Nav.nav [ style toolbarStyle ]
            [ Nav.center (List.map render items)
            ]


postMessage : Html App.Msg
postMessage =
    Buttons.button (Buttons.default |> primary)
        (Control.navigateTo (Messages New))
        [ span [ class "icon is-small" ]
            [ i [ class "fa fa-plus" ] [] ]
        , span [] [ text "POST MESSAGE" ]
        ]
