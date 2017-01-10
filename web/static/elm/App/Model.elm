module App.Model exposing (..)

import Model.App as App exposing (..)


type alias Model m =
    { m | app : App.Model }
