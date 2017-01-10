module Command exposing (..)

import Http as Http exposing (..)
import Http exposing (Error)
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Msg as App exposing (..)
import Model exposing (..)
import Model.App as App exposing (..)
import Model.Comment as Comment exposing (..)
import Model.Message as Message exposing (..)
import Model.User as User exposing (..)
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
    get App.decode url InitResource


fetchMessages : Url -> (Result Http.Error (List Message) -> msg) -> Cmd msg
fetchMessages url msgf =
    get Message.decodeList url msgf


fetchMessage : Url -> (Result Http.Error Message -> msg) -> Cmd msg
fetchMessage url msgf =
    get Message.decode url msgf


createMessage : Url -> Message -> (Result Http.Error Message -> msg) -> Cmd msg
createMessage url message msgf =
    Message.encode message
        |> \payload -> post Message.decode url payload msgf


updateMessage : Url -> Message -> (Result Http.Error Message -> msg) -> Cmd msg
updateMessage url message msgf =
    Message.encode message
        |> \payload -> patch Message.decode url payload msgf


fetchComments : Url -> (Result Http.Error (List Comment) -> msg) -> Cmd msg
fetchComments url msgf =
    get Comment.decodeList url msgf



-- Misc


run : msg -> Cmd msg
run msg =
    Task.perform identity <| Task.succeed msg


mapRun : (msg -> msg_) -> msg -> Cmd msg_
mapRun msgf msg =
    run msg |> Cmd.map msgf


withDefaultNone : (model -> Cmd App.Msg) -> Maybe model -> Cmd App.Msg
withDefaultNone cmd model =
    model
        |> Maybe.map cmd
        |> Maybe.withDefault Cmd.none
