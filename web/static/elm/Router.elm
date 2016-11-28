module Router exposing (..)

import Navigation exposing (..)
import UrlParser exposing (Parser, (</>), s, int, string, parseHash, map, oneOf)


-- ROUTES


type Route
    = Messages
    | MessageDetail Int
    | NewMessage
    | Tasks
    | Activity
    | NotFound


route : Parser (Route -> a) a
route =
    oneOf
        [ map Messages (s "")
        , map MessageDetail (s "messages" </> int)
        , map NewMessage (s "messages" </> s "new")
        , map Messages (s "messages")
        , map Tasks (s "tasks")
        , map Activity (s "activity")
        ]


reverse : Route -> String
reverse route =
    case route of
        Messages ->
            "#/messages"

        MessageDetail id ->
            "#/messages/" ++ toString id

        NewMessage ->
            "#/messages/new"

        Tasks ->
            "#/tasks"

        Activity ->
            "#/activity"

        NotFound ->
            ""



-- MODEL


type alias Model =
    { location : Location
    , route : Route
    }



-- UPDATE


update : Route -> Model -> Model
update route model =
    { model | route = route }


navigateTo : Route -> Cmd msg
navigateTo route =
    reverse route
        |> Navigation.modifyUrl


newUrl : Route -> Cmd msg
newUrl route =
    reverse route
        |> Navigation.newUrl


urlParse : Location -> Maybe Route
urlParse location =
    parseHash route location



-- APP


init : Location -> ( Model, Cmd msg )
init location =
    let
        route =
            urlParse location
                |> Maybe.withDefault Messages

        model =
            { location = location
            , route = route
            }
    in
        model ! []
