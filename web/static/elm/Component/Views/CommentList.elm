module Component.Views.CommentList exposing (..)

import Component.Infrastructures.DateTime as DateTime exposing (view, Model)
import Component.UI.Attribute as Attribute exposing (..)
import Component.UI.MediaObject as MediaObject exposing (..)
import Date exposing (Date)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)
import Models.Comment exposing (Comment)
import Models.User exposing (User)


type alias Model m =
    { m
        | comments : List Comment
        , now : DateTime.Model
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
view model =
    let
        render comment =
            MediaObject.media []
                [ MediaObject.left
                    [ p [ Attribute.image, class "is-32x32" ]
                        [ img [ style avatarStyle, src comment.creator.avatar ] [] ]
                    ]
                , MediaObject.content []
                    [ div [ Attribute.content ]
                        [ p []
                            [ text comment.body ]
                        ]
                    ]
                ]
    in
        div []
            (List.map render model.comments)
