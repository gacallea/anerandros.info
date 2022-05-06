module Main exposing (Flags, Model, Msg(..), main)

import Browser
import Browser.Events
import Html exposing (..)
import Html.Attributes exposing (..)



-- CONSTANTS


latestAlbumLink : String
latestAlbumLink =
    "https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/playlists/363304199&color=%23ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true&visual=true"


soundCloudLink : String
soundCloudLink =
    "https://soundcloud.com/aascloud"


spotifyLink : String
spotifyLink =
    "https://open.spotify.com/artist/00Cg2yZTaYr1EfRZDjStlh"


appleMusicLink : String
appleMusicLink =
    "https://music.apple.com/us/artist/aner-andros/1034283469"


youtubeLink : String
youtubeLink =
    "https://www.youtube.com/channel/UC2ZkNnT2pHj01jKuj56mJfg"


deezerLink : String
deezerLink =
    "https://www.deezer.com/us/artist/8776748"



-- MESSAGES


type Msg
    = OnResize Int Int



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



-- VIEW


view : Model -> Html Msg
view _ =
    main_
        [ class "container mx-auto max-w-7xl"
        ]
        [ header_
        , hero

        -- , music
        , about
        , live
        , footer_
        ]



-- HEADER


header_ : Html Msg
header_ =
    header
        [ class "flex flex-row justify-center sm:justify-end sticky top-0 bg-white"
        ]
        [ logo_nav
        , navbar
        ]


logo_nav : Html Msg
logo_nav =
    div
        [ class "text-sm md:text-base my-2 ml-4 mr-auto hidden sm:inline-flex"
        ]
        [ text "aner andros"
        ]


navbar : Html Msg
navbar =
    nav []
        [ ul
            [ class "inline-flex text-sm md:text-base my-2 sm:mr-4"
            ]
            [ navlink "#top" "home"
            , navlink "#music" "music"
            , navlink "#about" "about"
            , navlink "#live" "live"
            ]
        ]


navlink : String -> String -> Html Msg
navlink link name =
    li
        [ class "font-normal sm:font-medium"
        ]
        [ a
            [ class "p-2 hover:underline hover:underline-offset-4 hover:bg-slate-100"
            , href <| link
            ]
            [ text <| name
            ]
        ]



-- HERO


hero : Html Msg
hero =
    section
        [ id "hero"
        , class "flex flex-col sm:flex-row sm:justify-between sm:mx-4"
        ]
        [ div
            [ class "text-xs lg:text-base text-center lg:text-justify"
            ]
            [ logo
            , h1 [ class "sm:font-semibold py-4 overline" ]
                [ text "musician. sound designer. creative coder. sound artist."
                ]
            ]
        , div
            [ class "text-sm lg:text-base text-center" ]
            [ latestAlbum
            , outlets
            ]
        ]


logo : Html Msg
logo =
    div
        [ class "bg-gray-50 flex flex-row justify-center w-full"
        ]
        [ img [ src "https://placekitten.com/400/400", alt "aa logo" ] []
        ]


latestAlbum : Html Msg
latestAlbum =
    div
        [ class "flex flex-col justify-center mb-2 mt-2 mx-2 border-t border-slate-300"
        ]
        [ h2 [ class "sm:font-semibold py-4 underline" ]
            [ text "latest album"
            ]
        , iframe
            [ class "w-full h-80"
            , src latestAlbumLink
            ]
            []
        ]


socialIcon : String -> String -> Html msg
socialIcon link icon =
    li
        [ class "pl-0 px-5"
        ]
        [ a
            [ href <| link
            , target "_blank"
            , rel "noopener noreferrer"
            ]
            [ i
                [ class <| icon
                ]
                []
            ]
        ]


outlets : Html Msg
outlets =
    div []
        [ ul
            [ class "inline-flex py-2 justify-center"
            ]
            [ socialIcon soundCloudLink "bx-fw bx bxl-soundcloud"
            , socialIcon spotifyLink "bx-fw bx bxl-spotify"
            , socialIcon appleMusicLink "bx-fw bx bxl-apple"
            , socialIcon youtubeLink "bx-fw bx bxl-youtube"
            , socialIcon deezerLink "bx-fw bx bxl-deezer"
            ]
        ]



-- DISCOGRAPHY


releaseKind : String -> String -> Html Msg
releaseKind anchor name =
    li
        [ class "px-2 pr-0"
        ]
        [ a
            [ href <| anchor
            ]
            [ text <| name ]
        ]


music : Html Msg
music =
    -- music (mobile: 2x2 grid; full: horizontal scroll gallery)
    section
        [ id "music"
        , class "bg-red-100 text-center"
        ]
        [ nav
            [ class "bg-red-50"
            ]
            [ ul
                [ class "flex flex-row justify-center"
                ]
                [ releaseKind "#all" "all"
                , releaseKind "#albums" "albums"
                , releaseKind "#eps" "eps"
                , releaseKind "#remixes" "remixes"
                , releaseKind "#collages" "collages"
                ]
            ]
        , discog
        ]


discog : Html Msg
discog =
    div []
        [ text "dada"
        ]


about : Html Msg
about =
    -- about (resp. paragraph)
    section
        [ id "about"
        , class "flex flex-col text-sm lg:text-base mt-2 mx-2 border-t border-slate-300"
        ]
        [ h2 [ class "sm:font-semibold pt-4 underline text-center" ]
            [ text "about"
            ]
        , div [ class "p-4" ]
            [ p [ class "p-1" ]
                [ text "Eclectic producer of cinematic ambient, avant-garde, left-field, glitch, and softronica. Fond of improvisation, of the studio as an instrument and of meticulously prepared live shows. While preserving empathy and intuition as key factors when drawing oneiric soundscapes in the making of musical voyages. "
                , a
                    [ href "https://vfs.edu/programs/sound-design"
                    , target "_blank"
                    , rel "noopener noreferrer"
                    ]
                    [ text "VFS Alumnus and Sound Design for Visual Media graduate." ]
                ]
            , p [ class "p-1" ] [ text "Member of Mi.S.Fu and Sleep Collective. The former: a multifunctional, versatile cross-media laboratory dedicated to mapping, music, 3D, arts. The latter: a collective consisting of talents that had given rise to various Sleep Concert in different Italian locations and with different line-ups." ]
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
                , text ". Other noteworthy shows include "
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
    footer [ class "flex flex-row justify-center text-xs md:text-sm mt-2 mx-2 border-t border-slate-300" ]
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
