module Router.Update
    exposing
        ( update
        , command
        , urlUpdate
        , init
        )

import Command as Command exposing (..)
import CommentList.Update as CommentList exposing (fetch)
import DateTime.Update as DateTime exposing (getNow)
import Message.Msg as Message exposing (..)
import MessageList.Msg as MessageList exposing (..)
import Model as App exposing (..)
import Msg as App exposing (..)
import Navigation exposing (..)
import Router.Model as Router exposing (..)
import Router.Msg as Router exposing (..)
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


update : App.Msg -> Router.Model -> Router.Model
update message model =
    case message of
        Router msg ->
            updateModel msg model

        _ ->
            model


command : App.Msg -> App.Model -> Cmd App.Msg
command message model =
    case message of
        Router msg ->
            Cmd.batch [ updateCommand msg model, DateTime.getNow ]

        _ ->
            Cmd.none


updateModel : Router.Msg -> Router.Model -> Router.Model
updateModel message model =
    { model | route = message }


updateCommand : Router.Msg -> App.Model -> Cmd App.Msg
updateCommand message model =
    Cmd.batch <|
        case message of
            Messages (Router.List) ->
                [ Command.mapRun App.MessageList MessageList.List ]

            Messages (Router.Show id) ->
                [ Command.mapRun App.Message (Message.Show id) ]

            Messages (Router.New) ->
                [ Command.mapRun App.Message (Message.New model.user) ]

            Messages (Router.Edit id) ->
                [ Command.mapRun App.Message (Message.Edit id) ]

            Tasks ->
                []

            Activity ->
                []

            NotFound ->
                []


urlUpdate : Location -> App.Msg
urlUpdate location =
    case urlParse location of
        Just route ->
            App.Router route

        Nothing ->
            NoOp


init : Location -> ( Router.Model, Cmd msg )
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



-- URL Parse


urlParse : Location -> Maybe Router.Msg
urlParse location =
    parseHash route location


route : Parser (Router.Msg -> a) a
route =
    oneOf
        [ map (Messages Router.List) (s "")
        , map (\id -> Messages <| Router.Show id) (s "messages" </> int)
        , map (Messages Router.New) (s "messages" </> s "new")
        , map (\id -> Messages <| Router.Edit id) (s "messages" </> int </> s "edit")
        , map (Messages Router.List) (s "messages")
        , map Tasks (s "tasks")
        , map Activity (s "activity")
        ]
