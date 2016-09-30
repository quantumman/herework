module Commands exposing (..)

import Component.Error.Message as Error exposing (..)
import Http exposing (Error)
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Jwt exposing (..)
import Message as App exposing (..)
import Resource exposing (..)
import Task exposing (Task)


performRequest : (a -> App.Msg) -> Task Http.Error a -> Cmd App.Msg
performRequest msg task =
    task
        |> Task.mapError Error.Http
        |> Task.perform HandleError msg


get : Decoder a -> Resource -> (a -> App.Msg) -> Cmd App.Msg
get decoder resource msg =
    url resource
        |> Jwt.get "1238a" decoder
        |> performRequest msg


post : Decoder a -> Resource -> Encode.Value -> (a -> App.Msg) -> Cmd App.Msg
post decoder resource payload msg =
    Http.string (Encode.encode 0 payload)
        |> Jwt.post "1238a" decoder (url resource)
        |> performRequest msg


put : Decoder a -> Resource -> Encode.Value -> (a -> App.Msg) -> Cmd App.Msg
put decoder resource payload msg =
    Http.string (Encode.encode 0 payload)
        |> Jwt.send "PUT" "1238a" decoder (url resource)
        |> performRequest msg


patch : Decoder a -> Resource -> Encode.Value -> (a -> App.Msg) -> Cmd App.Msg
patch decoder resource payload msg =
    Http.string (Encode.encode 0 payload)
        |> Jwt.send "PATCH" "1238a" decoder (url resource)
        |> performRequest msg


delete : Resource -> (() -> App.Msg) -> Cmd App.Msg
delete resource msg =
    Jwt.send "DELETE" "1238a" (Decode.null ()) (url resource) Http.empty
        |> performRequest msg
