module Main exposing (Flags, Model, Msg(..), main)

import Accessibility as Html exposing (..)
import Accessibility.Aria as Aria exposing (..)
import Browser
import Browser.Events
import Html exposing (..)
import Html.Attributes exposing (..)



-- CONSTANTS


latestAlbumTitle : String
latestAlbumTitle =
    "Artefacts and Sonic Brushstrokes"


latestAlbumLink : String
latestAlbumLink =
    "https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/playlists/363304199&color=%23ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true&visual=true"



-- STREAMING OUTLETS


anerSoundCloud : String
anerSoundCloud =
    "https://soundcloud.com/aascloud"


anerSpotify : String
anerSpotify =
    "https://open.spotify.com/artist/00Cg2yZTaYr1EfRZDjStlh"


anerAppleMusic : String
anerAppleMusic =
    "https://music.apple.com/us/artist/aner-andros/1034283469"


anerYoutube : String
anerYoutube =
    "https://www.youtube.com/channel/UC2ZkNnT2pHj01jKuj56mJfg"


anerDeezer : String
anerDeezer =
    "https://www.deezer.com/us/artist/8776748"


anerSongKick : String
anerSongKick =
    "https://www.songkick.com/artists/8738984-aner-andros"

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
        , Aria.label "main content"
        ]
        [ header_
        , hero
        , music
        , about
        , footer_
        ]



-- HEADER


header_ : Html Msg
header_ =
    header
        [ class "flex flex-row justify-center sm:justify-between sticky top-0 bg-white md:mb-4 md:py-2 border-0 md:border-b border-slate-300"
        , Aria.label "main header"
        ]
        [ logo
        , navbar
        ]


logo : Html Msg
logo =
    div
        [ class "text-md md:text-base my-2 sm:ml-4 xl:ml-0 hidden sm:inline-flex font-normal sm:font-medium"
        , Aria.label "brand name"
        ]
        [ ul
            [ class "inline-flex text-md md:text-base"
            ]
            [ li
                [ class "pl-2"
                ]
                [ text "aner andros"
                ]
            ]
        ]


navbar : Html Msg
navbar =
    nav [ Aria.label "main menu" ]
        [ ul
            [ class "inline-flex text-md md:text-base my-2 sm:mr-4 xl:mr-0"
            ]
            [ navLink "#top" "home"
            , navLink "#music" "music"
            , navLink "#about" "about"
            , extLink anerSongKick "live"
            ]
        ]


navLink : String -> String -> Html Msg
navLink link name =
    li
        [ Aria.label "main menu link" ]
        [ a
            [ class "p-2 hover:underline hover:underline-offset-4 hover:bg-slate-100"
            , href <| link
            ]
            [ text <| name
            ]
        ]


extLink : String -> String -> Html Msg
extLink link name =
    li
        [ Aria.label "main menu link" ]
        [ a
            [ class "p-2 hover:underline hover:underline-offset-4 hover:bg-slate-100"
            , href <| link
            , target "_blank"
            , rel "noopener noreferrer"
            ]
            [ text <| name
            ]
        ]



-- HERO


hero : Html Msg
hero =
    section
        [ id "hero", class "sm:mx-2 lg:m-8", Aria.label "hero section" ]
        [ div
            [ class "flex flex-col sm:flex-row sm:justify-around mb-2 mt-0 md:mt-2 mx-2 border-t md:border-0 border-slate-300 text-center"
            ]
            [ h2
                [ class "sm:font-bold py-2 block underline md:hidden landscape:hidden" ]
                [ text "aner andros"
                ]
            , div
                [ class "text-sm lg:text-base lg:text-justify"
                ]
                [ brand
                , h1 [ class "sm:font-semibold py-4 overline" ]
                    [ text "musician. sound designer. creative coder. sound artist."
                    ]
                ]
            , div
                [ class "text-md lg:text-base content-end" ]
                [ latestAlbum
                , outlets
                ]
            ]
        ]


brand : Html Msg
brand =
    div
        [ class "flex flex-row justify-center w-full mt-0 md:mt-2"
        , Aria.label "brand logo"
        ]
        [ img [ src "https://placekitten.com/400/400", alt "Aner Andros" ] []
        ]


latestAlbum : Html Msg
latestAlbum =
    div
        [ class "flex flex-col justify-center mb-2 mt-0 md:mt-2 mx-2 border-t md:border-0 border-slate-300"
        , Aria.label "latest album player"
        ]
        [ h2 [ class "sm:font-semibold py-4 md:p-0 underline block md:hidden landscape:hidden" ]
            [ text "latest release"
            ]
        , iframe
            [ class "w-full h-80"
            , src latestAlbumLink
            , title latestAlbumTitle
            ]
            []
        ]


socialIcon : String -> String -> String -> Html msg
socialIcon link icon socialname =
    li
        [ class "pl-0 px-5"
        , Aria.label socialname
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
    div [ Aria.label "music outlets social links" ]
        [ ul
            [ class "inline-flex py-2 justify-center text-lg lg:text-xl"
            ]
            [ socialIcon anerSoundCloud "bx-fw bx bxl-soundcloud" "soundcloud"
            , socialIcon anerSpotify "bx-fw bx bxl-spotify" "spotify"
            , socialIcon anerAppleMusic "bx-fw bx bxl-apple" "apple"
            , socialIcon anerYoutube "bx-fw bx bxl-youtube" "youtube"
            , socialIcon anerDeezer "bx-fw bx bxl-deezer" "deezer"
            ]
        ]



-- DISCOGRAPHY


music : Html Msg
music =
    section
        [ id "music", class "mt-2 mx-1 md:mx-2", Aria.label "discography section" ]
        [ div
            [ class "flex flex-col text-md lg:text-base border-t border-slate-300 text-center" ]
            [ h2 [ class "sm:font-semibold pt-4 mb-4 underline" ]
                [ text "music"
                ]
            , discog
            , ul
                [ class "flex flex-row justify-center text-sm lg:text-base my-4 sm:mr-4"
                ]
                [ releaseKind "#all" "all"
                , releaseKind "#albums" "albums"
                , releaseKind "#eps" "eps"
                , releaseKind "#remixes" "remixes"
                , releaseKind "#collages" "collages"
                ]
            ]
        ]


releaseKind : String -> String -> Html Msg
releaseKind anchor name =
    li
        [ class "px-2 hover:underline hover:underline-offset-4"
        , Aria.label "kind of release selectors"
        ]
        [ a
            [ href <| anchor
            ]
            [ text <| name ]
        ]


discog : Html Msg
discog =
    ul
        [ class "flex flex-row justify-between p-2 m-2"
        , Aria.label "all published releases"
        ]
        [ li [] [ release "https://placekitten.com/300" "Artefacts and Sonic Brushstrokes" "ep" ]
        , li [] [ release "https://placekitten.com/300" "Liminal Tales" "album" ]
        , li [] [ release "https://placekitten.com/300" "Embroidering on Silence Vol. I" "ep" ]
        , li [] [ release "https://placekitten.com/300" "Remap Ethos Stream" "album" ]
        , li [] [ release "https://placekitten.com/300" "Enkefalina (Aner Andros Remix)" "remix" ]
        , li [] [ release "https://placekitten.com/300" "ISPIRAZIONE" "collage" ]
        ]


release : String -> String -> String -> Html Msg
release cover name kind =
    img name
        [ src cover
        , alt name
        , title name
        ]



-- ABOUT


about : Html Msg
about =
    -- about (resp. paragraph)
    section
        [ id "about", class "mt-2 mx-1 md:mx-2", Aria.label "about section" ]
        [ div [ class "flex flex-col text-md lg:text-base border-t border-slate-300" ]
            [ h2 [ class "sm:font-semibold pt-4 mb-4 underline text-center" ]
                [ text "about"
                ]
            , div [ class "bg-gray-50 p-8 mb-4 md:mb-8" ]
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
        ]



-- LIVE
{-
   live : Html Msg
   live =
       -- live (resp. sort of calendar)
       section [ id "live", Aria.label "live shows section" ] [ text "live" ]
-}
-- FOOTER


footer_ : Html Msg
footer_ =
    footer [ id "footer", class "mt-2", Aria.label "footer" ]
        [ div [ class "flex flex-col justify-center text-sm md:text-sm border-t border-slate-300 py-4 text-center" ]
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
