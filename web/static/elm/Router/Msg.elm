module Router.Msg exposing (..)

import Navigation exposing (..)
import UrlParser
    exposing
        ( Parser
        , (</>)
        , s
        , int
        , string
        , parseHash
        , map
        , oneOf
        )


type alias Msg =
    Route


type Route
    = Messages (SubRoute Int)
    | Tasks
    | Activity
    | NotFound


type SubRoute id
    = List
    | New
    | Edit id
    | Show id
