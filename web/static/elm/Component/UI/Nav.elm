module Component.UI.Nav exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Message exposing (Msg)


type Header
    = Header (Html Msg)


header : String -> Header
header label =
    Header
        <| div [ class "aui-nav-heading" ]
            [ strong [] [ text label ] ]


type Item
    = Item (Html Msg)


item : List (Attribute Msg) -> Bool -> String -> Item
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


vnav : List ( Header, List Item ) -> Html Msg
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


hnav : List Item -> Html Msg
hnav items =
    nav [ class "aui-navgroup aui-navgroup-horizontal" ]
        [ div [ class "aui-navgroup-inner" ]
            [ div [ class "aui-navgroup-primary" ]
                [ ul [ class "aui-nav" ]
                    (List.map (\(Item item) -> item) items)
                ]
            ]
        ]
