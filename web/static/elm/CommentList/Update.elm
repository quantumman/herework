module CommentList.Update
    exposing
        ( update
        , command
        , fetch
        )

import Commands as Commands exposing (..)
import CommentList.Model as CommentList exposing (..)
import CommentList.Msg as CommentList exposing (..)
import Message as App exposing (Msg(..))
import Models as App exposing (..)


update : App.Msg -> CommentList.Model -> CommentList.Model
update message model =
    case message of
        CommentList msg ->
            updateModel msg model

        _ ->
            model


command : App.Msg -> App.Model -> Cmd App.Msg
command message model =
    case message of
        CommentList msg ->
            updateCommand msg model

        _ ->
            Cmd.none


updateModel : CommentList.Msg -> CommentList.Model -> CommentList.Model
updateModel message model =
    case message of
        List _ ->
            model

        Fetch (Ok comments) ->
            { model | comments = comments }

        _ ->
            model


updateCommand : CommentList.Msg -> App.Model -> Cmd App.Msg
updateCommand message model =
    Cmd.batch <|
        case message of
            List url ->
                [ fetch url ]

            _ ->
                []



-- COMMANDS


fetch : Url -> Cmd App.Msg
fetch url =
    Commands.fetchComments url Fetch
        |> Cmd.map App.CommentList
