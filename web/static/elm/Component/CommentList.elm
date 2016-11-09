module Component.CommentList exposing (..)

import Aui.Avatars exposing (..)
import Component.DateTime as DateTime exposing (view, Model)
import Component.Layout exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)
import Models exposing (Comment)
import Style exposing (..)


type alias Model m =
    { m
        | comments : List Comment
        , dateTime : DateTime.Model
    }



-- STYLE


timeline : List Style
timeline =
    [ listStyleType none
    , padding "0"
    ]


commentStyle : List Style
commentStyle =
    [ position relative
    , marginTop (px 15)
    , marginBottom (px 15)
    ]



-- VIEW


view : Model m -> Html Msg
view model =
    div []
        [ ul [ style timeline ]
            (model.comments
                |> List.map (comment model.dateTime)
                |> List.map (\c -> li [ style commentStyle ] [ c ])
            )
        ]


comment : DateTime.Model -> Comment -> Html Msg
comment dateTime model =
    let
        bodyLayout =
            style
                [ Style.width "100%"
                ]

        wrapper content =
            div [ style [ paddingLeft "43px" ] ] [ content ]
    in
        div []
            [ div [ style floatLeft ] [ creator model ]
            , div [ style floatLeft ] [ callout ]
            , div [ bodyLayout ] [ wrapper <| calloutBody dateTime model ]
            , clearLeft
            ]


creator : Comment -> Html Msg
creator model =
    avatar config model.creator.avatar


callout : Html Msg
callout =
    let
        triangleSize =
            "6px"

        outer =
            style
                [ ( "border-top", triangleSize ++ " solid transparent" )
                , ( "border-right", triangleSize ++ " solid #ddd" )
                , ( "border-bottom", triangleSize ++ " solid transparent" )
                , ( "border-left", triangleSize ++ " solid transparent" )
                , Style.width "0"
                , Style.height "0"
                , marginTop (px 6)
                ]

        inner =
            style
                [ border "4px solid"
                , borderColor "transparent #f5f5f5 transparent transparent"
                , marginTop (px -10)
                , marginLeft (px 1)
                ]
    in
        div []
            [ div [ outer ] []
            , div [ inner ] []
            ]


calloutBody : DateTime.Model -> Comment -> Html Msg
calloutBody dateTime model =
    let
        css =
            style
                [ border "1px solid #ddd"
                , borderRadius (px 3)
                ]

        padding =
            style
                [ paddingLeft (px 5)
                , paddingRight (px 5)
                , paddingTop (px 7)
                , paddingBottom (px 7)
                ]

        bodyStyle =
            style
                [ minHeight (Style.em 4)
                ]

        footerStyle =
            style
                [ ( "border-top", "1px solid #ddd" )
                , fontSize (Style.em 0.8)
                , color "#777"
                ]

        floatRight =
            style [ float right' ]

        clearRight =
            style [ clear right' ]
    in
        div [ css ]
            [ div [ padding, bodyStyle ] [ text model.body ]
            , div [ footerStyle ]
                [ div [ padding, floatRight ]
                    [ text model.creator.name
                    , text " POSTED ON "
                    , Html.map Now <| DateTime.view model.created_at dateTime
                    ]
                , div [ clearRight ] []
                ]
            ]


floatLeft : List Style
floatLeft =
    [ float left'
    ]


clearLeft : Html Msg
clearLeft =
    div [ style [ Style.clear left' ] ] []
