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
    { list : List Message
    , entity : Message
    , comments : List Comment
    , form : Form.Model
    }


initialMessageView : MessagesView
initialMessageView =
    { list = []
    , entity = Message.initialModel
    , comments = []
    , form = Form.initialModel
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
