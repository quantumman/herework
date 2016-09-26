module Component.Error.Message exposing (..)

import Http exposing (Error)


type Msg
    = Http Http.Error
