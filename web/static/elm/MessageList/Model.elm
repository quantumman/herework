module MessageList.Model exposing (..)

import Model.Message as Message exposing (Message, initialModel)


type alias Model =
    { message : Message
    , messages : List Message
    }


initialModel : Model
initialModel =
    { message = Message.initialModel
    , messages = []
    }
