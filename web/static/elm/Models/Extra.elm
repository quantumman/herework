module Models.Extra exposing (..)

import Json.Decode as Decode exposing (..)
import Json.Decode.Extra as Decode exposing (..)
import Json.Encode as Encode exposing (..)


-- MISC


type alias Url =
    String


type alias SelectableItem a =
    { selected : Bool
    , item : a
    }



-- HELPER


optional : Decoder a -> a -> Decoder a
optional decoder defaultValue =
    oneOf
        [ decoder
        , Decode.null defaultValue
        ]
