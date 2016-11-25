module Component.UI.Editor exposing (..)

import Aui.Buttons exposing (buttonGroup)
import Aui.Tabs as Tabs exposing (..)
import Aui.Toolbar as Toolbar exposing (..)
import Component.Infrastructures.DOM as DOM exposing (..)
import Component.Infrastructures.Form as Form exposing (..)
import Component.UI.Buttons as Buttons exposing (..)
import FontAwesome.Web as Icon exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Markdown as Markdown exposing (..)


-- MODEL


type alias Model =
    { content : String
    , textarea : DOM.TextArea
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
    , textarea =
        { selectionStart = 0
        , selectionEnd = 0
        , rows = 0
        , cols = 0
        , style =
            { height = "8em"
            }
        }
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
    | Outindent
      -- Child component
    | Bind (Form.Msg Model)
    | Tabs (Tabs.Msg TabItemId)
      -- Others
    | TextArea DOM.TextArea


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

        Outindent ->
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

        TextArea textarea ->
            { model | textarea = textarea } ! []



-- VIEW


view : Model -> Html Msg
view model =
    let
        headers =
            [ item Edit "Edit"
            , item Preview "Preview"
            ]

        tabView itemId =
            case itemId of
                Edit ->
                    editor model

                Preview ->
                    preview model
    in
        div []
            [ tabs (Tabs.baseConfig Tabs |> horizontal |> withItems headers)
                tabView
                model.tabs
            ]


textareaStyle : Model -> List ( String, String )
textareaStyle model =
    [ ( "borderRadius", "5px" )
    , ( "borderColor", "#ddd" )
    , ( "height", model.textarea.style.height )
    , ( "width", "100%" )
    , ( "resize", "vertical" )
    ]


container : List ( String, String )
container =
    [ ( "width", "98%" )
    , ( "height", "7em" )
    ]


editor : Model -> Html Msg
editor model =
    let
        onBlur =
            on "blur" (DOM.textarea TextArea)

        onClick =
            on "click" (DOM.textarea TextArea)
    in
        Html.form [ class "aui" ]
            [ toolbar
            , div [] [ text model.textarea.style.height ]
            , div [ style container ]
                [ Html.textarea
                    [ style <| textareaStyle model
                    , bind content Bind
                    , onBlur
                    , onClick
                    ]
                    [ text model.content ]
                ]
            ]


preview : Model -> Html Msg
preview model =
    div [ style container ] [ Markdown.toHtml [] model.content ]


toolbar : Html Msg
toolbar =
    let
        icon s =
            i [ class ("fa fa-" ++ s) ] []
    in
        Toolbar.toolbar
            [ toolbarPrimary
                [ buttonGroup
                    [ Buttons.button normal Bold [ icon "bold" ]
                    , Buttons.button normal Italic [ icon "italic" ]
                    , Buttons.button normal Quote [ icon "quote-right" ]
                    , Buttons.button normal Underline [ icon "underline" ]
                    , Buttons.button normal H2 [ icon "header" ]
                    , Buttons.button normal H3 [ icon "header" ]
                    , Buttons.button normal Image [ Icon.image ]
                    , Buttons.button normal Paragraph [ icon "paragraph" ]
                    , Buttons.button normal NumericList [ icon "list-ol" ]
                    , Buttons.button normal List [ icon "list-ul" ]
                    , Buttons.button normal Line [ icon "ellipsis-h" ]
                    , Buttons.button normal Indent [ icon "indent" ]
                    , Buttons.button normal Outindent [ icon "outdent" ]
                    ]
                ]
            ]
