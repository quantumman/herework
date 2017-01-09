module CommentList.View.List exposing (..)

import CommentList.Model as CommentList exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message as App exposing (Msg)


view : Model -> Html App.Msg
view model =
    div [] []
