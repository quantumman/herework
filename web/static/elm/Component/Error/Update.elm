module Component.Error.Update exposing (..)

import Component.Error.Message exposing (..)
import Component.Error.Model exposing (..)


update : Msg -> Model m -> ( Model m, Cmd Msg )
update error model =
    case error of
        Http e ->
            -- handle HTTP error
            model ! []
