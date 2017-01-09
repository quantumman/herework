module CommentList.Update exposing (..)

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


updateModel : CommentList.Msg -> CommentList.Model -> CommentList.Model
updateModel message model =
    case message of
        List _ ->
            model

        Fetch (Ok comments) ->
            { model | comments = comments }

        _ ->
            model


updateCommand : App.Msg -> App.Model -> Cmd App.Msg
updateCommand message model =
    Cmd.batch <|
        case message of
            CommentList (List url) ->
                [ fetch url ]

            _ ->
                []



-- COMMANDS


fetch : Url -> Cmd App.Msg
fetch url =
    Commands.fetchComments url Fetch
        |> Cmd.map App.CommentList
