module View.Toolbar
    exposing
        ( view
        , postMessage
        )

import View.UI.Buttons as Buttons exposing (..)
import View.UI.Nav as Nav exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message as App exposing (..)
import Router.Msg as Router exposing (..)


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
        (NavigateTo (Messages New))
        [ span [ class "icon is-small" ]
            [ i [ class "fa fa-plus" ] [] ]
        , span [] [ text "POST MESSAGE" ]
        ]
