module Component.Views.Messages.Edit exposing (..)

import Component.Infrastructures.DateTime as DateTime exposing (view)
import Component.UI.Buttons as Buttons exposing (..)
import Component.Views.Messages.Form as Form exposing (view)
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
        | messages : Resource Message
        , comments : List Comment
        , now : DateTime.Model
        , views : Views.Model
    }



-- VIEW


view : Model m -> Html Msg
view model =
    form model.views
        model.messages.entity
        []


form : Views.Model -> Message -> List (Html Msg) -> Html Msg
form model message content =
    Form.view model.messages.form message []
        |> Html.map MessagesForm
