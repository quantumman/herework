module CommentList.View.List exposing (..)

import CommentList.Model as CommentList exposing (..)
import Component.UI.Attribute as Attribute exposing (..)
import Component.UI.MediaObject as MediaObject exposing (..)
import Date as Date exposing (..)
import DateTime.Model as DateTime exposing (..)
import DateTime.View.DateTime as DateTime exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message as App exposing (Msg)


-- STYLE


avatarStyle : List ( String, String )
avatarStyle =
    [ ( "border-radius", "50%" )
    , ( "width", "32px" )
    , ( "height", "32px" )
    ]



-- VIEW


view : DateTime.Model -> CommentList.Model -> Html App.Msg
view now model =
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
                            [ small []
                                [ strong []
                                    [ text comment.creator.name ]
                                ]
                            , text " "
                            , small []
                                [ DateTime.view comment.created_at now ]
                            ]
                        , text comment.body
                        ]
                    ]
                ]
    in
        div []
            (List.map render model.comments)
