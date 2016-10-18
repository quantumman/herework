module Component.Buttons exposing (..)

import Aui.Buttons as Aui exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias ButtonType msg =
    Config msg -> Config msg


button : ButtonType msg -> msg -> List (Html msg) -> Html msg
button config message content =
    Aui.button (baseConfig |> config |> withAction message)
        content


primary : ButtonType msg
primary config =
    config |> withStyle primaryStyle


normal : ButtonType msg
normal config =
    config |> withStyle normalStyle


subtle : ButtonType msg
subtle config =
    config |> withStyle subtleStyle


light : ButtonType msg
light config =
    config |> withStyle lightStyle


link : ButtonType msg
link config =
    config |> withStyle linkStyle
