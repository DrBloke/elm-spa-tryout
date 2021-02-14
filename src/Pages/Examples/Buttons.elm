module Pages.Examples.Buttons exposing (Model, Msg, Params, page)

import Html exposing (button, div, text)
import Html.Events exposing (onClick)
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)


page : Page Params Model Msg
page =
    Page.sandbox
        { init = init
        , update = update
        , view = view
        }



-- INIT


type alias Params =
    ()


type alias Model =
    Int


init : Url Params -> Model
init { params } =
    1



-- UPDATE


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Examples - Buttons"
    , body =
        [ div []
            [ button [ onClick Decrement ] [ text "-" ]
            , div [] [ text (String.fromInt model) ]
            , button [ onClick Increment ] [ text "+" ]
            ]
        ]
    }
