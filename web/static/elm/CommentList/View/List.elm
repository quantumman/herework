module CommentList.View.List exposing (..)

import CommentList.Model as CommentList exposing (..)
import Component.Infrastructures.DateTime as DateTime exposing (Model, view)
import Component.UI.Attribute as Attribute exposing (..)
import Component.UI.MediaObject as MediaObject exposing (..)
import Date as Date exposing (..)
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
                                [ createdAt comment.created_at now ]
                            ]
                        , text comment.body
                        ]
                    ]
                ]
    in
        div []
            (List.map render model.comments)


createdAt : Date -> DateTime.Model -> Html Msg
createdAt date model =
    Html.map App.Now <| DateTime.view date model
