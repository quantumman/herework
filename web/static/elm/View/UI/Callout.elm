module View.UI.Callout exposing (callout)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


triangle : String -> Html msg
triangle color =
    let
        outerHeight =
            "6px"

        innerHeight =
            "4px"

        outerTriangle =
            style
                [ ( "borderTop", outerHeight ++ " solid transparent" )
                , ( "borderRight", outerHeight ++ " solid " ++ color )
                , ( "borderBottom", outerHeight ++ " solid transparent" )
                , ( "borderLeft", outerHeight ++ " solid transparent" )
                , ( "width", "0" )
                , ( "height", "0" )
                , ( "marginTop", "6px" )
                ]

        innerTriangle =
            style
                [ ( "border", innerHeight ++ " solid" )
                , ( "borderColor", "transparent #f5f5f5 transparent transparent" )
                , ( "marginTop", "-10px" )
                , ( "marginLeft", "1px" )
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
                [ ( "border", "1px solid " ++ color )
                , ( "borderRadius", "3px" )
                ]
    in
        div [ css ] content


callout : String -> Html msg -> List (Html msg) -> Html msg
callout color icon content =
    let
        layout =
            style
                [ ( "width", "100%" )
                ]

        floatLeft =
            style [ ( "float", "left" ) ]

        clearLeft =
            style [ ( "clear", "left" ) ]

        wrappedBody =
            div [ style [ ( "paddingLeft", "43px" ) ] ]
                [ body color content
                ]
    in
        div []
            [ div [ floatLeft ] [ icon ]
            , div [ floatLeft ] [ triangle color ]
            , div [ layout ] [ wrappedBody ]
            , div [ clearLeft ] []
            ]
