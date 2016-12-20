module Component.Views.Toolbar exposing (..)

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
        Messages ->
            empty

        MessageDetail id ->
            empty

        Router.NewMessage ->
            empty

        Router.EditMessage id ->
            empty

        Tasks ->
            empty

        Activity ->
            empty

        NotFound ->
            empty


empty : Html Msg
empty =
    div [] []
