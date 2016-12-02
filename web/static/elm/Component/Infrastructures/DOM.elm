module Component.Infrastructures.DOM exposing (..)

import DOM exposing (..)
import Json.Decode as Decode exposing (..)


type alias TextArea =
    { selectionStart : Int
    , selectionEnd : Int
    , rows : Int
    , cols : Int
    , style : Style
    }


type alias Style =
    { height : String
    }


textarea : (TextArea -> msg) -> Decoder msg
textarea fmsg =
    let
        styleDecoder =
            Decode.map Style
                (field "height" Decode.string)

        decoder =
            Decode.map5 TextArea
                (field "selectionStart" Decode.int)
                (field "selectionEnd" Decode.int)
                (field "rows" Decode.int)
                (field "cols" Decode.int)
                (field "style" styleDecoder)
    in
        target decoder |> map fmsg
