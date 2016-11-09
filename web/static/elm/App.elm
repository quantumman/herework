module App exposing (..)

import Aui.Avatars exposing (..)
import Commands as Commands exposing (..)
import Component.CommentList as CL exposing (..)
import Component.DateTime as DateTime exposing (init)
import Component.EditMessage as EditMessage exposing (..)
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
    let
        ( _, dateTimeCommand ) =
            DateTime.init
    in
        (initialModel router) ! [ Commands.initApp "/api/app", Cmd.map Now dateTimeCommand ]



-- SUBSCRIPTION


subscriptions : App.Model -> Sub Msg
subscriptions model =
    Sub.none



-- STYLE


paneHeaderHeight : String
paneHeaderHeight =
    px 80


menuWidth : String
menuWidth =
    px 60


subMenuWidth : String
subMenuWidth =
    px 370


mainContentWidth : String
mainContentWidth =
    px 600


paneHeaderStyle : List Style
paneHeaderStyle =
    [ Style.height paneHeaderHeight
    ]


menuStyle : List Style
menuStyle =
    [ Style.width menuWidth
    ]


subMenuStyle : List Style
subMenuStyle =
    [ Style.width subMenuWidth
    ]


mainContentStyle : List Style
mainContentStyle =
    [ Style.width mainContentWidth
    ]


mainContentTitleStyle : List Style
mainContentTitleStyle =
    [ marginTop (px 15)
    ]



-- VIEW


view : App.Model -> Html Msg
view model =
    div []
        [ Html.map HandleError <| Error.view model.error
        , group
            [ item [ style menuStyle ]
                [ header [ loggedInUser model.user ]
                ]
            , item [ style subMenuStyle ]
                []
            , item [ style mainContentStyle ]
                [ header
                    [ h1 [ style mainContentTitleStyle ]
                        [ text model.selectedMessage.title
                        ]
                    ]
                ]
            ]
        , group
            [ item [ style menuStyle ]
                [ V.menu [ style menuStyle ]
                    [ menuItem [ onClick FetchMessages ] Icon.comments_o "Messages"
                    , menuItem [] Icon.tasks "Tasks"
                    , menuItem [] Icon.bar_chart "Activity"
                    ]
                ]
            , item []
                [ group
                    [ item [ style subMenuStyle ]
                        [ scrollable subMenuWidth
                            [ SubMenu.view model ]
                        ]
                    , item [ style mainContentStyle ]
                        [ scrollable mainContentWidth
                            [ case model.router.route of
                                Router.Messages ->
                                    CL.view model

                                Router.NewMessage ->
                                    EditMessage.view model

                                other ->
                                    div [] []
                            ]
                        ]
                    ]
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


scrollable : String -> List (Html Msg) -> Html Msg
scrollable w html =
    let
        scroll =
            [ position absolute
            , top paneHeaderHeight
            , bottom "0"
            , Style.width w
            , overflow "auto"
            ]
    in
        div [ style scroll ] html
