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
        Http.BadUrl url ->
            "Bad url " ++ url

        Http.Timeout ->
            "Timeout"

        Http.NetworkError ->
            "Network has troubles. Try it later"

        Http.BadStatus response ->
            response.status.message

        Http.BadPayload payload response ->
            payload
