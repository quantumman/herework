module Component.Nav exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Message exposing (Msg)
import ViewModels as VM exposing (..)


defaultItemView : VM.Item -> ItemView
defaultItemView item =
    { selected = item.selected
    , view =
        a item.attributes
            [ text item.title ]
    }


toView : ItemView -> Html Msg
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


horizontalNav : List VM.Item -> Html Msg
horizontalNav items =
    horizontalNav' <| List.map defaultItemView items


horizontalNav' : List ItemView -> Html Msg
horizontalNav' itemViews =
    nav [ class "aui-navgroup aui-navgroup-horizontal" ]
        [ div [ class "aui-navgroup-inner" ]
            [ div [ class "aui-navgroup-primary" ]
                [ ul [ class "aui-nav" ]
                    (List.map toView itemViews)
                ]
            ]
        ]


verticalNav : List (NavItemGroup VM.Item) -> Html Msg
verticalNav groups =
    let
        itemViewGroup group =
            { items = List.map defaultItemView group.items
            , header = group.header
            }
    in
        verticalNav' <| List.map itemViewGroup groups


verticalNav' : List (NavItemGroup ItemView) -> Html Msg
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
