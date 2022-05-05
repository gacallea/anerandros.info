module Main exposing (Flags, Model, Msg(..), main)

import Browser
import Browser.Events
import Html exposing (Html, div, text)
import Html.Attributes exposing (class)



-- MESSAGES


type Msg
    = OnResize Int Int



-- MODEL


type alias Model =
    { viewport :
        { width : Int
        , height : Int
        }
    , hello : String
    }



-- FLAGS


type alias Flags =
    { win_width : Int
    , win_height : Int
    }



-- INIT


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { viewport =
            { width = flags.win_width
            , height = flags.win_height
            }
      , hello = "Hello Elm + Tailwind CSS :)"
      }
    , Cmd.none
    )



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ class "text-4xl flex justify-center items-center h-screen"
        ]
        [ text model.hello ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnResize x y ->
            ( { model | viewport = { width = x, height = y } }
            , Cmd.none
            )



-- MAIN


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Browser.Events.onResize OnResize
