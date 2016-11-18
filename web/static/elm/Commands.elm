module Commands exposing (..)

import Component.Error.Message as Error exposing (..)
import Component.Infrastructures.DateTime as DateTime exposing (getNow)
import Http as Http exposing (..)
import Http exposing (Error)
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Jwt exposing (..)
import Message as App exposing (..)
import Models exposing (..)
import Models.Comment as Comment exposing (..)
import Models.Message as Message exposing (..)
import Models.User as User exposing (..)
import Models.Resource as Resource exposing (..)
import Task exposing (Task)


-- Generic RESTful API commands


send : String -> Decode.Decoder a -> String -> Http.Body -> Task Http.Error a
send verb dec url body =
    let
        sendtask =
            Http.send Http.defaultSettings
                { verb = verb
                , headers =
                    [ ( "Content-type", "application/json" )
                    ]
                , url = url
                , body = body
                }
                |> Http.fromJson dec
    in
        sendtask


performRequest : (a -> App.Msg) -> Task Http.Error a -> Cmd App.Msg
performRequest msg task =
    task
        |> Task.mapError Error.Http
        |> Task.perform HandleError msg


get : Decoder a -> Url -> (a -> App.Msg) -> Cmd App.Msg
get decoder resource msg =
    send "GET" decoder resource Http.empty
        |> performRequest msg


post : Decoder a -> Url -> Encode.Value -> (a -> App.Msg) -> Cmd App.Msg
post decoder resource payload msg =
    Http.string (Encode.encode 0 payload)
        |> send "POST" decoder resource
        |> performRequest msg


put : Decoder a -> Url -> Encode.Value -> (a -> App.Msg) -> Cmd App.Msg
put decoder resource payload msg =
    Http.string (Encode.encode 0 payload)
        |> send "PUT" decoder resource
        |> performRequest msg


patch : Decoder a -> Url -> Encode.Value -> (a -> App.Msg) -> Cmd App.Msg
patch decoder resource payload msg =
    Http.string (Encode.encode 0 payload)
        |> send "PATCH" decoder resource
        |> performRequest msg


delete : Url -> (() -> App.Msg) -> Cmd App.Msg
delete resource msg =
    send "DELETE" (Decode.null ()) resource Http.empty
        |> performRequest msg



-- APIs


initApp : Url -> Cmd App.Msg
initApp url =
    get Resource.decode url InitResource


fetchMessages : Url -> Cmd App.Msg
fetchMessages url =
    get Message.decodeList url App.RefreshMessages


addMessage : Url -> Message -> Cmd App.Msg
addMessage url message =
    Message.encode message
        |> \payload -> post Message.decode url payload App.NewMessage


fetchComments : Url -> Cmd App.Msg
fetchComments url =
    get Comment.decodeList url App.RefreshComments



-- Current Date


now : Cmd App.Msg
now =
    Cmd.map Now DateTime.getNow
