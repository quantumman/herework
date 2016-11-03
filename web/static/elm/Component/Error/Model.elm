module Component.Error.Model exposing (..)


type alias Model =
    { error : Maybe String }


initialModel : Model
initialModel =
    { error = Nothing
    }
