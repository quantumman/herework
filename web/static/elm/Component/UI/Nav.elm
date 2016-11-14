module Component.UI.Nav exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)


type Header msg
    = Header (Html msg)


header : String -> Header msg
header label =
    Header
        <| div [ class "aui-nav-heading" ]
            [ strong [] [ text label ] ]


type Item msg
    = Item (Html msg)


item : List (Attribute msg) -> Bool -> String -> Item msg
item attributes isSelected label =
    Item
        <| li
            [ class
                (if isSelected then
                    "aui-nav-selected"
                 else
                    ""
                )
            ]
            [ a attributes [ text label ]
            ]


vnav : List ( Header msg, List (Item msg) ) -> Html msg
vnav groups =
    let
        renderMenu ( Header header, items ) =
            ul [ class "aui-nav __skate" ]
                (header :: (List.map (\(Item item) -> item) items))
    in
        nav [ class "aui-navgroup aui-navgroup-vertical" ]
            [ div [ class "aui-navgroup-inner" ]
                (List.map (\group -> renderMenu group) groups)
            ]


hnav : List (Item msg) -> Html msg
hnav items =
    nav [ class "aui-navgroup aui-navgroup-horizontal" ]
        [ div [ class "aui-navgroup-inner" ]
            [ div [ class "aui-navgroup-primary" ]
                [ ul [ class "aui-nav" ]
                    (List.map (\(Item item) -> item) items)
                ]
            ]
        ]
