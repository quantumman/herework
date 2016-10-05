module Commands exposing (..)

import Component.Error.Message as Error exposing (..)
import Http exposing (Error)
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Jwt exposing (..)
import Message as App exposing (..)
import Models exposing (..)
import Task exposing (Task)


-- Generic RESTful API commands


performRequest : (a -> App.Msg) -> Task Http.Error a -> Cmd App.Msg
performRequest msg task =
    task
        |> Task.mapError Error.Http
        |> Task.perform HandleError msg


get : Decoder a -> Url -> (a -> App.Msg) -> Cmd App.Msg
get decoder resource msg =
    Jwt.get "1238a" decoder resource
        |> performRequest msg


post : Decoder a -> Url -> Encode.Value -> (a -> App.Msg) -> Cmd App.Msg
post decoder resource payload msg =
    Http.string (Encode.encode 0 payload)
        |> Jwt.post "1238a" decoder resource
        |> performRequest msg


put : Decoder a -> Url -> Encode.Value -> (a -> App.Msg) -> Cmd App.Msg
put decoder resource payload msg =
    Http.string (Encode.encode 0 payload)
        |> Jwt.send "PUT" "1238a" decoder resource
        |> performRequest msg


patch : Decoder a -> Url -> Encode.Value -> (a -> App.Msg) -> Cmd App.Msg
patch decoder resource payload msg =
    Http.string (Encode.encode 0 payload)
        |> Jwt.send "PATCH" "1238a" decoder resource
        |> performRequest msg


delete : Url -> (() -> App.Msg) -> Cmd App.Msg
delete resource msg =
    Jwt.send "DELETE" "1238a" (Decode.null ()) resource Http.empty
        |> performRequest msg



-- APIs


fetchMessages : Url -> Cmd App.Msg
fetchMessages url =
    get decodeMessages url App.UpdateMessages


fetchComments : Url -> Cmd App.Msg
fetchComments url =
    get decodeComments url App.UpdateComments
