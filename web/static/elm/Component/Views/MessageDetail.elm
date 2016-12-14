module Component.Views.MessageDetail exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import HtmlHelpers exposing (..)
import Message exposing (..)
import Models.Message exposing (..)


type alias Model m =
    { m
        | selectedMessage : Maybe Message
    }



-- VIEW


view : Model m -> Html Msg
view { selectedMessage } =
    let
        render message =
            div [] []
    in
        selectedMessage
            |> Maybe.map render
            |> Maybe.withDefault (div [] [])
