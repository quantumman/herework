module CommentList.Model exposing (..)

import Model.Comment as Comment exposing (Comment)


type alias Model =
    { comments : List Comment
    }


initialModel : Model
initialModel =
    { comments = []
    }
