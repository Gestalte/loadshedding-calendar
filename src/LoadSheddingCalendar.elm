module LoadSheddingCalendar exposing(main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html exposing (..)
import Html.Events exposing (onClick)
import Http

main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

type alias Model =
    { stage : String
    }

type Msg
    = GetStage

initialModel:Model
initialModel =
    { stage = "test"
    }

init : () -> (Model, Cmd Msg)
init _ =
    (initialModel, Cmd.none)

view: Model -> Html Msg
view model =
    div [] 
        [ text ("Stage: " ++ model.stage)
        ] 

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        GetStage ->
            ( 
            { model
            | stage = ""
            }
            , Cmd.none
            )

subscriptions : a -> Sub Msg
subscriptions _ = Sub.none