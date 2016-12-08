module App exposing (..)

import Aui.Avatars exposing (..)
import Commands as Commands exposing (..)
import Component.Error.View as Error exposing (..)
import Component.Infrastructures.DateTime as DateTime exposing (init)
import Component.UI.Attribute exposing (..)
import Component.UI.Layout as Layout exposing (..)
import Component.UI.Menu as Menu exposing (..)
import Component.UI.Tabs as Tabs exposing (..)
import Component.UI.VerticalMenu as V exposing (..)
import Component.UI.Buttons as Buttons exposing (..)
import Component.Views.CommentList as CL exposing (..)
import Component.Views.EditMessage as EditMessage exposing (..)
import Component.Views.SubMenu as SubMenu exposing (..)
import FontAwesome.Web as Icon exposing (edit)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Message exposing (..)
import Models as App exposing (Model)
import Models exposing (..)
import Models.User exposing (User)
import Navigation
import Router as Router exposing (..)


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
    "80px"


menuWidth : String
menuWidth =
    "60px"


subMenuWidth : String
subMenuWidth =
    "370px"


mainContentWidth : String
mainContentWidth =
    "600px"


paneHeaderStyle : List ( String, String )
paneHeaderStyle =
    [ ( "height", paneHeaderHeight )
    ]


menuStyle : List ( String, String )
menuStyle =
    [ ( "width", menuWidth )
    ]


subMenuStyle : List ( String, String )
subMenuStyle =
    [ ( "width", subMenuWidth )
    ]


mainContentStyle : List ( String, String )
mainContentStyle =
    [ ( "width", mainContentWidth )
    ]


mainContentTitleStyle : List ( String, String )
mainContentTitleStyle =
    [ ( "marginTop", "15px" )
    ]



-- VIEW


view : App.Model -> Html Msg
view model =
    div []
        [ Html.map HandleError <| Error.view model.error
        , div [] [ Buttons.button primary ClickAddMessage [ text "Button" ] ]
        , div [] [ Buttons.button (\x -> outlined x |> primary) ClickAddMessage [ text "Button!" ] ]
        , div [] [ Buttons.button (\x -> outlined x |> warning) ClickAddMessage [ text "Button!" ] ]
        , div [] [ Buttons.button (\x -> primary x |> loading) ClickAddMessage [ text "Button!" ] ]
        , Tabs.tabs Tabs.boxed
            [ Tabs.center
                [ Tabs.item [] [ text "TabA" ]
                , Tabs.item [ active ] [ text "TabB" ]
                ]
            , Tabs.right
                [ Tabs.item [] [ text "foobar" ]
                , Tabs.item [] [ text "Hoge" ]
                ]
            ]
        , Tabs.tab (Tabs.default |> Tabs.size Tabs.Small)
            [ Tabs.item [] [ text "TabA" ]
            , Tabs.item [] [ text "TabB" ]
            ]
        , Menu.menu
            [ Menu.menuItem "box"
                [ Menu.item [] [ text "All" ]
                , Menu.item [] [ text "Important" ]
                , Menu.item [] [ text "Your messages" ]
                ]
            , Menu.menuItem "tags"
                [ Menu.item [] [ text "Bugs" ]
                , Menu.item [] [ text "Schedule" ]
                , Menu.item [] [ text "random" ]
                ]
            ]
          -- , group
          --     [ Layout.item [ style menuStyle ]
          --         [ header [ loggedInUser model.user ]
          --         ]
          --     , Layout.item [ style subMenuStyle ]
          --         []
          --     , Layout.item [ style mainContentStyle ]
          --         [ header
          --             [ h1 [ style mainContentTitleStyle ]
          --                 [ text (model.selectedMessage |> Maybe.map (.title) |> Maybe.withDefault "")
          --                 ]
          --             ]
          --         ]
          --     ]
          -- , group
          --     [ Layout.item [ style menuStyle ]
          --         [ V.menu [ style menuStyle ]
          --             [ V.menuItem [ onClick ListMessages ] Icon.comments_o "Messages"
          --             , V.menuItem [] Icon.tasks "Tasks"
          --             , V.menuItem [] Icon.bar_chart "Activity"
          --             ]
          --         ]
          --     , Layout.item []
          --         [ group
          --             [ Layout.item [ style subMenuStyle ]
          --                 [ scrollable subMenuWidth
          --                     [ SubMenu.view model ]
          --                 ]
          --             , Layout.item [ style mainContentStyle ]
          --                 [ scrollable mainContentWidth
          --                     [ case model.router.route of
          --                         Router.Messages ->
          --                             CL.view model
          --                         Router.NewMessage ->
          --                             EditMessage.view model
          --                         other ->
          --                             div [] []
          --                     ]
          --                 ]
          --             ]
          --         ]
          --     ]
        ]


header : List (Html Msg) -> Html Msg
header =
    div [ style paneHeaderStyle ]


loggedInUser : User -> Html Msg
loggedInUser user =
    let
        align =
            [ ( "marginLeft", "9px" )
            , ( "marginTop", "15px" )
            ]
    in
        div [ style (menuStyle ++ align) ]
            [ avatar config user.avatar
            ]


scrollable : String -> List (Html Msg) -> Html Msg
scrollable w html =
    let
        scroll =
            [ ( "position", "absolute" )
            , ( "top", paneHeaderHeight )
            , ( "bottom", "0" )
            , ( "width", w )
            , ( "overflow", "auto" )
            ]
    in
        div [ style scroll ] html
