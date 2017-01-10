module Error.View.Error exposing (..)

import Error.Model as Error exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Msg as App exposing (..)


-- Style


overlay : List ( String, String )
overlay =
    [ ( "position", "fixed" )
    , ( "top", "0" )
    , ( "bottom", "0" )
    , ( "left", "0" )
    , ( "right", "0" )
    , ( "background", "rgba(0,0,0,.1)" )
    , ( "transition", "opacity 500ms" )
    , ( "visibility", "visible" )
    , ( "opacity", "1" )
    , ( "zIndex", "9999" )
    ]


modal : List ( String, String )
modal =
    [ ( "width", "80%" )
    , ( "position", "absolute" )
    , ( "top", "0" )
    , ( "bottom", "0" )
    , ( "left", "0" )
    , ( "right", "0" )
    , ( "height", "5em" )
    , ( "margin", "auto" )
    ]



-- VIEW


view : Error.Model -> Html App.Msg
view model =
    case model.error of
        Just msg ->
            div [ style overlay, class "message is-danger" ]
                [ div [ class "message-header" ]
                    [ text "Something Wrong!" ]
                , div
                    [ style modal, class "message-body" ]
                    [ text msg ]
                ]

        Nothing ->
            div [] []
