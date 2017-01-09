module Message.Update exposing (..)

import Message as App exposing (Msg(..))
import Message.Model exposing (..)
import Message.Msg as Message exposing (..)


update : App.Msg -> Model -> Model
update message model =
    case message of
        Message msg ->
            updateModel msg model

        _ ->
            model


updateModel : Message.Msg -> Model -> Model
updateModel message model =
    case message of
        _ ->
            model


updateCommand : App.Msg -> Model -> Cmd App.Msg
updateCommand message model =
    Cmd.batch <|
        case message of
            Message _ ->
                []

            _ ->
                []
