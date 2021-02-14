module Pages.Examples.Cats exposing (Model, Msg, Params, page)

import Html exposing (Html, button, div, h2, img, text)
import Html.Attributes exposing (src, style)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode exposing (Decoder)
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)


page : Page Params Model Msg
page =
    Page.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- INIT


type alias Params =
    ()


type Model
    = Failure
    | Loading
    | Success String


init : Url Params -> ( Model, Cmd Msg )
init { params } =
    ( Loading, getRandomCatGif )



-- UPDATE


type Msg
    = MorePlease
    | GotGif (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MorePlease ->
            ( Loading, getRandomCatGif )

        GotGif result ->
            case result of
                Ok url ->
                    ( Success url, Cmd.none )

                Err _ ->
                    ( Failure, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Examples.Cats"
    , body = [ body model ]
    }


body : Model -> Html Msg
body model =
    div []
        [ h2 [] [ text "Random Cats" ]
        , viewGif model
        ]


viewGif : Model -> Html Msg
viewGif model =
    case model of
        Failure ->
            div []
                [ text "I could not load a random cat for some reason. "
                , button [ onClick MorePlease ] [ text "Try Again!" ]
                ]

        Loading ->
            text "Loading..."

        Success url ->
            div []
                [ button [ onClick MorePlease, style "display" "block" ] [ text "More Please!" ]
                , img [ src url ] []
                ]



-- HTTP


getRandomCatGif : Cmd Msg
getRandomCatGif =
    Http.get
        { url = "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=cat"
        , expect = Http.expectJson GotGif gifDecoder
        }


gifDecoder : Decoder String
gifDecoder =
    Decode.field "data" (Decode.field "image_url" Decode.string)
