module Message.View.Avatar exposing (..)

import View.UI.Attribute as Attribute exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Models.User exposing (User)


avatar : Int -> User -> Html msg
avatar size creator =
    let
        size_ =
            toString size

        figureSize =
            "is-" ++ size_ ++ "x" ++ size_

        imgStyle =
            [ ( "border-radius", "50%" )
            , ( "width", size_ ++ "px" )
            , ( "height", size_ ++ "px" )
            ]
    in
        figure [ levelItem, image, class figureSize ]
            [ img [ src creator.avatar, style imgStyle ] [] ]
