module Main exposing (Flags, Model, Msg(..), main)

import Browser
import Browser.Events
import Element
    exposing
        ( Element
        , el
        , layout
        , padding
        , paragraph
        , rgb255
        , text
        )
import Element.Font as Font
import Element.Region as Region
import Html exposing (Html)



-- MESSAGES


type Msg
    = OnResize Int Int



-- TYPES
-- MODEL


type alias Model =
    { viewport :
        { width : Int
        , height : Int
        }
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
      }
    , Cmd.none
    )


view : Model -> Html Msg
view _ =
    layout [ Region.mainContent ] <|
        viewLoaded



-- VIEW


viewLoaded : Element msg
viewLoaded =
    paragraph [ padding 10 ]
        [ el
            [ Font.family
                [ Font.typeface "Raleway"
                , Font.sansSerif
                ]
            , Font.size 40
            , Font.medium
            , Font.color (rgb255 13 30 45)
            ]
            (text "Aner Andros")
        ]



-- VIEW HELPERS
-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnResize x y ->
            ( { model | viewport = { width = x, height = y } }
            , Cmd.none
            )



-- UPDATE HELPERS
-- MAIN


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- COMMANDS
-- getNewWordCmd : Cmd Msg
-- getNewWordCmd =
--     Http.get
--         { url = randomWordsApiUrl
--         , expect = Http.expectJson GetNewWord (Decode.list newWordDecoder)
--         }
-- newWordDecoder : Decoder NewWord
-- newWordDecoder =
--     Decode.succeed NewWord
--         |> Pipeline.required "word" Decode.string
--         |> Pipeline.required "definition" Decode.string
--         |> Pipeline.required "pronunciation" Decode.string
-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Browser.Events.onResize OnResize
