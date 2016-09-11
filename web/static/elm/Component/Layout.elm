module Component.Layout exposing (group, item)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)


type alias Item msg =
    { item : Html msg }


group : List (Item msg) -> Html msg
group items =
    div [ class "aui-group" ]
        <| (List.map .item items)


item : List (Html msg) -> Item msg
item content =
    Item
        <| div [ class "aui-item" ] content
