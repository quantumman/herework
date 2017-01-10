module Message.Msg exposing (..)

import Http exposing (..)
import Model.Message exposing (Message)
import Model.User exposing (User)


type alias Creator =
    User


type Msg
    = Edit Int
    | New Creator
    | Show Int
    | Save
    | Fetch (Result Http.Error Message)
