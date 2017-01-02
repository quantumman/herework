module Component.Views.Messages.Editor exposing (..)

import Component.Infrastructures.DOM as DOM exposing (..)
import Component.Infrastructures.DateTime as DateTime exposing (view)
import Component.UI.Buttons as Buttons exposing (..)
import Component.Views.Messages.Layout as Layout exposing (..)
import Date exposing (..)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Html.Events exposing (..)
import Models.Message as Message exposing (Message, initialModel)
import Models.User as User exposing (User, initialModel)


-- MODEL


type alias Model =
    { title : DOM.TextArea
    , body : DOM.TextArea
    }


initialModel : Model
initialModel =
    { title = DOM.initialTextarea
    , body = DOM.initialTextarea
    }


title : Model -> String
title model =
    model |> .title |> .value


body : Model -> String
body model =
    model |> .body |> .value



-- UPDATE


type Msg
    = Title DOM.TextArea
    | Body DOM.TextArea


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Title textarea ->
            { model | title = textarea } ! []

        Body textarea ->
            { model | body = textarea } ! []



-- VIEW


elasticHeight : DOM.TextArea -> Attribute Msg
elasticHeight textarea =
    let
        height =
            if textarea.scrollHeight == 0 then
                "auto"
            else
                (toString textarea.scrollHeight)
    in
        style
            [ ( "height", height ++ "px" )
            ]


view : Model -> User -> Message -> List (Html Msg) -> Html Msg
view model user message content =
    layout
        [ Html.textarea
            [ elasticHeight model.title
            , on "input" (DOM.textarea Title)
            ]
            [ text message.title ]
        ]
        [ Html.textarea
            [ elasticHeight model.body
            , on "input" (DOM.textarea Body)
            ]
            [ text message.body ]
        ]
        []
        [ avatar 24 user ]
        []
        content
