module Component.Views.Messages.Editor exposing (..)

import Component.Infrastructures.DateTime as DateTime exposing (view)
import Component.UI.Buttons as Buttons exposing (..)
import Component.Views.Messages.Layout as Layout exposing (..)
import Date exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import HtmlHelpers as Helper exposing (bind)
import Message as App exposing (..)
import Models exposing (..)
import Models.Comment exposing (Comment)
import Models.Message exposing (Message)
import Models.User exposing (User)
import Router as Router exposing (..)


-- VIEW


view : User -> Message -> List (Html App.Msg) -> Html App.Msg
view user message content =
    layout
        [ textarea [ bind title ]
            [ text message.title ]
        ]
        [ textarea [ bind body ]
            [ text message.body ]
        ]
        []
        [ avatar 24 user ]
        []
        content



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
