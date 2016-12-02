module Component.Views.EditMessage exposing (..)

import Component.UI.Buttons as Buttons exposing (..)
import Component.UI.Editor as Editor exposing (Model, view)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import HtmlHelpers exposing (..)
import Message exposing (..)
import Models exposing (..)
import Models.Message exposing (Message)


-- MODEL


type alias Model m =
    { m
        | newMessage : Message
        , editor : Editor.Model
    }


on : (Message -> Message) -> Model m -> Model m
on updater model =
    { model | newMessage = updater model.newMessage }


title : Model m -> String -> Model m
title model value =
    on (\m -> { m | title = value }) model


body : Model m -> String -> Model m
body model value =
    on (\m -> { m | body = value }) model



-- VIEW


view : Model m -> Html Msg
view model =
    div []
        [ Html.form []
            [ div []
                [ textarea [ rows 1, bind title ] []
                ]
            , Html.map Editor <| Editor.view model.editor
            ]
        , Buttons.button primary
            (EditMessage model.newMessage)
            [ text "Add" ]
        ]
