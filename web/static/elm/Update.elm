module Update exposing (..)

import Commands exposing (..)
import Component.Error.Update as Error exposing (..)
import Component.Infrastructures.DateTime as DateTime exposing (update)
import Component.Infrastructures.Form as Form exposing (update)
import Html exposing (..)
import Html.Attributes exposing (..)
import Http as Http exposing (Error)
import List.Extra as List exposing (..)
import Message exposing (..)
import Models exposing (..)
import Models.Message exposing (Message)
import Router as Router exposing (Route(..), SubRoute(..), navigateTo, newUrl)


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        NoOp ->
            model ! []

        InitResource (Ok resource) ->
            { model | resource = resource } ! [ Commands.fetchMessages resource.messages_url ]

        InitResource (Err error) ->
            handleHttpError error model

        InitMessage ->
            { model | messageDetail = Just Models.Message.initialModel } ! []

        FindMessage id ->
            { model | messageDetail = findMessage id model.messages } ! []

        FindMessageWithComments id ->
            let
                messageDetail =
                    findMessage id model.messages

                listComments =
                    messageDetail
                        |> Maybe.map ListComments
                        |> Maybe.map Commands.run
                        |> Maybe.withDefault Cmd.none
            in
                { model | messageDetail = messageDetail } ! [ listComments ]

        ListMessages ->
            model ! [ Commands.fetchMessages model.resource.messages_url ]

        RefreshMessages (Ok messages) ->
            { model | messages = messages } ! []

        RefreshMessages (Err error) ->
            handleHttpError error model

        SaveMessage message ->
            model ! []

        UpdateMessage message ->
            model ! [ Commands.updateMessage message.url message ]

        ListComments message ->
            model ! [ Commands.fetchComments message.comments_url ]

        RefreshComments (Ok comments) ->
            { model | comments = comments } ! []

        RefreshComments (Err error) ->
            handleHttpError error model

        NavigateTo route ->
            model ! [ Router.navigateTo route ]

        RouteUpdate route ->
            model ! [ updateRoute route ]

        HandleError msg ->
            let
                ( error, command ) =
                    Error.update msg model.error
            in
                { model | error = error } ! [ Cmd.map HandleError command ]

        Bind msg ->
            let
                ( newModel, command ) =
                    Form.update msg model
            in
                newModel ! [ Cmd.map Bind command ]

        Now msg ->
            let
                ( now, command ) =
                    DateTime.update msg model.now
            in
                { model | now = now } ! [ Cmd.map Now command ]


updateRoute : Route -> Cmd Msg
updateRoute route =
    Cmd.batch <|
        case route of
            Messages List ->
                [ Commands.run ListMessages ]

            Messages (Show id) ->
                [ Commands.run (FindMessageWithComments id) ]

            Messages New ->
                [ Commands.run InitMessage ]

            Messages (Edit id) ->
                [ Commands.run (FindMessage id) ]

            Tasks ->
                []

            Activity ->
                []

            NotFound ->
                []



-- HELPERS


handleHttpError : Http.Error -> Model -> ( Model, Cmd Msg )
handleHttpError error model =
    model ! [ Commands.show error ]


findMessage : Int -> List Message -> Maybe Message
findMessage id messages =
    List.find (\x -> x.id == id) messages
