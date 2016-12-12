module HtmlHelpers exposing (..)

import Component.Infrastructures.Form as Form exposing (bind, bindCheck, Binder)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message as App exposing (..)
import Models as App exposing (..)
import Router as Route exposing (..)


bind : Binder App.Model String -> Attribute App.Msg
bind binder =
    Form.bind binder Bind


bindCheck : Binder App.Model Bool -> Attribute App.Msg
bindCheck binder =
    Form.bindCheck binder Bind


navigateTo : Route -> Attribute App.Msg
navigateTo route =
    onClick (NavigateTo route)
