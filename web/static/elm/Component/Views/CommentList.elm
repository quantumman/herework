module Component.Views.CommentList exposing (..)

import Aui.Avatars exposing (..)
import Component.Infrastructures.DateTime as DateTime exposing (view, Model)
import Component.UI.Callout as Callout exposing (..)
import Component.UI.Editor as Editor exposing (view)
import Component.UI.Layout exposing (..)
import Date exposing (Date)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)
import Models.Comment exposing (Comment)
import Models.Message exposing (Message, initialModel)
import Models.User exposing (User)


type alias Model m =
    { m
        | comments : List Comment
        , selectedMessage : Maybe Message
        , now : DateTime.Model
    }



-- STYLE


timeline : List ( String, String )
timeline =
    [ ( "listStyleType", "none" )
    , ( "padding", "0" )
    ]


commentStyle : List ( String, String )
commentStyle =
    [ ( "position", "relative" )
    , ( "marginTop", "15px" )
    , ( "marginBottom", "15px" )
    ]



-- VIEW


view : Model m -> Html Msg
view model =
    case model.selectedMessage of
        Just _ ->
            view_ model

        Nothing ->
            div [] []


view_ : Model m -> Html Msg
view_ model =
    div []
        [ div []
            [ message model.now
                (Maybe.withDefault initialModel model.selectedMessage)
            ]
        , ul [ style timeline ]
            (model.comments
                |> List.map (comment model.now)
                |> List.map (\c -> li [ style commentStyle ] [ c ])
            )
        ]


message : DateTime.Model -> Message -> Html Msg
message dateTime model =
    callout "#ddd"
        (creator model)
        [ body dateTime model ]


comment : DateTime.Model -> Comment -> Html Msg
comment dateTime model =
    callout "#ddd"
        (creator model)
        [ body dateTime model ]


creator : { m | creator : User } -> Html Msg
creator model =
    avatar config model.creator.avatar


body : DateTime.Model -> { m | body : String, created_at : Date, creator : User } -> Html Msg
body dateTime model =
    let
        padding =
            style
                [ ( "paddingLeft", "5px" )
                , ( "paddingRight", "5px" )
                , ( "paddingTop", "7px" )
                , ( "paddingBottom", "7px" )
                ]

        bodyStyle =
            style
                [ ( "minHeight", "4em" )
                ]

        footerStyle =
            style
                [ ( "borderTop", "1px solid #ddd" )
                , ( "fontSize", "0.8em" )
                , ( "color", "#777" )
                ]

        floatRight =
            style [ ( "float", "right" ) ]

        clearRight =
            style [ ( "clear", "right" ) ]
    in
        div []
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
