module Component.Views.Messages.Edit exposing (..)

import Component.Infrastructures.DateTime as DateTime exposing (view)
import Component.UI.Buttons as Buttons exposing (..)
import Component.Views.Messages.Editor as Editor exposing (view)
import Component.Views.Messages.Layout as Layout exposing (..)
import Date exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import HtmlHelpers as Helper exposing (bind)
import Message exposing (..)
import Models exposing (..)
import Models.Comment exposing (Comment)
import Models.Message exposing (Message)
import Models.User exposing (User)
import Router as Router exposing (..)


-- MODEL


type alias Model m =
    { m
        | messageDetail : Maybe Message
        , comments : List Comment
        , user : User
        , now : DateTime.Model
    }



-- VIEW


view : Model m -> Html Msg
view model =
    let
        render message =
            Editor.view model.user message []
    in
        model.messageDetail
            |> Maybe.map render
            |> Maybe.withDefault (div [] [])



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
