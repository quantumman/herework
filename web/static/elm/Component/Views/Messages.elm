module Component.Views.Messages exposing (..)

import Component.Views.Messages.Detail as Detail exposing (view)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)
import Models as App exposing (..)
import Router as Router exposing (..)


-- VIEW


view : Route -> App.Model -> Html Msg
view route model =
    case route of
        MessageDetail id ->
            Detail.view model

        _ ->
            div [] []
