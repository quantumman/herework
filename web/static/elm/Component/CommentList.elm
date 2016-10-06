module Component.CommentList exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)
import Models exposing (Comment)


type alias Model m =
    { m
        | comments : List Comment
    }
