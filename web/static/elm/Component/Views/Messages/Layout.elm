module Component.Views.Messages.Layout exposing (..)

import Component.Infrastructures.DateTime as DateTime exposing (view)
import Component.UI.Attribute as Attribute exposing (..)
import Date exposing (Date)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)
import Models exposing (..)
import Models.User exposing (User)


-- STYLE


removeSpace : List ( String, String )
removeSpace =
    [ ( "margin-bottom", "0" )
    ]


separator : List ( String, String )
separator =
    [ ( "margin-top", "10px" )
    ]



-- VIEW


type alias Title msg =
    List (Html msg)


type alias Body msg =
    List (Html msg)


type alias CreatedAt msg =
    List (Html msg)


type alias Creator msg =
    List (Html msg)


type alias Actions msg =
    List (Html msg)


layout : Title msg -> Body msg -> CreatedAt msg -> Creator msg -> Actions msg -> List (Html msg) -> Html msg
layout title body createdAt avatar actions content =
    div [ Attribute.content ]
        ([ h1 [ Attribute.title 2 ] title
         , div [ subtitle 6, style removeSpace ]
            [ p [ level ]
                [ div [ levelLeft ] []
                , div [ levelRight ]
                    [ div [ levelItem ] createdAt
                    , div [ levelItem ] avatar
                    , div [ levelItem ] actions
                    ]
                ]
            ]
         , hr [ style separator ] []
         , p [] body
         ]
            ++ content
        )


avatar : Int -> User -> Html msg
avatar size creator =
    let
        size_ =
            toString size

        figureSize =
            "is-" ++ size_ ++ "x" ++ size_

        imgStyle =
            [ ( "border-radius", "50%" )
            , ( "width", size_ ++ "px" )
            , ( "height", size_ ++ "px" )
            ]
    in
        figure [ levelItem, image, class figureSize ]
            [ img [ src creator.avatar, style imgStyle ] [] ]
