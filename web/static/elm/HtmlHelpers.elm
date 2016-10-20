module HtmlHelpers exposing (..)

import Component.Form as Form exposing (bind, bindCheck, Binder)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Message as App exposing (..)
import Models as App exposing (..)


bind : Binder App.Model String -> Attribute App.Msg
bind binder =
    Form.bind binder Bind


bindCheck : Binder App.Model Bool -> Attribute App.Msg
bindCheck binder =
    Form.bindCheck binder Bind
