module View.UI.MediaObject exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type Media msg
    = Right (Html msg)
    | Content (Html msg)
    | Left (Html msg)


media : List (Attribute msg) -> List (Media msg) -> Html msg
media attrs content =
    let
        render m =
            case m of
                Right x ->
                    x

                Content x ->
                    x

                Left x ->
                    x
    in
        article ([ class "media" ] ++ attrs)
            (List.map render content)


left : List (Html msg) -> Media msg
left content =
    Left <|
        figure [ class "media-left" ]
            content


right : List (Html msg) -> Media msg
right content =
    Right <|
        div [ class "media-right" ]
            content


content : List (Attribute msg) -> List (Html msg) -> Media msg
content attrs c =
    Content <|
        div ([ class "media-content" ] ++ attrs)
            c
