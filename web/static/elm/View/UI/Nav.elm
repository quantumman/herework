module View.UI.Nav exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


type Item msg
    = Item (Html msg)


type Group msg
    = Group (Html msg)


nav : List (Attribute msg) -> List (Group msg) -> Html msg
nav attrs groups =
    let
        render (Group group) =
            group
    in
        Html.nav (class "nav" :: attrs)
            (List.map render groups)


group : String -> List (Item msg) -> Group msg
group pos items =
    let
        render (Item item) =
            item
    in
        Group <|
            div [ class pos ]
                (List.map render items)


left : List (Item msg) -> Group msg
left items =
    group "nav-left" items


center : List (Item msg) -> Group msg
center items =
    group "nav-center" items


right : List (Item msg) -> Group msg
right items =
    group "nav-right" items


item : List (Attribute msg) -> List (Html msg) -> Item msg
item attrs content =
    Item <|
        a ([ href "#", class "nav-item" ] ++ attrs)
            content


type Tab msg
    = Tab (Html msg)


tabs : List (Tab msg) -> Html msg
tabs items =
    let
        render (Tab item) =
            item
    in
        Html.nav [ class "nav has-shadow" ]
            [ div [ class "container" ]
                [ div [ class "nav-center" ]
                    (List.map render items)
                ]
            ]


tab : List (Attribute msg) -> List (Html msg) -> Tab msg
tab attrs content =
    Tab <|
        a ([ class "nav-item is-tab" ] ++ attrs)
            content
