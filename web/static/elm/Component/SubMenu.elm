module Component.SubMenu exposing (..)

import Component.Buttons as B exposing (..)
import Component.Nav as Nav exposing (..)
import FontAwesome.Web as Icon exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)
import Models exposing (..)
import Router as Router exposing (..)


-- MODEL


type alias Model m =
    { m
        | router : Router.Model
        , messages : List Message
        , selectedMessage : Maybe Message
    }



-- VIEW


view : Model m -> Html Msg
view model =
    let
        items =
            case model.router.route of
                Messages ->
                    messagesView model

                NewMessage ->
                    messagesView model

                other ->
                    div [] []
    in
        items


messagesView : Model m -> Html Msg
messagesView model =
    div []
        [ B.button subtle
            ClickAddMessage
            [ Icon.plus_circle
            , text "Add a new message"
            ]
        , Maybe.withDefault initialModelMessage model.selectedMessage
            |> messages model.messages
            |> Nav.vnav
        ]


messages : List Message -> Message -> List ( Nav.Header, List Nav.Item )
messages ms selected =
    let
        toItem message =
            Nav.item [ onClick (FetchComments message), href "#" ]
                (selected.id == message.id)
                message.title
    in
        [ ( Nav.header "MESSAGES", List.map toItem ms ) ]
