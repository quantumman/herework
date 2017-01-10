module DateTime.Model exposing (..)

import Date exposing (..)
import Date.Extra.Config as Date exposing (..)
import Date.Extra.Config.Configs as Date exposing (..)
import Date.Extra.Format as Date exposing (..)
import Date.Extra.Period as Date exposing (..)


type alias Model =
    { now : Date
    , config : Date.Config
    }


initialModel : Model
initialModel =
    { now = Date.fromTime 0
    , config = Date.getConfig "ja_jp"
    }
