module Component.Error.Update exposing (..)

import Component.Error.Message exposing (..)
import Component.Error.Model exposing (..)
import Http as Http exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update error model =
    case error of
        Http e ->
            -- handle HTTP error
            { model | error = Just (httpErrorAsString e) } ! []

        Close ->
            { model | error = Nothing } ! []


httpErrorAsString : Http.Error -> String
httpErrorAsString e =
    case e of
        Http.Timeout ->
            "Timeout"

        Http.NetworkError ->
            "Network has troubles. Try it later"

        Http.UnexpectedPayload msg ->
            msg

        Http.BadResponse code msg ->
            msg
