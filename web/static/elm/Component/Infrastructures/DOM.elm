module Component.Infrastructures.DOM exposing (..)

import DOM exposing (..)
import Json.Decode as Decode exposing (..)


selectionStart : Decoder Int
selectionStart =
    field "selectionStart" Decode.int


selectionEnd : Decoder Int
selectionEnd =
    field "selectionEnd" Decode.int


type alias SelectionRange =
    { start : Int
    , end : Int
    }


selectionRange : (SelectionRange -> msg) -> Decoder msg
selectionRange fmsg =
    let
        range =
            Decode.map2 SelectionRange
                selectionStart
                selectionEnd
    in
        map fmsg (target range)


type alias TextArea =
    { selectionStart : Int
    , selectionEnd : Int
    , rows : Int
    , cols : Int
    }


textarea : (TextArea -> msg) -> Decoder msg
textarea fmsg =
    let
        decoder =
            Decode.map4 TextArea
                (field "selectionStart" Decode.int)
                (field "selectionEnd" Decode.int)
                (field "rows" Decode.int)
                (field "cols" Decode.int)
    in
        target decoder |> map fmsg
