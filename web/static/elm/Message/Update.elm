module Message.Update exposing (..)

import Commands as Commands exposing (..)
import CommentList.Msg as CommentList exposing (Msg(List))
import Message as App exposing (Msg(..))
import Message.Model as Message exposing (..)
import Message.Msg as Message exposing (..)
import Models as App exposing (..)
import Models.Message as MessageModel exposing (Message, initialModel)


update : App.Msg -> Message.Model -> Message.Model
update message model =
    case message of
        Message msg ->
            updateModel msg model

        _ ->
            model


updateModel : Message.Msg -> Message.Model -> Message.Model
updateModel message model =
    case message of
        Edit _ ->
            { model | isEditing = True }

        New creator ->
            let
                message =
                    MessageModel.initialModel
                        |> (\m -> { m | creator = creator })
            in
                { model | message = message, isEditing = True }

        Show _ ->
            { model | isEditing = False }

        Fetch (Ok message) ->
            { model | message = message }

        _ ->
            model


updateCommand : App.Msg -> App.Model -> Cmd App.Msg
updateCommand msg { app, message } =
    Cmd.batch <|
        case msg of
            Message (Show id) ->
                [ fetch app.messages_url id
                , fetchCommentsOf message
                ]

            Message (Edit id) ->
                [ fetch app.messages_url id ]

            _ ->
                []



-- COMMAND


fetch : Url -> Int -> Cmd App.Msg
fetch url id =
    Commands.fetchMessage (url ++ "/" ++ toString id) Fetch
        |> Cmd.map App.Message


fetchCommentsOf : Message.Model -> Cmd App.Msg
fetchCommentsOf { message } =
    Commands.run (CommentList.List message.comments_url)
        |> Cmd.map App.CommentList
