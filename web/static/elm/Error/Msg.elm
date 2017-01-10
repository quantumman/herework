module Error.Msg exposing (..)

import Http exposing (Error)


type Msg
    = Http Http.Error
    | Close
