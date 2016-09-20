module Models exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)


type alias User =
    { avatar : String
    }


initialModelUser =
    { avatar = "https://www.gravatar.com/avatar/00000000000000000000000000000000"
    }


type alias Message =
    { title : String
    , url : String
    }


initialModelMessage =
    { title = ""
    , url = "issues/1"
    }



-- VIEW MODEL


type alias Item =
    { title : String
    , url : String
    , selected : Bool
    }


type alias ItemView msg =
    { view : Html msg
    , selected : Bool
    }


type alias NavItemGroup a =
    { items : List a
    , header : Maybe String
    }


toNavItemGroup : String -> List { title : String, url : String } -> NavItemGroup Item
toNavItemGroup label xs =
    let
        items =
            List.map (\{ title, url } -> Item title url False) xs
    in
        NavItemGroup items (Just label)
