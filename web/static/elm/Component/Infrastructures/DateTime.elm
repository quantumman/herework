module Component.Infrastructures.DateTime exposing (..)

import Date exposing (..)
import Date.Extra.Config as Date exposing (..)
import Date.Extra.Config.Configs as Date exposing (..)
import Date.Extra.Format as Date exposing (..)
import Date.Extra.Period as Date exposing (..)
import Html exposing (..)
import Maybe exposing (..)
import Task


-- MODEL


type alias Model =
    { now : Maybe Date
    , config : Date.Config
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, getNow )


initialModel : Model
initialModel =
    { now = Nothing, config = Date.getConfig "ja_jp" }



-- UPDATE


type Msg
    = GetNow Date
    | Fatal


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        GetNow date ->
            { model | now = Just date } ! []

        Fatal ->
            model ! []


getNow : Cmd Msg
getNow =
    Task.perform (\_ -> Fatal) GetNow Date.now



-- VIEW


view : Date -> Model -> Html Msg
view date model =
    case model.now of
        Just now' ->
            view' date now' model.config

        Nothing ->
            text ""


view' : Date -> Date -> Date.Config -> Html Msg
view' date now config =
    let
        delta =
            Date.diff now date

        prettyDate =
            if delta.week >= 5 then
                Date.format config "Ymd HMS" date
            else if delta.week > 0 then
                (toString delta.week) ++ " WEEKS AGO"
            else if delta.day > 0 then
                (toString delta.day) ++ " DAYS AGO"
            else if delta.hour > 0 then
                (toString delta.hour) ++ " HOURS AGO"
            else if delta.minute > 0 then
                (toString delta.minute) ++ " MINUTES AGO"
            else if delta.second > 0 then
                (toString delta.second) ++ " SECONDs AGO"
            else if delta.millisecond > 0 then
                "NOW"
            else
                Date.format config "Ymd HMS" date
    in
        text prettyDate
