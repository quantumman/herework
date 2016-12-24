module Component.Views.Messages.Layout exposing (..)

import Component.UI.Attribute as Attribute exposing (..)
import Date exposing (Date)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)
import Models exposing (..)


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


type alias Title =
    List (Html Msg)


type alias Body =
    List (Html Msg)


type alias CreatedAt =
    List (Html Msg)


type alias Creator =
    List (Html Msg)


type alias Actions =
    List (Html Msg)


layout : Title -> Body -> CreatedAt -> Creator -> Actions -> Html Msg
layout title body createdAt avatar actions =
    div [ Attribute.content ]
        [ h1 [ Attribute.title 2 ] title
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
