module Component.Form exposing (..)

import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- UPDATE


type Binder model
    = Binder (model -> String -> model)
