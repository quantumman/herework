module Component.Buttons exposing (..)

import Aui.Buttons as Aui exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)


type alias ButtonType =
    Config Msg -> Config Msg


button : ButtonType -> Msg -> List (Html Msg) -> Html Msg
button config message content =
    Aui.button (baseConfig |> config |> withAction message)
        content


primary : ButtonType
primary config =
    config |> withStyle primaryStyle


normal : ButtonType
normal config =
    config |> withStyle normalStyle
