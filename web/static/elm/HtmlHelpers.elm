module HtmlHelpers exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message as App exposing (..)
import Models as App exposing (..)
import Router.Msg as Router exposing (Msg)


navigateTo : Router.Msg -> Attribute App.Msg
navigateTo route =
    onClick (NavigateTo route)
