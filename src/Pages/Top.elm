module Pages.Top exposing (Model, Msg, Params, page)

import Html exposing (..)
import Html.Attributes exposing (href)
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url exposing (Url)


type alias Params =
    ()


type alias Model =
    Url Params


type alias Msg =
    Never


page : Page Params Model Msg
page =
    Page.static
        { view = view
        }



-- VIEW


view : Url Params -> Document Msg
view { params } =
    { title = "Homepage"
    , body = [ body ]
    }


body : Html Msg
body =
    ul []
        [ li [] [ a [ href "/examples/groceries" ] [ text "Groceries" ] ]
        , li [] [ a [ href "/examples/buttons" ] [ text "Buttons" ] ]
        , li [] [ a [ href "/examples/cats" ] [ text "Cats" ] ]
        , li [] [ a [ href "/examples/time" ] [ text "time" ] ]
        ]
