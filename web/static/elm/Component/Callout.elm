module Component.Callout exposing (callout)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Style exposing (..)


triangle : String -> Html msg
triangle color =
    let
        outerHeight =
            (px 6)

        innerHeight =
            (px 4)

        outerTriangle =
            style
                [ ( "border-top", outerHeight ++ " solid transparent" )
                , ( "border-right", outerHeight ++ " solid " ++ color )
                , ( "border-bottom", outerHeight ++ " solid transparent" )
                , ( "border-left", outerHeight ++ " solid transparent" )
                , Style.width "0"
                , Style.height "0"
                , marginTop (px 6)
                ]

        innerTriangle =
            style
                [ border (innerHeight ++ " solid")
                , borderColor "transparent #f5f5f5 transparent transparent"
                , marginTop (px -10)
                , marginLeft (px 1)
                ]
    in
        div []
            [ div [ outerTriangle ] []
            , div [ innerTriangle ] []
            ]


body : String -> List (Html msg) -> Html msg
body color content =
    let
        css =
            style
                [ border ("1px solid " ++ color)
                , borderRadius (px 3)
                ]
    in
        div [ css ] content


callout : String -> Html msg -> List (Html msg) -> Html msg
callout color icon content =
    let
        layout =
            style
                [ Style.width "100%"
                ]

        floatLeft =
            style [ float left' ]

        clearLeft =
            style [ Style.clear left' ]

        wrappedBody =
            div [ style [ paddingLeft (px 43) ] ]
                [ body color content
                ]
    in
        div []
            [ div [ floatLeft ] [ icon ]
            , div [ floatLeft ] [ triangle color ]
            , div [ layout ] [ wrappedBody ]
            , div [ clearLeft ] []
            ]
