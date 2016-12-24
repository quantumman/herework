module Component.Views.Messages.Detail exposing (..)

import Component.Infrastructures.DateTime as DateTime exposing (view)
import Component.UI.Buttons as Buttons exposing (..)
import Component.Views.CommentList as CommentList exposing (..)
import Component.Views.Messages.Layout as Layout exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)
import Models exposing (..)
import Models.Comment exposing (Comment)
import Models.Message exposing (Message)
import Models.User exposing (User)
import Router as Router exposing (..)


-- MODEL


type alias Model m =
    { m
        | messageDetail : Maybe Message
        , comments : List Comment
        , user : User
        , now : DateTime.Model
    }



-- VIEW


view : Model m -> Html Msg
view model =
    let
        render message =
            layout [ text message.title ]
                [ text message.body ]
                [ Layout.createdAt message.created_at model.now ]
                [ avatar 24 message.creator ]
                [ Buttons.button (Buttons.default |> Buttons.small |> outlined |> primary)
                    (NavigateTo (Router.Messages <| Edit message.id))
                    [ span [ class "icon is-small" ]
                        [ i [ class "fa fa-pencil" ] [] ]
                    , span [] [ text "EDIT" ]
                    ]
                ]
                [ hr [] []
                , CommentList.view model
                ]
    in
        model.messageDetail
            |> Maybe.map render
            |> Maybe.withDefault (div [] [])
