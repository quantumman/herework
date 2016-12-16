module Component.Views.MessageList exposing (..)

import Component.UI.Attribute as Attribute exposing (..)
import Component.UI.MediaObject as MediaObject exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import HtmlHelpers exposing (..)
import InlineHover exposing (..)
import Message exposing (..)
import Models.Message exposing (..)
import Router exposing (Route(..))


type alias Model m =
    { m
        | messages : List Message
        , selectedMessage : Maybe Message
    }



-- STYLE


avatarStyle : List ( String, String )
avatarStyle =
    [ ( "border-radius", "50%" )
    , ( "width", "32px" )
    , ( "height", "32px" )
    ]


selected : Message -> Model m -> List ( String, String )
selected message { selectedMessage } =
    let
        makeStyle m =
            if m.id == message.id then
                [ ( "background-color", "#00d1b2" )
                , ( "color", "white" )
                ]
            else
                []
    in
        selectedMessage
            |> Maybe.map makeStyle
            |> Maybe.withDefault []


hoverStyle : List ( String, String )
hoverStyle =
    [ ( "color", "#00d1b2" )
    , ( "background-color", "whitesmoke" )
    ]


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


view : Model m -> Html Msg
view model =
    let
        render message =
            hover_ message
                model
                MediaObject.media
                [ navigateTo (MessageDetail message.id)
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


hover_ :
    Message
    -> Model m
    -> (List (Attribute Msg) -> List (Media Msg) -> Html Msg)
    -> List (Attribute Msg)
    -> List (Media Msg)
    -> Html Msg
hover_ message { selectedMessage } tag attrs children =
    let
        hoverOrNot m =
            if message.id == m.id then
                tag attrs children
            else
                hover hoverStyle (\a _ -> tag a children) attrs []
    in
        selectedMessage
            |> Maybe.map hoverOrNot
            |> Maybe.withDefault (tag attrs children)
