module Control.Command exposing (..)

import Control.Msg as Control exposing (..)
import Router.Msg as Router exposing (..)
import Msg as App exposing (..)


navigateTo : Router.Msg -> App.Msg
navigateTo route =
    Control.NavigateTo route
        |> App.Control
