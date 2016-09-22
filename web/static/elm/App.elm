module App exposing (..)

import Aui.Avatars exposing (..)
import Component.Layout exposing (..)
import Component.SubMenu as SubMenu exposing (..)
import Component.VerticalMenu as V exposing (..)
import FontAwesome.Web as Icon exposing (edit)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Models exposing (..)
import Models as App exposing (Model)
import Navigation
import Router as Router exposing (..)


-- MODEL


init : Router.Model -> ( App.Model, Cmd Msg )
init router =
    (initialModel router) ! [ Cmd.none ]



-- UPDATE


type Msg
    = App


update : Msg -> App.Model -> ( App.Model, Cmd Msg )
update message model =
    case message of
        App ->
            model ! [ Cmd.none ]



-- SUBSCRIPTION


subscriptions : App.Model -> Sub Msg
subscriptions model =
    Sub.none



-- STYLE


paneHeaderStyle : Attribute Msg
paneHeaderStyle =
    style
        [ ( "height", "80px" )
        ]


menuWidth : Attribute msg
menuWidth =
    style [ ( "width", "50px" ) ]


subMenuWidth : Attribute Msg
subMenuWidth =
    style [ ( "width", "370px" ) ]


mainContentWitdh : Attribute Msg
mainContentWitdh =
    style [ ( "width", "600px" ) ]



-- VIEW


view : App.Model -> Html Msg
view model =
    div []
        [ group
            [ item [ menuWidth ]
                [ header [ loggedInUser model.user ]
                , V.menu [ menuWidth ]
                    [ menuItem [] Icon.comments_o "Messages"
                    , menuItem [] Icon.tasks "Tasks"
                    , menuItem [] Icon.bar_chart "Activity"
                    ]
                ]
            , item [ subMenuWidth ]
                [ header []
                , SubMenu.view model
                ]
            , item [ mainContentWitdh ]
                [ header []
                , text "C"
                ]
            ]
        ]


header : List (Html Msg) -> Html Msg
header =
    div [ paneHeaderStyle ]


loggedInUser : User -> Html Msg
loggedInUser user =
    let
        align =
            style
                [ ( "margin-left", "9px" )
                , ( "margin-top", "15px" )
                ]
    in
        div [ menuWidth, align ]
            [ avatar config user.avatar
            ]
