module Component.UI.Attribute exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


active : Attribute msg
active =
    class "is-active"
