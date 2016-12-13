module Component.Views.MessageList exposing (..)

import Component.UI.Attribute as Attribute exposing (..)
import Component.UI.MediaObject as MediaObject exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import HtmlHelpers exposing (..)
import Message exposing (..)
import Models.Message exposing (..)
import Router exposing (Route(..))


type alias Model m =
    { m
        | messages : List Message
    }



-- STYLE


avatarStyle : List ( String, String )
avatarStyle =
    [ ( "border-radius", "50%" )
    , ( "width", "32px" )
    , ( "height", "32px" )
    ]



-- VIEW


view : Model m -> Html Msg
view { messages } =
    let
        render message =
            MediaObject.media
                [ MediaObject.left
                    [ p [ Attribute.image, class "is-32x32" ]
                        [ img [ style avatarStyle, src message.creator.avatar ] [] ]
                    ]
                , MediaObject.content
                    [ div [ Attribute.content, navigateTo (MessageDetail message.id) ]
                        [ p []
                            [ text message.title ]
                        ]
                    ]
                ]
    in
        div []
            (List.map render messages)
