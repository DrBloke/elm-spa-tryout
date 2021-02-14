module Pages.Examples.Groceries exposing (Model, Msg, Params, page)

import Html exposing (..)
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)


page : Page Params Model Msg
page =
    Page.static
        { view = view
        }


type alias Model =
    Url Params


type alias Msg =
    Never



-- VIEW


type alias Params =
    ()


view : Url Params -> Document Msg
view { params } =
    { title = "Examples.Groceries"
    , body =
        [ div []
            [ h1 [] [ text "My Grocery List" ]
            , ul []
                [ li [] [ text "Black Beans" ]
                , li [] [ text "Limes" ]
                , li [] [ text "Greek Yogurt" ]
                , li [] [ text "Cilantro" ]
                , li [] [ text "Honey" ]
                , li [] [ text "Sweet Potatoes" ]
                , li [] [ text "Cumin" ]
                , li [] [ text "Chili Powder" ]
                , li [] [ text "Quinoa" ]
                ]
            ]
        ]
    }
