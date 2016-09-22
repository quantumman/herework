module Component.Nav exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Models exposing (..)


defaultItemView : Item msg -> ItemView msg
defaultItemView item =
    { selected = item.selected
    , view =
        a [ href item.url ]
            [ text item.title ]
    }


toView : ItemView msg -> Html msg
toView item =
    li
        [ class
            (if item.selected then
                "aui-nav-selected"
             else
                ""
            )
        ]
        [ item.view ]


horizontalNav : List (Item msg) -> Html msg
horizontalNav items =
    horizontalNav' <| List.map defaultItemView items


horizontalNav' : List (ItemView msg) -> Html msg
horizontalNav' itemViews =
    nav [ class "aui-navgroup aui-navgroup-horizontal" ]
        [ div [ class "aui-navgroup-inner" ]
            [ div [ class "aui-navgroup-primary" ]
                [ ul [ class "aui-nav" ]
                    (List.map toView itemViews)
                ]
            ]
        ]


verticalNav : List (NavItemGroup (Item msg)) -> Html msg
verticalNav groups =
    let
        itemViewGroup group =
            { items = List.map defaultItemView group.items
            , header = group.header
            }
    in
        verticalNav' <| List.map itemViewGroup groups


verticalNav' : List (NavItemGroup (ItemView msg)) -> Html msg
verticalNav' groups =
    let
        header =
            Maybe.map
                (\h ->
                    div [ class "aui-nav-heading" ]
                        [ strong [] [ text h ] ]
                )

        view group =
            ul [ class "aui-nav __skate" ]
                ([ Maybe.withDefault (div [] []) <| header group.header
                 ]
                    ++ (List.map toView group.items)
                )
    in
        nav [ class "aui-navgroup aui-navgroup-vertical" ]
            [ div [ class "aui-navgroup-inner" ]
                (List.map view groups)
            ]
