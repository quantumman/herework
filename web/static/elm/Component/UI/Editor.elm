module Component.UI.Editor exposing (..)

import Aui.Buttons exposing (buttonGroup)
import Aui.Tabs as Tabs exposing (..)
import Aui.Toolbar as Toolbar exposing (..)
import Component.Infrastructures.DOM as DOM exposing (..)
import Component.Infrastructures.Form as Form exposing (..)
import Component.UI.Buttons as Buttons exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Markdown as Markdown exposing (..)


-- MODEL


type alias Model =
    { content : String
    , selectionStart : Int
    , selectionEnd : Int
    , tabs : Tabs.Model TabItemId
    }


type TabItemId
    = Edit
    | Preview


init : String -> ( Model, Cmd Msg )
init content =
    { initialModel | content = content } ! []


initialModel : Model
initialModel =
    { content = ""
    , selectionStart = 0
    , selectionEnd = 0
    , tabs = Tabs.modelWithActive Edit
    }


content : Model -> String -> Model
content model value =
    { model | content = value }



-- UPDATE


type Msg
    = NoOp
      -- Buttons
    | Bold
    | Italic
    | Quote
    | Underline
    | H2
    | H3
    | Image
    | Link
    | Paragraph
    | NumericList
    | List
    | Line
    | Indent
    | Deindent
      -- Child component
    | Bind (Form.Msg Model)
    | Tabs (Tabs.Msg TabItemId)
      -- Others
    | Cursor DOM.SelectionRange


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        NoOp ->
            model ! []

        Bold ->
            model ! []

        Italic ->
            model ! []

        Quote ->
            model ! []

        Underline ->
            model ! []

        H2 ->
            model ! []

        H3 ->
            model ! []

        Image ->
            model ! []

        Link ->
            model ! []

        Paragraph ->
            model ! []

        NumericList ->
            model ! []

        List ->
            model ! []

        Line ->
            model ! []

        Indent ->
            model ! []

        Deindent ->
            model ! []

        Tabs msg ->
            let
                tabs =
                    Tabs.update msg model.tabs
            in
                { model | tabs = tabs } ! []

        Bind msg ->
            let
                ( newModel, command ) =
                    Form.update msg model
            in
                newModel ! [ Cmd.map Bind command ]

        Cursor range ->
            { model
                | selectionStart = range.start
                , selectionEnd = range.end
            }
                ! []



-- VIEW


view : Model -> Html Msg
view model =
    let
        onBlur =
            on "blur" (DOM.selectionRange Cursor)

        onClick =
            on "click" (DOM.selectionRange Cursor)

        headers =
            [ item Edit "Edit"
            , item Preview "Preview"
            ]

        container =
            style
                [ ( "width", "98%" )
                , ( "height", "7em" )
                ]

        textareaStyle =
            style
                [ ( "borderRadius", "5px" )
                , ( "borderColor", "#ddd" )
                , ( "width", "100%" )
                , ( "height", "100%" )
                , ( "resize", "vertical" )
                ]

        editor itemId =
            case itemId of
                Edit ->
                    Html.form [ class "aui" ]
                        [ toolbar
                        , div [ container ]
                            [ textarea [ textareaStyle, bind content Bind, onBlur, onClick ]
                                [ text model.content ]
                            ]
                        ]

                Preview ->
                    Markdown.toHtml [] model.content
    in
        div []
            [ tabs (Tabs.baseConfig Tabs |> horizontal |> withItems headers)
                editor
                model.tabs
            ]


toolbar : Html Msg
toolbar =
    Toolbar.toolbar
        [ toolbarPrimary
            [ buttonGroup
                [ Buttons.button normal Bold [ text "Bold" ]
                , Buttons.button normal Italic [ text "Italic" ]
                , Buttons.button normal Quote [ text "Quote" ]
                , Buttons.button normal Underline [ text "Underline " ]
                , Buttons.button normal H2 [ text "H2" ]
                , Buttons.button normal H3 [ text "H3" ]
                , Buttons.button normal Image [ text "Image" ]
                , Buttons.button normal Paragraph [ text "Paragraph" ]
                , Buttons.button normal NumericList [ text "NumericList" ]
                , Buttons.button normal List [ text "List" ]
                , Buttons.button normal Line [ text "Line" ]
                , Buttons.button normal Indent [ text "Indent" ]
                , Buttons.button normal Deindent [ text "Deindent" ]
                ]
            ]
        ]
