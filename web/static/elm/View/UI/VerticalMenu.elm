module View.UI.VerticalMenu exposing (menuItem, menu)

import FontAwesome.Web exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)


type alias Icon msg =
    Html msg


type alias MenuItem msg =
    { item : Html msg }


menuItem : List (Attribute msg) -> Icon msg -> String -> MenuItem msg
menuItem attributes icon label =
    let
        css =
            style
                [ ( "fontSize", "32px" )
                , ( "textAlign", "center" )
                ]

        iconStyle =
            style
                [ ( "height", "60px" )
                , ( "margin", "0 auto" )
                ]

        helpText =
            style
                [ ( "fontSize", "10px" )
                , ( "textAlign", "center" )
                ]
    in
        { item =
            li (iconStyle :: attributes)
                [ a [ href "#" ]
                    [ div [ css ] [ icon ]
                    , div [ helpText ] [ text label ]
                    ]
                ]
        }


menu : List (Attribute msg) -> List (MenuItem msg) -> Html msg
menu attributes items =
    let
        css =
            style
                [ ( "listStyleType", "none" )
                , ( "margin", "0" )
                , ( "padding", "0" )
                ]
    in
        ul (css :: attributes) <| List.map .item items
