module App.Msg exposing (..)

import Http
import Model.App as App exposing (..) 


type Msg =
    FetchResource (Result Http.Error App.Model)
