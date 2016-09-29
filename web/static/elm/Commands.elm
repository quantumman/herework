module Commands exposing (..)

import Component.Error.Message as Error exposing (..)
import Http exposing (Error)
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Jwt exposing (..)
import Message as App exposing (..)
import Task exposing (Task)


performRequest : (a -> App.Msg) -> Task Http.Error a -> Cmd App.Msg
performRequest msg task =
    task
        |> Task.mapError Error.Http
        |> Task.perform HandleError msg
