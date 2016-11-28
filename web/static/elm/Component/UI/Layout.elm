module Component.UI.Layout exposing (group, item)

import Html exposing (..)
import Html.Attributes exposing (..)


type alias Item msg =
    { item : Html msg }


group : List (Item msg) -> Html msg
group items =
    div [ class "aui-group" ]
        <| (List.map .item items)


item : List (Attribute msg) -> List (Html msg) -> Item msg
item attributes content =
    Item
        <| div (attributes ++ [ class "aui-item" ]) content
