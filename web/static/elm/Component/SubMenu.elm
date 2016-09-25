module Component.SubMenu exposing (..)

import Component.Nav exposing (verticalNav)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)
import Models exposing (..)
import Router as Router exposing (..)


-- MODEL


type alias Model m =
    { m
        | router : Router.Model
        , messages : List Message
    }



-- VIEW


view : Model m -> Html Msg
view model =
    let
        items =
            case model.router.route of
                Messages ->
                    [ makeNavItemGroup "MESSAGES" model.messages ]

                other ->
                    []
    in
        verticalNav items


makeNavItemGroup : String -> List Message -> NavItemGroup Item
makeNavItemGroup label messages =
    { items = List.map makeItem messages
    , header = (Just label)
    }


makeItem : Message -> Item
makeItem { title, url } =
    { title = title
    , selected = False
    , attributes = [ onClick (Fetch url), href "#" ]
    }
