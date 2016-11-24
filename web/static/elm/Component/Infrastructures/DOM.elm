module Component.Infrastructures.DOM exposing (..)

import DOM exposing (..)
import Json.Decode as Decode exposing (..)


selectionStart : Decoder Int
selectionStart =
    field "selectionStart" Decode.int


selectionEnd : Decoder Int
selectionEnd =
    field "selectionEnd" Decode.int
