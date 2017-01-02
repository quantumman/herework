module Component.Views.Messages.Detail exposing (..)

import Component.Infrastructures.DateTime as DateTime exposing (view)
import Component.UI.Buttons as Buttons exposing (..)
import Component.Views.CommentList as CommentList exposing (..)
import Component.Views.Messages.Layout as Layout exposing (..)
import Date exposing (Date)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)
import Models exposing (..)
import Models.Comment exposing (Comment)
import Models.Message exposing (Message)
import Models.User exposing (User)
import Models.Views as Views exposing (..)
import Router as Router exposing (..)


-- MODEL


type alias Model m =
    { m
        | messageDetail : Maybe Message
        , comments : List Comment
        , user : User
        , now : DateTime.Model
        , views : Views.Model
    }



-- VIEW


view : Model m -> Html Msg
view model =
    let
        render message =
            layout [ text message.title ]
                [ text message.body ]
                [ createdAt message.created_at model.now ]
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
        render model.views.messages.detail


createdAt : Date -> DateTime.Model -> Html Msg
createdAt date model =
    Html.map Now <| DateTime.view date model
