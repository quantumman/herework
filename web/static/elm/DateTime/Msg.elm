module DateTime.Msg exposing (..)

import Date as Date exposing (Date)


type Msg
    = GetNow Date
    | Fatal
