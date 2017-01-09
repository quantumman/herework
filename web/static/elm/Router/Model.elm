module Router.Model exposing (..)

import Navigation exposing (..)
import Router.Msg exposing (..)


type alias Model =
    { location : Location
    , route : Msg
    }
