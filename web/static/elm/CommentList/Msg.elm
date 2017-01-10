module CommentList.Msg exposing (..)

import Http exposing (..)
import Model exposing (Url)
import Model.Comment exposing (Comment)
import Model.User exposing (User)


type Msg
    = List Url
    | Fetch (Result Http.Error (List Comment))
