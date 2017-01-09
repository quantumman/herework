module Message.Model exposing (..)

import Models.Message as Message exposing (Message, initialModel)


type alias Model =
    { message : Message
    }


initialModel : Model
initialModel =
    { message = Message.initialModel
    }
