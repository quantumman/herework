module Component.EditMessage exposing (..)

import Component.Form exposing (bind, bindCheck)
import Component.Buttons as Buttons exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)
import Models exposing (..)


-- MODEL


type alias Model m =
    { m
        | newMessage : Message
    }


on : (Message -> Message) -> Model m -> Model m
on updater model =
    { model | newMessage = updater model.newMessage }



-- VIEW


view : Model m -> Html Msg
view model =
    div []
        [ Html.form []
            [ div []
                [ textarea [ rows 1 ] []
                ]
            , div []
                [ textarea [] []
                ]
            ]
        , Buttons.button primary
            (AddMessage model.newMessage)
            [ text "Add" ]
        ]
