module CommentList.Update exposing (..)

import Message as App exposing (Msg(..))
import CommentList.Model exposing (..)
import CommentList.Msg as CommentList exposing (..)


update : App.Msg -> Model -> Model
update message model =
    case message of
        CommentList msg ->
            updateModel msg model

        _ ->
            model


updateModel : CommentList.Msg -> Model -> Model
updateModel message model =
    case message of
        _ ->
            model


updateCommand : App.Msg -> Model -> Cmd App.Msg
updateCommand message model =
    Cmd.batch <|
        case message of
            CommentList _ ->
                []

            _ ->
                []
