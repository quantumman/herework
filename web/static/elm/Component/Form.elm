module Component.Form exposing (..)

import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- UPDATE


type Binder model
    = Binder (model -> String -> model)


unwrap : Binder model -> model -> String -> model
unwrap (Binder binder) =
    binder


type Msg model
    = Bind (Binder model) String


update : Msg model -> model -> ( model, Cmd (Msg model) )
update message model =
    case message of
        Bind binder value ->
            (unwrap binder model value) ! []
