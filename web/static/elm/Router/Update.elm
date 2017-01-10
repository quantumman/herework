module Router.Update
    exposing
        ( update
        , command
        , urlUpdate
        , init
        )

import Commands as Commands exposing (..)
import CommentList.Update as CommentList exposing (fetch)
import Message as App exposing (..)
import Message.Msg as Message exposing (..)
import Message.Update as Message exposing (fetch, fetchCommentsOf)
import MessageList.Msg as MessageList exposing (..)
import MessageList.Update as MessageList exposing (fetch)
import Models as App exposing (..)
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
            updateCommand msg model

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
                [ MessageList.fetch model ]

            Messages (Router.Show id) ->
                [ Message.fetch model id ]

            Messages (Router.New) ->
                [ Commands.mapRun App.Message (Message.New model.user) ]

            Messages (Router.Edit id) ->
                [ Message.fetch model id ]

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
