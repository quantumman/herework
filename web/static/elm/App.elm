module App exposing (..)

import Aui.Avatars exposing (..)
import Commands as Commands exposing (..)
import Component.CommentList as CL exposing (..)
import Component.Error.View as Error exposing (..)
import Component.Layout exposing (..)
import Component.SubMenu as SubMenu exposing (..)
import Component.VerticalMenu as V exposing (..)
import FontAwesome.Web as Icon exposing (edit)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)
import Models as App exposing (Model)
import Models exposing (..)
import Navigation
import Router as Router exposing (..)
import Style exposing (..)


-- MODEL


init : Router.Model -> ( App.Model, Cmd Msg )
init router =
    (initialModel router) ! [ Commands.initApp "/api/app" ]



-- SUBSCRIPTION


subscriptions : App.Model -> Sub Msg
subscriptions model =
    Sub.none



-- STYLE


paneHeaderStyle : List Style
paneHeaderStyle =
    [ Style.height (px 80)
    ]


menuStyle : List Style
menuStyle =
    [ Style.width (px 50)
    ]


subMenuWidth : List Style
subMenuWidth =
    [ Style.width (px 370)
    ]


mainContentWitdh : List Style
mainContentWitdh =
    [ Style.width (px 600)
    ]



-- VIEW


view : App.Model -> Html Msg
view model =
    div []
        [ Html.map HandleError <| Error.view model
        , group
            [ item [ style menuStyle ]
                [ header [ loggedInUser model.user ]
                , V.menu [ style menuStyle ]
                    [ menuItem [ onClick FetchMessages ] Icon.comments_o "Messages"
                    , menuItem [] Icon.tasks "Tasks"
                    , menuItem [] Icon.bar_chart "Activity"
                    ]
                ]
            , item [ style subMenuWidth ]
                [ header []
                , SubMenu.view model
                ]
            , item [ style mainContentWitdh ]
                [ header []
                , CL.view model
                ]
            ]
        ]


header : List (Html Msg) -> Html Msg
header =
    div [ style paneHeaderStyle ]


loggedInUser : User -> Html Msg
loggedInUser user =
    let
        align =
            [ marginLeft (px 9)
            , marginTop (px 15)
            ]
    in
        div [ style (menuStyle ++ align) ]
            [ avatar config user.avatar
            ]
