module Component.Views.CommentList exposing (..)

import Component.Infrastructures.DateTime as DateTime exposing (view, Model)
import Date exposing (Date)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)
import Models.Comment exposing (Comment)
import Models.User exposing (User)


type alias Model m =
    { m
        | comments : List Comment
        , now : DateTime.Model
    }



-- VIEW


view : Model m -> Html Msg
view model =
    div [] []
