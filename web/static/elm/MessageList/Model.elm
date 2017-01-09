module MessageList.Model exposing (..)

import Models.Message as Message exposing (Message, initialModel)


type alias Model =
    { message : Message
    , messages : List Message
    }


initialModel : Model
initialModel =
    { message = Message.initialModel
    , messages = []
    }
