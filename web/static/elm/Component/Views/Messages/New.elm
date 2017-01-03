module Component.Views.Messages.New exposing (..)

import Component.Infrastructures.DateTime as DateTime exposing (view)
import Component.UI.Buttons as Buttons exposing (..)
import Component.Views.Messages.Form as Form exposing (view, Model)
import Component.Views.Messages.Layout as Layout exposing (..)
import Date exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)
import Models exposing (..)
import Models.Comment exposing (Comment)
import Models.Message exposing (Message)
import Models.User exposing (User)
import Models.Views as Views exposing (Model)
import Router as Router exposing (..)


-- MODEL


type alias Model m =
    { m
        | messageDetail : Maybe Message
        , comments : List Comment
        , user : User
        , now : DateTime.Model
        , views : Views.Model
    }



-- VIEW


view : Model m -> Html Msg
view model =
    div []
        [ editor model.views
            model.user
            model.views.messages.entity
            [ Buttons.button (Buttons.default |> primary)
                CreateMessage
                [ text "Create New Message" ]
            ]
        , div [] [ text model.views.messages.entity.title ]
        ]


editor : Views.Model -> User -> Message -> List (Html Msg) -> Html Msg
editor model user message content =
    Form.view model.messages.form user message []
        |> Html.map MessagesForm
