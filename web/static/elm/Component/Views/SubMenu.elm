module Component.Views.SubMenu exposing (..)

import Component.UI.Buttons as B exposing (..)
import Component.UI.Nav as Nav exposing (..)
import FontAwesome.Web as Icon exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)
import Models exposing (..)
import Models.Message as Message exposing (..)
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

                Router.NewMessage ->
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
        , Maybe.withDefault Message.initialModel model.selectedMessage
            |> messages model.messages
            |> Nav.vnav
        ]


messages : List Message -> Message -> List ( Nav.Header a, List (Nav.Item Msg) )
messages ms selected =
    let
        toItem message =
            Nav.item [ onClick (Message.ListComments message), href <| Router.reverse Router.Messages ]
                (selected.id == message.id)
                message.title
    in
        [ ( Nav.header "MESSAGES", List.map toItem ms ) ]
