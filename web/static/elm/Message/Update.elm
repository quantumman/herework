module Message.Update
    exposing
        ( update
        , command
        , fetch
        , fetchCommentsOf
        )

import Command as Command exposing (..)
import CommentList.Msg as CommentList exposing (Msg(List))
import Msg as App exposing (Msg(..))
import Message.Model as Message exposing (..)
import Message.Msg as Message exposing (..)
import Model as App exposing (..)
import Model.Message as MessageModel exposing (Message, initialModel)


update : App.Msg -> Message.Model -> Message.Model
update message model =
    case message of
        Message msg ->
            updateModel msg model

        _ ->
            model


command : App.Msg -> App.Model -> Cmd App.Msg
command message model =
    case message of
        Message msg ->
            updateCommand msg model

        _ ->
            Cmd.none


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


updateCommand : Message.Msg -> App.Model -> Cmd App.Msg
updateCommand msg model =
    Cmd.batch <|
        case msg of
            Show id ->
                [ fetch model id ]

            Edit id ->
                [ fetch model id ]

            Fetch (Ok message) ->
                [ fetchCommentsOf message ]

            _ ->
                []



-- COMMAND


fetch : App.Model -> Int -> Cmd App.Msg
fetch model id =
    Command.fetchMessage (model.app.messages_url ++ "/" ++ toString id) Fetch
        |> Cmd.map App.Message


fetchCommentsOf : Message -> Cmd App.Msg
fetchCommentsOf message =
    Command.run (CommentList.List message.comments_url)
        |> Cmd.map App.CommentList
