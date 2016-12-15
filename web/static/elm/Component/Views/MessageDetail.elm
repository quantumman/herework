module Component.Views.MessageDetail exposing (..)

import Component.Infrastructures.DateTime as DateTime exposing (view)
import Component.UI.Attribute as Attribute exposing (..)
import Date exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import HtmlHelpers exposing (..)
import Message exposing (..)
import Models.Message exposing (..)


type alias Model m =
    { m
        | selectedMessage : Maybe Message
        , now : DateTime.Model
    }



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


view : Model m -> Html Msg
view { selectedMessage, now } =
    let
        render message =
            div [ Attribute.content ]
                [ h1 [ Attribute.title 2 ] [ text message.title ]
                , div [ subtitle 6, style removeSpace ]
                    [ p [ level ]
                        [ div [ levelLeft ] []
                        , div [ levelRight ]
                            [ div [ levelItem ] [ createdAt message.created_at now ]
                            , div [ levelItem ] [ avatar 24 message ]
                            ]
                        ]
                    ]
                , hr [ style separator ] []
                , p [] [ text message.body ]
                ]
    in
        selectedMessage
            |> Maybe.map render
            |> Maybe.withDefault (div [] [])


avatar : Int -> Message -> Html Msg
avatar size { creator } =
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


createdAt : Date -> DateTime.Model -> Html Msg
createdAt date model =
    Html.map Now <| DateTime.view date model
