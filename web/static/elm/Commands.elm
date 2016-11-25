module Commands exposing (..)

import Component.Error.Message as Error exposing (..)
import Component.Infrastructures.DateTime as DateTime exposing (getNow)
import Http as Http exposing (..)
import Http exposing (Error)
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Message as App exposing (..)
import Models exposing (..)
import Models.Comment as Comment exposing (..)
import Models.Message as Message exposing (..)
import Models.Resource as Resource exposing (..)
import Models.User as User exposing (..)
import Task exposing (Task)


-- Generic RESTful API commands


jsonRequest : String -> Decoder a -> Url -> Encode.Value -> Request a
jsonRequest verb decoder resource value =
    request
        { method = verb
        , headers = [ header "Content-type" "application/json" ]
        , url = resource
        , body = Http.jsonBody value
        , expect = Http.expectJson decoder
        , timeout = Nothing
        , withCredentials = False
        }


type alias HttpMsg a msg =
    Result Http.Error a -> msg


get : Decoder a -> Url -> HttpMsg a msg -> Cmd msg
get decoder resource msg =
    Http.get resource decoder
        |> Http.send msg


post : Decoder a -> Url -> Encode.Value -> HttpMsg a msg -> Cmd msg
post decoder resource payload msg =
    Http.post resource (jsonBody payload) decoder
        |> Http.send msg


put : Decoder a -> Url -> Encode.Value -> HttpMsg a msg -> Cmd msg
put decoder resource payload msg =
    jsonRequest "PUT" decoder resource payload
        |> Http.send msg


patch : Decoder a -> Url -> Encode.Value -> HttpMsg a msg -> Cmd msg
patch decoder resource payload msg =
    jsonRequest "PATCH" decoder resource payload
        |> Http.send msg


delete : Url -> HttpMsg () msg -> Cmd msg
delete resource msg =
    jsonRequest "DELETE" (Decode.null ()) resource Encode.null
        |> Http.send msg



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
