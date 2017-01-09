module View.Toolbar
    exposing
        ( view
        , postMessage
        )

import Component.UI.Buttons as Buttons exposing (..)
import Component.UI.Nav as Nav exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)
import Router as Router exposing (..)


-- VIEW


view : List (Html Msg) -> Html Msg
view items =
    toolbar items


toolbar : List (Html Msg) -> Html Msg
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


postMessage : Html Msg
postMessage =
    Buttons.button (Buttons.default |> primary)
        (NavigateTo (Messages New))
        [ span [ class "icon is-small" ]
            [ i [ class "fa fa-plus" ] [] ]
        , span [] [ text "POST MESSAGE" ]
        ]
