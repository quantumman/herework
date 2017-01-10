module MessageList.View.List exposing (..)

import View.UI.Attribute as Attribute exposing (..)
import View.UI.MediaObject as MediaObject exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import View.Attribute.Navigation exposing (..)
import Msg as App exposing (Msg)
import MessageList.Model as MessageList exposing (..)
import MessageList.View.Hover as MessageList exposing (..)
import Model.Message as Message exposing (Message)
import Router.Msg as Router exposing (..)


-- STYLE


avatarStyle : List ( String, String )
avatarStyle =
    [ ( "border-radius", "50%" )
    , ( "width", "32px" )
    , ( "height", "32px" )
    ]


selected : Message -> MessageList.Model -> List ( String, String )
selected message model =
    let
        makeStyle m =
            if m.id == message.id then
                [ ( "background-color", "#00d1b2" )
                , ( "color", "white" )
                ]
            else
                []
    in
        makeStyle model.message


tweakSpace : List ( String, String )
tweakSpace =
    [ ( "margin-top", "0" )
    , ( "padding-bottom", "10px" )
    ]


mediaStyle : List ( String, String )
mediaStyle =
    [ ( "color", "#4a4a4a" ) ]


contentStyle : List ( String, String )
contentStyle =
    [ ( "color", "inherit" ) ]


clickable : List ( String, String )
clickable =
    [ ( "cursor", "pointer" ) ]



-- VIEW


view : MessageList.Model -> Html App.Msg
view model =
    let
        render message =
            hover model
                message
                MediaObject.media
                [ navigateTo (Messages <| Router.Show message.id)
                , style clickable
                , style tweakSpace
                , style mediaStyle
                , style (selected message model)
                ]
                [ MediaObject.left
                    [ p [ Attribute.image, class "is-32x32" ]
                        [ img [ style avatarStyle, src message.creator.avatar ] [] ]
                    ]
                , MediaObject.content []
                    [ div [ Attribute.content, style contentStyle ]
                        [ p []
                            [ text message.title ]
                        ]
                    ]
                ]
    in
        div []
            (List.map render model.messages)
