module App exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Navigation
import Router as Router exposing (..)


-- MODEL


type alias Model =
    { router : Router.Model }


init : Router.Model -> ( Model, Cmd Msg )
init router =
    { router = router } ! [ Cmd.none ]



-- UPDATE


type Msg
    = App


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        App ->
            model ! [ Cmd.none ]



-- SUBSCRIPTION


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div [] [ text "Hello World" ]
