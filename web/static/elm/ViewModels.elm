module ViewModels exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Message exposing (Msg)
import Models exposing (..)


-- VIEW MODEL


type alias Item =
    { title : String
    , selected : Bool
    , attributes : List (Attribute Msg)
    }


type alias ItemView =
    { view : Html Msg
    , selected : Bool
    }


type alias NavItemGroup a =
    { items : List a
    , header : Maybe String
    }


toNavItemGroup : String -> List { model | title : String } -> NavItemGroup Item
toNavItemGroup label xs =
    let
        items =
            List.map (\{ title } -> Item title False []) xs
    in
        NavItemGroup items (Just label)
