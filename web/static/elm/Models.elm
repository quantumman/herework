module Models exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)


type alias Model =
    { router : Router.Model
    , user : User
    , messages : List Message
    }


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
    { title = "test"
    , url = "issues/1"
    }



-- MISC


type alias Url =
    String



-- VIEW MODEL


type alias Item msg =
    { title : String
    , selected : Bool
    , attributes : List (Attribute msg)
    }


type alias ItemView msg =
    { view : Html msg
    , selected : Bool
    }


type alias NavItemGroup a =
    { items : List a
    , header : Maybe String
    }


toNavItemGroup : String -> List { model | title : String } -> NavItemGroup (Item msg)
toNavItemGroup label xs =
    let
        items =
            List.map (\{ title } -> Item title False []) xs
    in
        NavItemGroup items (Just label)
