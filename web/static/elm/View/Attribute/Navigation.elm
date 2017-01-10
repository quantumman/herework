module View.Attribute.Navigation exposing (..)

import Control.Command as Control exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model as App exposing (..)
import Msg as App exposing (..)
import Router.Msg as Router exposing (Msg)


navigateTo : Router.Msg -> Attribute App.Msg
navigateTo route =
    onClick (Control.navigateTo route)
