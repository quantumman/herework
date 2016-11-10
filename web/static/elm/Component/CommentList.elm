module Component.CommentList exposing (..)

import Aui.Avatars exposing (..)
import Component.Callout as Callout exposing (..)
import Component.DateTime as DateTime exposing (view, Model)
import Component.Layout exposing (..)
import Date exposing (Date)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)
import Models exposing (Comment, Message, User)
import Style exposing (..)


type alias Model m =
    { m
        | comments : List Comment
        , selectedMessage : Message
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
        [ div [] [ text model.selectedMessage.body ]
        , ul [ style timeline ]
            (model.comments
                |> List.map (comment model.dateTime)
                |> List.map (\c -> li [ style commentStyle ] [ c ])
            )
        ]


comment : DateTime.Model -> Comment -> Html Msg
comment dateTime model =
    Callout.callout "#ddd"
        (creator model)
        [ body dateTime model ]


creator : Comment -> Html Msg
creator model =
    avatar config model.creator.avatar


body : DateTime.Model -> { m | body : String, created_at : Date, creator : User } -> Html Msg
body dateTime model =
    let
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
