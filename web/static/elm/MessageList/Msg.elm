module MessageList.Msg exposing (..)

import Http exposing (..)
import Models.Message exposing (Message)
import Models.User exposing (User)


type Msg
    = List
    | Fetch (Result Http.Error (List Message))
