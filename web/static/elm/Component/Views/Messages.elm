module Component.Views.Messages exposing (..)

import Component.Views.Messages.Detail as Detail exposing (view)
import Component.Views.Messages.Edit as Edit exposing (view)
import Component.Views.Messages.List as List exposing (view)
import Component.Views.Messages.New as New exposing (view)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message as App exposing (..)
import Models as App exposing (..)
import Router as Router exposing (SubRoute(..))


-- VIEW


view : SubRoute id -> App.Model -> Html App.Msg
view route model =
    case route of
        List ->
            List.view model

        Show id ->
            Detail.view model

        New ->
            New.view model

        Edit id ->
            Edit.view model
