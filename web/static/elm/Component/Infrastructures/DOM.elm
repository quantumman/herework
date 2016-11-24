module Component.Infrastructures.DOM exposing (..)

import DOM exposing (..)
import Json.Decode as Decode exposing (..)


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
