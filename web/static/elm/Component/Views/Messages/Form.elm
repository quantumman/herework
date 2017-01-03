module Component.Views.Messages.Form exposing (..)

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


view : Model -> Message -> List (Html Msg) -> Html Msg
view model message content =
    let
        title =
            [ Html.textarea
                [ elasticHeight model.title
                , on "input" (DOM.textarea Title)
                ]
                [ text message.title ]
            ]

        body =
            [ Html.textarea
                [ elasticHeight model.body
                , on "input" (DOM.textarea Body)
                ]
                [ text message.body ]
            ]

        createdAt =
            []

        creator =
            [ avatar 24 message.creator ]

        actions =
            []

        layoutContent =
            Layout title body createdAt creator actions
    in
        layout layoutContent
            content
