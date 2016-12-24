module Component.Views.Toolbar exposing (..)

import Component.UI.Buttons as Buttons exposing (..)
import Component.UI.Nav as Nav exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)
import Router as Router exposing (..)


type alias Model m =
    { m
        | router : Router.Model
    }



-- VIEW


view : Model m -> Html Msg
view model =
    case model.router.route of
        Messages _ ->
            message

        Tasks ->
            empty

        Activity ->
            empty

        NotFound ->
            empty


empty : Html Msg
empty =
    div [] []


toolbar : List (Html Msg) -> Html Msg
toolbar toolItems =
    let
        toolbarStyle =
            [ ( "background-color", "whitesmoke" ) ]

        render item =
            Nav.item [] [ item ]
    in
        Nav.nav [ style toolbarStyle ]
            [ Nav.center (List.map render toolItems)
            ]


message : Html Msg
message =
    toolbar
        [ Buttons.button (Buttons.default |> primary)
            (NavigateTo (Messages New))
            [ span [ class "icon is-small" ]
                [ i [ class "fa fa-plus" ] [] ]
            , span [] [ text "POST MESSAGE" ]
            ]
        ]
