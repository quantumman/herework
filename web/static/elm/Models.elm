module Models exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Message exposing (Msg)
import Router as Router exposing (..)


type alias Model =
    { router : Router.Model
    , user : User
    , messages : List Message
    }


initialModel : Router.Model -> Model
initialModel router =
    { router = router
    , user = initialModelUser
    , messages =
        [ initialModelMessage
        , { title = "foobar", url = "messages/1" }
        , { title = "REQUEST: Working with BOT", url = "messages/2" }
        , { title = "QUESTION: How can we make issue ?", url = "messages/3" }
        ]
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
