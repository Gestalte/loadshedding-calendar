module LoadSheddingCalendar exposing(main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html exposing (..)
import Html.Events exposing (onClick)
import Http
import Platform.Cmd exposing (none)

main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

baseUrl:String
baseUrl = 
    "https://loadshedding.eskom.co.za/LoadShedding/"

type alias Stage =
    String

type alias Model =
    { stage : Maybe Stage
    , error : Maybe Http.Error
    }

errorMessage : Http.Error -> String
errorMessage error =
    case error of
        _ ->
            "Could not load data."

type Msg
    = LoadStatus (Result Http.Error Stage)

initialModel:Model
initialModel =
    { stage = Just "test"
    , error = Nothing
    }

init : () -> (Model, Cmd Msg)
init _ =
    (initialModel, getStage)

getStage : Cmd Msg
getStage =
    Http.request
        { body = Http.emptyBody
        , expect = Http.expectString LoadStatus
        , headers = [(Http.header "Access-Control-Allow-Origin" "https://loadshedding.eskom.co.za")]
        , method = "GET"
        , timeout = Nothing
        , tracker =Nothing
        , url = baseUrl++"GetStatus"
        }

view: Model -> Html Msg
view model =
    case model.error of
        Just error -> text ("Stage: " ++ (errorMessage error))

        Nothing -> 
            case model.stage of
                Just stage -> text("Stage: " ++ stage)

                Nothing -> text("Not Loadshedding")

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        LoadStatus (Ok stage) ->
            ({ model | stage = Just stage }, Cmd.none)

        LoadStatus (Err error) ->
            ({ model | error = Just error }, Cmd.none)

subscriptions : a -> Sub Msg
subscriptions _ = Sub.none