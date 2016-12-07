module Component.UI.Tabs exposing (tab, tabs, item, size, Size(..), default, boxed, toggle, center, left, right)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- tab configurations


type Style
    = Toggle
    | Boxed
    | Normal


type Size
    = Large
    | Medium
    | Small
    | Default


type Align
    = Left
    | Center
    | Right
    | None


type alias Config =
    { style : Style
    , size : Size
    , align : Align
    }


size_ : Config -> String
size_ config =
    case config.size of
        Large ->
            "is-large"

        Medium ->
            "is-medium"

        Small ->
            "is-small"

        _ ->
            ""


style : Config -> String
style config =
    case config.style of
        Toggle ->
            "is-toggle"

        Boxed ->
            "is-boxed"

        _ ->
            ""


align : Config -> String
align config =
    case config.align of
        Left ->
            "is-left"

        Center ->
            "is-center"

        Right ->
            "is-right"

        _ ->
            ""



-- Commmon


type TabItem msg
    = TabItem (Html msg)


type Tab msg
    = Tab (Html msg)


item : List (Attribute msg) -> List (Html msg) -> TabItem msg
item attrs content =
    TabItem <|
        li attrs
            [ a [] content ]


size : Size -> Config -> Config
size s config =
    { config | size = s }


default : Config
default =
    { style = Normal, size = Default, align = None }


toggle : Config
toggle =
    { style = Toggle, size = Default, align = None }


boxed : Config
boxed =
    { style = Boxed, size = Default, align = None }



-- Multiple tabs


tabs : Config -> List (Tab msg) -> Html msg
tabs config tabs =
    let
        render (Tab item) =
            item
    in
        div [ class "tabs", class (size_ config), class (style config) ]
            (List.map render tabs)


center : List (TabItem msg) -> Tab msg
center items =
    tabGroup Center items


left : List (TabItem msg) -> Tab msg
left items =
    tabGroup Left items


right : List (TabItem msg) -> Tab msg
right items =
    tabGroup Right items


tabGroup : Align -> List (TabItem msg) -> Tab msg
tabGroup a items =
    let
        render (TabItem item) =
            item

        align a =
            case a of
                Left ->
                    "is-left"

                Center ->
                    "is-center"

                Right ->
                    "is-right"

                _ ->
                    ""
    in
        Tab <|
            ul [ class (align a) ]
                (List.map render items)



-- Single tab


tab : Config -> List (TabItem msg) -> Html msg
tab config items =
    let
        render (TabItem item) =
            item
    in
        div [ class "tabs", class (align config), class (size_ config), class (style config) ]
            [ ul [ class (align config) ]
                (List.map render items)
            ]
