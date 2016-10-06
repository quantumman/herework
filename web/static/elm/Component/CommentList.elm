module Component.CommentList exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)
import Models exposing (Comment)


type alias Model m =
    { m
        | comments : List Comment
    }



-- VIEW


view : Model m -> Html Msg
view model =
    div []
        [ ul []
            (model.comments
                |> List.map comment
                |> List.map (\c -> li [] [ c ])
            )
        ]


comment : Comment -> Html Msg
comment model =
    div []
        [ text model.body ]
