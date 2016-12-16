module Component.UI.Buttons
    exposing
        ( button
        , primary
        , info
        , success
        , warning
        , danger
        , normal
        , default
        , small
        , large
        , medium
        , outlined
        , loading
        , disabled
        )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- button config


type Size
    = Large
    | Medium
    | Small


type Color
    = Primary
    | Info
    | Success
    | Warning
    | Danger
    | Default


type Style
    = Outlined
    | Loading
    | Disabled
    | Normal


type alias Config =
    { size : Maybe Size
    , color : Color
    , style : Style
    }


default : Config
default =
    { size = Nothing
    , color = Default
    , style = Normal
    }


small : Config -> Config
small config =
    { config | size = Just Small }


medium : Config -> Config
medium config =
    { config | size = Just Medium }


large : Config -> Config
large config =
    { config | size = Just Large }


outlined : Config -> Config
outlined config =
    { config | style = Outlined }


loading : Config -> Config
loading config =
    { config | style = Loading }


disabled : Config -> Config
disabled config =
    { config | style = Disabled }


primary : Config -> Config
primary config =
    { config | color = Primary }


info : Config -> Config
info config =
    { config | color = Info }


success : Config -> Config
success config =
    { config | color = Success }


warning : Config -> Config
warning config =
    { config | color = Warning }


danger : Config -> Config
danger config =
    { config | color = Danger }


normal : Config -> Config
normal _ =
    default



--


type alias ButtonType =
    Config -> Config


button : ButtonType -> msg -> List (Html msg) -> Html msg
button buttonType message content =
    let
        config =
            default |> buttonType

        size_ s =
            case s of
                Large ->
                    "is-large"

                Small ->
                    "is-small"

                Medium ->
                    "is-medium"

        size =
            config.size
                |> Maybe.map size_
                |> Maybe.withDefault ""

        color =
            case config.color of
                Primary ->
                    "is-primary"

                Info ->
                    "is-info"

                Success ->
                    "is-success"

                Warning ->
                    "is-warning"

                Danger ->
                    "is-danger"

                Default ->
                    ""

        style =
            case config.style of
                Outlined ->
                    "is-outlined"

                Loading ->
                    "is-loading"

                Disabled ->
                    "is-disabled"

                Normal ->
                    ""
    in
        a
            [ class "button"
            , class style
            , class size
            , class color
            , onClick message
            ]
            content
