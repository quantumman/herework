module Router.Command exposing (..)

import Navigation exposing (..)
import Router.Msg as Router exposing (..)


navigateTo : Msg -> Cmd msg
navigateTo route =
    reverse route
        |> Navigation.modifyUrl


newUrl : Route -> Cmd msg
newUrl route =
    reverse route
        |> Navigation.newUrl



-- UTILITY


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
