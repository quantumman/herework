module Component.SubMenu exposing (..)

import Component.Nav as Nav exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)
import Models exposing (..)
import Router as Router exposing (..)
import ViewModels as VM exposing (..)


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
                    messages model.messages

                other ->
                    []
    in
        Nav.vnav items


makeNavItemGroup : String -> List Message -> NavItemGroup VM.Item
makeNavItemGroup label messages =
    { items = List.map makeItem messages
    , header = (Just label)
    }


makeItem : Message -> VM.Item
makeItem { title, url } =
    { title = title
    , selected = False
    , attributes = [ onClick FetchMessages, href "#" ]
    }


messages : List Message -> List ( Nav.Header, List Nav.Item )
messages ms =
    let
        toItem message =
            Nav.item [ onClick FetchMessages, href "#" ] False message.title
    in
        [ ( Nav.header "MESSAGES", List.map toItem ms ) ]
