module Message.Model exposing (..)

import Model.Message as Message exposing (Message, initialModel)


type alias Model =
    { message : Message
    , isEditing : Bool
    }


initialModel : Model
initialModel =
    { message = Message.initialModel
    , isEditing = False
    }
