module Router exposing (..)

import Navigation exposing (..)
import UrlParser exposing (Parser, (</>), s, int, string, parseHash, map, oneOf)


-- ROUTES


type SubRoute id
    = List
    | New
    | Edit id
    | Show id


type Route
    = Messages (SubRoute Int)
    | Tasks
    | Activity
    | NotFound


route : Parser (Route -> a) a
route =
    oneOf
        [ map (Messages List) (s "")
        , map (\id -> Messages <| Show id) (s "messages" </> int)
        , map (Messages New) (s "messages" </> s "new")
        , map (\id -> Messages <| Edit id) (s "messages" </> int </> s "edit")
        , map (Messages List) (s "messages")
        , map Tasks (s "tasks")
        , map Activity (s "activity")
        ]


reverseSub : SubRoute id -> String
reverseSub subRoute =
    case subRoute of
        List ->
            ""

        New ->
            "/new"

        Edit id ->
            "/" ++ (toString id) ++ "/edit"

        Show id ->
            "/" ++ (toString id) ++ "/"


reverse : Route -> String
reverse route =
    case route of
        Messages subRoute ->
            "#/messages" ++ reverseSub subRoute

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
                |> Maybe.withDefault NotFound

        model =
            { location = location
            , route = route
            }
    in
        model ! []
