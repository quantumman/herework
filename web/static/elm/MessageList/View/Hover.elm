module MessageList.View.Hover exposing (..)

import View.UI.Attribute as Attribute exposing (..)
import View.UI.MediaObject as MediaObject exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import InlineHover as InlineHover exposing (..)
import Message as App exposing (Msg)
import MessageList.Model as MessageList exposing (Model)
import Models.Message exposing (Message)


hoverStyle : List ( String, String )
hoverStyle =
    [ ( "color", "#00d1b2" )
    , ( "background-color", "whitesmoke" )
    ]


hover :
    MessageList.Model
    -> Message
    -> (List (Attribute Msg) -> List (Media Msg) -> Html Msg)
    -> List (Attribute Msg)
    -> List (Media Msg)
    -> Html Msg
hover model message tag attrs children =
    let
        hoverOrNot m =
            if message.id == m.id then
                tag attrs children
            else
                InlineHover.hover hoverStyle (\a _ -> tag a children) attrs []
    in
        hoverOrNot model.message
