module Component.Error.Model exposing (..)


type alias Model m =
    { m | error : Maybe String }
