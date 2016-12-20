module Component.Views.MessageDetail exposing (..)

import Component.Infrastructures.DateTime as DateTime exposing (view)
import Component.UI.Attribute as Attribute exposing (..)
import Component.Views.CommentList as CommentList exposing (..)
import Date exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import HtmlHelpers as Helper exposing (bind)
import Message exposing (..)
import Models.Comment exposing (..)
import Models.Message exposing (..)
import Models.User exposing (..)


type alias Model m =
    { m
        | messageDetail : Maybe Message
        , comments : List Comment
        , user : User
        , now : DateTime.Model
    }


type alias ViewModel =
    { title : Html Msg
    , body : Html Msg
    , createdAt : Html Msg
    , avatar : Html Msg
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
        viewModel message =
            { title = text message.title
            , body = text message.body
            , createdAt = createdAt message.created_at model.now
            , avatar = avatar 24 message.creator
            }

        view_ message =
            div []
                [ render message
                , hr [] []
                , CommentList.view model
                ]
    in
        model.messageDetail
            |> Maybe.map viewModel
            |> Maybe.map view_
            |> Maybe.withDefault (div [] [])


edit : Model m -> Html Msg
edit model =
    let
        viewModel message =
            { title =
                div
                    [ contenteditable True
                    , bind title
                    ]
                    [ text message.title ]
            , body =
                div
                    [ contenteditable True
                    , bind body
                    ]
                    [ text message.body ]
            , createdAt = div [] []
            , avatar = avatar 24 model.user
            }
    in
        model.messageDetail
            |> Maybe.map viewModel
            |> Maybe.map render
            |> Maybe.withDefault (div [] [])


render : ViewModel -> Html Msg
render { title, body, createdAt, avatar } =
    div [ Attribute.content ]
        [ h1 [ Attribute.title 2 ] [ title ]
        , div [ subtitle 6, style removeSpace ]
            [ p [ level ]
                [ div [ levelLeft ] []
                , div [ levelRight ]
                    [ div [ levelItem ] [ createdAt ]
                    , div [ levelItem ] [ avatar ]
                    ]
                ]
            ]
        , hr [ style separator ] []
        , p [] [ body ]
        ]


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



-- HELPER


title : Maybe Message -> String -> Maybe Message
title message value =
    message
        |> Maybe.map (\m -> { m | title = value })


body : Maybe Message -> String -> Maybe Message
body message value =
    message
        |> Maybe.map (\m -> { m | body = value })


bind : (Maybe Message -> String -> Maybe Message) -> Attribute Msg
bind set =
    Helper.bind (\model value -> { model | messageDetail = set model.messageDetail value })
