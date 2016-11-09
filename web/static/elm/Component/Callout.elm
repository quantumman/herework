module Component.Callout exposing (..)

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
