module Component.Error.View exposing (..)

import Component.Error.Message exposing (..)
import Component.Error.Model exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)


view : Model m -> Html Msg
view model =
    case model.error of
        Just message ->
            div [] [ text message ]

        Nothing ->
            div [] []
