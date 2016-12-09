module Component.UI.Attribute exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


active : Attribute msg
active =
    class "is-active"


level : Attribute msg
level =
    class "level"


levelLeft : Attribute msg
levelLeft =
    class "level-left"


levelRight : Attribute msg
levelRight =
    class "level-right"


levelItem : Attribute msg
levelItem =
    class "level-item"


content : Attribute msg
content =
    class "content"


image : Attribute msg
image =
    class "image"


box : Attribute msg
box =
    class "box"
