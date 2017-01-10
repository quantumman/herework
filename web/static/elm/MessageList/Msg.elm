module MessageList.Msg exposing (..)

import Http exposing (..)
import Model.Message exposing (Message)
import Model.User exposing (User)


type Msg
    = List
    | Fetch (Result Http.Error (List Message))
