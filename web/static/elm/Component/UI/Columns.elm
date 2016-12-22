module Component.UI.Columns exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- Config


type Mode
    = Mobile
    | Desktop
    | Multiline
    | Gapless


mode : Mode -> Attribute msg
mode m =
    class <|
        case m of
            Mobile ->
                "is-mobile"

            Desktop ->
                "is-desktop"

            Multiline ->
                "is-multiline"

            Gapless ->
                "is-gapless"


type Size
    = ThreeQuaters
    | TwoThirds
    | Half
    | OneThird
    | OneQuarter
    | Two
    | Three
    | Four
    | Five
    | Six
    | Seven
    | Eight
    | Nine
    | Ten
    | Eleven
    | Offset Size


size : Size -> Attribute msg
size s =
    let
        suffix x =
            case x of
                ThreeQuaters ->
                    "three-quaters"

                TwoThirds ->
                    "two-thirds"

                Half ->
                    "half"

                OneThird ->
                    "one-third"

                OneQuarter ->
                    "quarter"

                Two ->
                    "2"

                Three ->
                    "3"

                Four ->
                    "4"

                Five ->
                    "5"

                Six ->
                    "6"

                Seven ->
                    "7"

                Eight ->
                    "8"

                Nine ->
                    "9"

                Ten ->
                    "10"

                Eleven ->
                    "11"

                Offset s ->
                    "offset-" ++ (suffix s)
    in
        class <| "is-" ++ (suffix s)



-- View


type Column msg
    = Column (Html msg)


columns : List Mode -> List (Column msg) -> Html msg
columns modes cs =
    let
        modeClasses =
            List.map mode modes

        render (Column column) =
            column
    in
        div ([ class "columns" ] ++ modeClasses)
            (List.map render cs)


column : List Size -> List (Html msg) -> Column msg
column sizes content =
    let
        sizeClasses =
            List.map size sizes
    in
        Column <|
            div ([ class "column" ] ++ sizeClasses)
                content
