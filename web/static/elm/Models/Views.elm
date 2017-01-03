module Models.Views exposing (..)

import Component.Views.Messages.Form as Form exposing (..)
import Models.Comment as Comment exposing (Comment)
import Models.Message as Message exposing (Message, initialModel)
import Monocle.Lens exposing (Lens)


type alias Model =
    { messages : MessagesView
    }


initialModel : Model
initialModel =
    { messages = initialMessageView
    }


type alias MessagesView =
    { form : Form.Model
    }


initialMessageView : MessagesView
initialMessageView =
    { form = Form.initialModel
    }



-- HELPER


messagesOfViews : Lens Model MessagesView
messagesOfViews =
    let
        get model =
            model.messages

        set messages model =
            { model | messages = messages }
    in
        Lens get set
