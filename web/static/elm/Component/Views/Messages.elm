module Component.Views.Messages exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)
import Models exposing (..)
import Router as Router exposing (..)


-- VIEW


view : Route -> Html Msg
view route =
    div [] []
