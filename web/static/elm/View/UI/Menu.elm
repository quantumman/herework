module View.UI.Menu exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type MenuItem m
    = MenuItem (List (Html m))


type Item m
    = Item (Html m)
    | List (List (Html m))


menu : List (MenuItem msg) -> Html msg
menu content =
    let
        render (MenuItem items) =
            items
    in
        aside [ class "menu" ] <| List.concatMap render content


menuItem : String -> List (Item m) -> MenuItem m
menuItem s items =
    MenuItem <|
        [ p [ class "menu-label" ] [ text s ]
        , ul [ class "menu-list" ] (List.concatMap renderItem items)
        ]


list : String -> List (Item m) -> Item m
list s items =
    List <|
        [ p [ class "menu-label" ] [ text s ]
        , ul [ class "menu-list" ] (List.concatMap renderItem items)
        ]


item : List (Attribute msg) -> List (Html msg) -> Item msg
item attrs content =
    Item <|
        li attrs
            [ a [ href "#" ] content ]


renderItem : Item m -> List (Html m)
renderItem item =
    case item of
        Item m ->
            [ m ]

        List m ->
            m
