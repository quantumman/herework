module Message exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)


type Msg
    = Fetch Url
    | Open Url


type alias Url =
    String
