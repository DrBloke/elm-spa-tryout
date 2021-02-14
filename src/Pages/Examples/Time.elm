module Pages.Examples.Time exposing (Model, Msg, Params, page)

import Html exposing (..)
import Spa.Document exposing (Document)
import Spa.Page as Page exposing (Page)
import Spa.Url as Url exposing (Url)
import Task
import Time


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



-- MODEL


type alias Model =
    { zone : Time.Zone
    , time : Time.Posix
    }


init : Url Params -> ( Model, Cmd Msg )
init { params } =
    ( Model Time.utc (Time.millisToPosix 0)
    , Task.perform AdjustTimeZone Time.here
    )



-- UPDATE


type Msg
    = Tick Time.Posix
    | AdjustTimeZone Time.Zone


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( { model | time = newTime }
            , Cmd.none
            )

        AdjustTimeZone newZone ->
            ( { model | zone = newZone }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every 1000 Tick



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Examples.Time"
    , body = [ body model ]
    }


body : Model -> Html Msg
body model =
    let
        hour =
            String.fromInt (Time.toHour model.zone model.time)

        minute =
            String.fromInt (Time.toMinute model.zone model.time)

        second =
            String.fromInt (Time.toSecond model.zone model.time)
    in
    h1 [] [ text (hour ++ ":" ++ minute ++ ":" ++ second) ]
