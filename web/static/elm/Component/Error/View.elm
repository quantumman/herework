module Component.Error.View exposing (..)

import Aui.Messages exposing (..)
import Component.Error.Message exposing (..)
import Component.Error.Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)


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


view : Model -> Html Msg
view model =
    case model.error of
        Just msg ->
            div [ style overlay ]
                [ div [ style modal ]
                    [ closableMessage error
                        Close
                        [ text "Something Wrong!" ]
                        [ text msg ]
                    ]
                ]

        Nothing ->
            div [] []
