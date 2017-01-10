module DateTime.View.DateTime exposing (..)

import Date exposing (Date)
import Date.Extra.Config as Date exposing (..)
import Date.Extra.Config.Configs as Date exposing (..)
import Date.Extra.Format as Date exposing (..)
import Date.Extra.Period as Date exposing (..)
import DateTime.Model as DateTime exposing (Model)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msg as App exposing (Msg)


view : Date -> DateTime.Model -> Html App.Msg
view date { now, config } =
    let
        delta =
            Date.diff now date

        prettyDate =
            if delta.week >= 5 then
                Date.format config config.format.longDate date
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
                Date.format config config.format.longDate date
    in
        text prettyDate
