module Message.View.Message exposing (..)

import Component.UI.Attribute as Attribute exposing (..)
import Component.UI.Buttons as Buttons exposing (..)
import Date exposing (..)
import DateTime.Model as DateTime exposing (..)
import DateTime.View.DateTime as DateTime exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message as App exposing (Msg)
import Message.Model as Message exposing (..)
import Message.View.Avatar as Message exposing (..)
import Models.Message exposing (Message)
import Router.Msg as Router exposing (..)


-- STYLE


removeSpace : List ( String, String )
removeSpace =
    [ ( "margin-bottom", "0" )
    ]


separator : List ( String, String )
separator =
    [ ( "margin-top", "10px" )
    ]



-- VIEW


view : DateTime.Model -> Message.Model -> Html App.Msg
view now { message, isEditing } =
    div [ Attribute.content ]
        [ h1 [ Attribute.title 2 ]
            [ div [ contenteditable isEditing ] [ text message.title ]
            ]
        , div [ subtitle 6, style removeSpace ]
            [ p [ level ]
                [ div [ levelLeft ] []
                , div [ levelRight ]
                    [ div [ levelItem ] [ DateTime.view message.created_at now ]
                    , div [ levelItem ] [ text message.creator.name ]
                    , if isEditing then
                        div [] []
                      else
                        editButton message
                    ]
                ]
            ]
        , hr [ style separator ] []
        , p [] [ div [ contenteditable isEditing ] [ text message.body ] ]
        ]


editButton : Message -> Html App.Msg
editButton message =
    let
        style =
            Buttons.default |> Buttons.small |> outlined |> primary

        navigation =
            Router.Edit message.id
                |> Router.Messages
                |> App.NavigateTo
    in
        Buttons.button style
            navigation
            [ span [ class "icon is-small" ]
                [ i [ class "fa fa-pencil" ] [] ]
            , span [] [ text "EDIT" ]
            ]
