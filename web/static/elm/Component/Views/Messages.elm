module Component.Views.Messages exposing (..)

import Component.Views.Messages.Detail as Detail exposing (view)
import Component.Views.Messages.Edit as Edit exposing (view)
import Component.Views.Messages.List as List exposing (view)
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
        Messages ->
            List.view model

        MessageDetail id ->
            Detail.view model

        Router.NewMessage ->
            Edit.view model

        Router.EditMessage id ->
            Edit.view model

        _ ->
            div [] []
