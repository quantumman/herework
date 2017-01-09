module CommentList.Msg exposing (..)

import Http exposing (..)
import Models exposing (Url)
import Models.Comment exposing (Comment)
import Models.User exposing (User)


type Msg
    = List Url
    | Fetch (Result Http.Error (List Comment))
