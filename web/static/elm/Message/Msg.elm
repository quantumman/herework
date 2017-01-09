module Message.Msg exposing (..)

import Http exposing (..)
import Models.Message exposing (Message)
import Models.User exposing (User)


type alias Creator =
    User


type Msg
    = Edit Int
    | New Creator
    | Show Int
    | Save
    | Fetch (Result Http.Error Message)
