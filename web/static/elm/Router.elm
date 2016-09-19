module Router exposing (..)

import Hop exposing (makeUrl, makeUrlFromLocation, matchUrl, matcherToPath, setQuery)
import Hop.Matchers exposing (..)
import Hop.Types exposing (Config, Query, Location, PathMatcher, Router)
import Navigation


-- ROUTES


type Route
    = Messages
    | MessageDetail Int
    | Tasks
    | Activity
    | NotFound


rootMatcher : PathMatcher Route
rootMatcher =
    match1 Messages ""


messagesMatcher : PathMatcher Route
messagesMatcher =
    match1 Messages "messages"


messageDetailMatcher : PathMatcher Route
messageDetailMatcher =
    match2 MessageDetail "messages" int


tasksMatcher : PathMatcher Route
tasksMatcher =
    match1 Tasks "tasks"


activityMatcher : PathMatcher Route
activityMatcher =
    match1 Activity "activity"


matchers : List (PathMatcher Route)
matchers =
    [ rootMatcher
    , messagesMatcher
    , messageDetailMatcher
    , tasksMatcher
    , activityMatcher
    ]


reverse : Route -> String
reverse route =
    case route of
        Messages ->
            matcherToPath rootMatcher []

        MessageDetail id ->
            matcherToPath messageDetailMatcher [ toString id ]

        Tasks ->
            matcherToPath tasksMatcher []

        Activity ->
            matcherToPath activityMatcher []

        NotFound ->
            ""


routerConfig : Config Route
routerConfig =
    { hash = True
    , basePath = ""
    , matchers = matchers
    , notFound = NotFound
    }



-- MODEL


type alias Model =
    { location : Hop.Types.Location
    , route : Route
    }


make : ( Route, Hop.Types.Location ) -> Model
make ( route, location ) =
    Model location route



-- UPDATE


update : Route -> Model -> ( Model, Cmd Route )
update route model =
    model ! [ navigateTo route ]


navigateTo : Route -> Cmd msg
navigateTo route =
    reverse route
        |> makeUrl routerConfig
        |> Navigation.modifyUrl



-- APP


urlParser : Navigation.Parser ( Route, Hop.Types.Location )
urlParser =
    Navigation.makeParser (.href >> matchUrl routerConfig)


init : ( Route, Hop.Types.Location ) -> ( Model, Cmd a )
init ( route, location ) =
    ( Model location route, Cmd.none )
