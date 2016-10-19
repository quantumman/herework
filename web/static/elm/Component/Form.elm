module Component.Form exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json exposing (..)


-- Data binding helper


bind : Binder model -> (Msg model -> msg) -> Attribute msg
bind binder f =
    Json.map (Bind binder) targetValue
        |> Json.map f
        |> on "input"



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
