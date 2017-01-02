module Models.Views exposing (..)

import Component.Views.Messages.Editor as Editor exposing (..)
import Models.Message as Message exposing (Message, initialModel)
import Models.Comment as Comment exposing (Comment)


type alias Model =
    { messages : MessagesView
    }


initialModel : Model
initialModel =
    { messages = initialMessageView
    }


type alias MessagesView =
    { list : List Message
    , detail : Message
    , edit : Message
    , new : Message
    , comments : List Comment
    , editor : Editor.Model
    }


initialMessageView : MessagesView
initialMessageView =
    { list = []
    , detail = Message.initialModel
    , edit = Message.initialModel
    , new = Message.initialModel
    , comments = []
    , editor = Editor.initialModel
    }
