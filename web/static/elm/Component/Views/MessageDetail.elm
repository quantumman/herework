module Component.Views.MessageDetail exposing (..)

import Component.Infrastructures.DateTime as DateTime exposing (view)
import Component.UI.Attribute as Attribute exposing (..)
import Component.Views.CommentList as CommentList exposing (..)
import Date exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import HtmlHelpers exposing (..)
import Message exposing (..)
import Models.Comment exposing (..)
import Models.Message exposing (..)


type alias Model m =
    { m
        | messageDetail : Maybe Message
        , comments : List Comment
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
view model =
    let
        render message =
            div [ Attribute.content ]
                [ h1 [ Attribute.title 2 ] [ text message.title ]
                , div [ subtitle 6, style removeSpace ]
                    [ p [ level ]
                        [ div [ levelLeft ] []
                        , div [ levelRight ]
                            [ div [ levelItem ] [ createdAt message.created_at model.now ]
                            , div [ levelItem ] [ avatar 24 message.user ]
                            ]
                        ]
                    ]
                , hr [ style separator ] []
                , p [] [ text message.body ]
                , hr [] []
                , CommentList.view model
                ]
    in
        model.messageDetail
            |> Maybe.map render
            |> Maybe.withDefault (div [] [])


avatar : Int -> User -> Html Msg
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


createdAt : Date -> DateTime.Model -> Html Msg
createdAt date model =
    Html.map Now <| DateTime.view date model
