module Component.Form exposing (..)

import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- UPDATE


type Binder model
    = Binder (model -> String -> model)


unwrap : Binder model -> model -> String -> model
unwrap (Binder binder) =
    binder


type Msg model
    = Bind (Binder model) String
