module Resource exposing (..)

import Models exposing (Url)


type Resource
    = Messages
    | Message Int
    | Users
    | User Int


url : Resource -> Url
url resource =
    case resource of
        Messages ->
            "/api/messages"

        Message id ->
            "/api/messages/" ++ toString id

        Users ->
            "/api/users"

        User id ->
            "/api/users/" ++ toString id
