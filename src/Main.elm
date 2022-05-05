module Main exposing (Flags, Model, Msg(..), main)

import Browser
import Browser.Events
import Html exposing (..)
import Html.Attributes exposing (..)



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
view _ =
    main_
        [ class "container mx-auto"
        ]
        [ header_
        , hero
        , music
        , about
        , live
        , footer_
        ]


header_ : Html Msg
header_ =
    -- header: (navbar++ mobile: logo left + burger right; full: links right)
    header [ class "flex flex-row justify-between py-2" ] [ outlets, navbar ]


socialIcon : String -> String -> Html msg
socialIcon link icon =
    li
        [ class "pl-0 px-1" ]
        [ a
            [ href <| link, target "_blank", rel "noopener noreferrer" ]
            [ i [ class <| icon ] [] ]
        ]


outlets : Html Msg
outlets =
    div []
        [ ul [ class "inline-flex" ]
            [ socialIcon "https://soundcloud.com/aascloud" "bx-fw bx bxl-soundcloud"
            , socialIcon "https://open.spotify.com/artist/00Cg2yZTaYr1EfRZDjStlh" "bx-fw bx bxl-spotify"
            , socialIcon "https://music.apple.com/us/artist/aner-andros/1034283469" "bx-fw bx bxl-apple"
            , socialIcon "https://www.youtube.com/channel/UC2ZkNnT2pHj01jKuj56mJfg" "bx-fw bx bxl-youtube"
            , socialIcon "https://www.deezer.com/us/artist/8776748" "bx-fw bx bxl-deezer"
            ]
        ]


navlink : String -> String -> Html Msg
navlink link name =
    li
        [ class "px-2 pr-0 font-medium" ]
        [ a
            [ href <| link ]
            [ text <| name ]
        ]


navbar : Html Msg
navbar =
    nav []
        [ ul [ class "inline-flex" ]
            [ navlink "/" "home"
            , navlink "#discog" "music"
            , navlink "#about" "about"
            , navlink "#live" "live"
            ]
        ]


hero : Html Msg
hero =
    {-
       hero (mobile: reduce/split. full: big aa head; h1; h2; // gwr logo + link
                                    + featured/latest release with play option
    -}
    section [ id "hero", class "bg-purple-100 flex flex-row justify-evenly" ]
        [ div [ class "align-top" ]
            [ img [ src "./img/aner_andros-big.jpg", alt "aa logo" ] []
            ]
        , div [ class "align-middle" ]
            [ h1 [ class "font-semibold text-5xl" ] [ text "aner andros" ]
            , h2 [] [ text "musician. sound designer. creative coder. sound artist." ]
            ]
        , div
            [ class "align-bottom" ]
            [ img [ src "./img/aner_andros-big.jpg", alt "gwr logo" ] []
            , latestAlbum
            ]
        ]


latestAlbum : Html Msg
latestAlbum =
    p [ class "bg-slate-50" ] [ i [ class "bx-fw bx bx-play-circle" ] [], text "featured release w/ play option" ]


discogCategory : String -> String -> Html Msg
discogCategory anchor name =
    li [ class "px-2 pr-0" ] [ a [ href <| anchor ] [ text <| name ] ]


music : Html Msg
music =
    -- discog (mobile: 2x2 grid; full: horizontal scroll gallery)
    section [ id "discog", class "bg-red-100 text-center" ]
        [ nav [ class "bg-red-50" ]
            [ ul [ class "flex flex-row justify-center" ]
                [ discogCategory "#all" "all"
                , discogCategory "#albums" "albums"
                , discogCategory "#eps" "eps"
                , discogCategory "#remixes" "remixes"
                , discogCategory "#collages" "collages"
                ]
            ]
        , text "discography 'gallery' goes here"
        , div [ class "bg-gray-50 flex flex-row justify-center py-2 text-sm" ]
            [ p [] [ text "℗ © ", a [ href "https://gentlewashrecords.com/", target "_blank", rel "noopener noreferrer" ] [ text "Gentle Wash Records" ] ] ]
        ]


about : Html Msg
about =
    -- about (resp. paragraph)
    section
        [ id "about"
        , class "bg-emerald-200"
        ]
        [ div [ class "px-4 py-2" ]
            [ p [ class "p-1" ]
                [ text "Eclectic non-musician and producer of cinematic ambient, avant-garde, left-field, and softronica. Fond of improvisation, of the studio as an instrument and of meticulously prepared live shows. While preserving empathy and intuition as key factors when drawing oneiric soundscapes into a story, in the making of musical voyages. "
                , a
                    [ href "https://vfs.edu/programs/sound-design"
                    , target "_blank"
                    , rel "noopener noreferrer"
                    ]
                    [ text "VFS Alumnus and Sound Design for Visual Media graduate." ]
                ]
            , p [ class "p-1" ] [ text "Member of Mi.S.Fu and Sleep Collective: a multifunctional, versatile cross-media laboratory dedicated to mapping, music, 3D, arts; and a collective consisting of talents that had given rise to various Sleep Concert in different locations and with different line-ups." ]
            , p [ class "p-1" ]
                [ text "Formerly based in Bristol, UK, Aner Andros has performed at the "
                , a
                    [ href "https://cubecinema.com/"
                    , target "_blank"
                    , rel "noopener noreferrer"
                    ]
                    [ text "Cube Cinema Plex" ]
                , text " and has collaborated with "
                , a
                    [ href "https://parallelmadness.com/"
                    , target "_blank"
                    , rel "noopener noreferrer"
                    ]
                    [ text "Parallel Madness" ]
                , text " Also noteworthy are the live shows at "
                , a
                    [ href "https://crux-events.org/"
                    , target "_blank"
                    , rel "noopener noreferrer"
                    ]
                    [ text "Crux Events in London" ]
                , text " and the Cronosfera Festival in Italy."
                ]
            ]
        ]


live : Html Msg
live =
    -- live (resp. sort of calendar)
    section [ id "live", class "bg-pink-200" ] [ text "live" ]


footer_ : Html Msg
footer_ =
    footer [ class "bg-gray-50 flex flex-row justify-center text-sm" ]
        [ div [ class "py-4 text-center" ]
            [ p []
                [ text "© Copyright Aner Andros. All Rights Reserved." ]
            , p []
                [ text "Made with love and "
                , a
                    [ href "https://elm-lang.org/"
                    , target "_blank"
                    , rel "noopener noreferrer"
                    ]
                    [ text "Elm." ]
                ]
            ]
        ]



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
