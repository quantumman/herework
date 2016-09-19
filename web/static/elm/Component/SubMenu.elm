module Component.SubMenu exposing (..)

import Component.Nav exposing (verticalNav)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Models exposing (..)
import Router as Router exposing (..)


-- MODEL


type alias Model m =
    { m
        | router : Router.Model
        , messages : List Message
    }



-- VIEW


subMenu : Model m -> Html msg
subMenu model =
    case model.router.route of
        Messages ->
            verticalNav <| [ toNavItemGroup "MESSAGES" model.messages ]

        other ->
            div [] []
