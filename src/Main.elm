module Main exposing (Flags, Model, Msg(..), main)

import Browser
import Browser.Events
import Html exposing (Html, a, div, footer, h1, h2, header, img, li, main_, nav, p, section, text, ul)
import Html.Attributes exposing (alt, class, href, id, rel, src, target)



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
    -- header: (navbar++ mobile: logo left + burger right; full: links right;)
    header
        [ class "bg-slate-300"
        ]
        [ logo, outlets, navbar ]


logo : Html Msg
logo =
    img
        [ src "./img/aner_andros.jpg"
        , alt "aa logo"
        ]
        []


outlets : Html Msg
outlets =
    div
        [ class "bg-slate-100"
        ]
        [ text "streaming icons" ]


navbar : Html Msg
navbar =
    nav []
        [ ul []
            [ li []
                [ a
                    [ href "/"
                    ]
                    [ text "home" ]
                ]
            , li []
                [ a
                    [ href "#discog"
                    ]
                    [ text "music" ]
                ]
            , li []
                [ a
                    [ href "#about"
                    ]
                    [ text "about" ]
                ]
            , li []
                [ a
                    [ href "#live"
                    ]
                    [ text "live" ]
                ]
            ]
        ]


hero : Html Msg
hero =
    {-
       hero (mobile: reduce/split. full: big aa head; h1; h2; // gwr logo + link
                                random play option || featured/latest release?)
    -}
    section
        [ id "hero"
        , class "bg-slate-400"
        ]
        [ img
            [ src "./img/aner_andros-big.jpg"
            , alt "aa hero"
            ]
            []
        , h1 [] [ text "aner andros" ]
        , h2 [] [ text "musician. sound designer. creative coder. sound artist." ]
        , img
            [ src "./img/aner_andros-big.jpg"
            , alt "gwr logo"
            ]
            []
        , div [ class "bg-slate-100" ] [ text "random song player" ]
        ]


music : Html Msg
music =
    -- discog (mobile: 2x2 grid; full: horizontal scroll gallery)
    section
        [ id "discog"
        , class "bg-red-100"
        ]
        [ text "music"
        , nav [ class "bg-red-50" ]
            [ ul []
                [ li []
                    [ a
                        [ href "#all"
                        ]
                        [ text "all" ]
                    ]
                , li []
                    [ a
                        [ href "#albums"
                        ]
                        [ text "albums" ]
                    ]
                , li []
                    [ a
                        [ href "#eps"
                        ]
                        [ text "eps" ]
                    ]
                , li []
                    [ a
                        [ href "#remixes"
                        ]
                        [ text "remixes" ]
                    ]
                , li []
                    [ a
                        [ href "#collages"
                        ]
                        [ text "collages" ]
                    ]
                ]
            ]
        ]


about : Html Msg
about =
    -- about (resp. paragraph)
    section
        [ id "about"
        , class "bg-emerald-200"
        ]
        [ div []
            [ p [] [ text "Eclectic non-musician and producer of cinematic ambient, avant-garde, left-field, and softronica. Fond of improvisation, of the studio as an instrument and of meticulously prepared live shows; while preserving empathy and intuition as factors when drawing oneiric soundscapes into a story, in the making of musical voyages. VFS Alumni and Sound Design for Visual Media graduate." ]
            , p [] [ text "Member of Mi.S.Fu and Sleep Collective: a multifunctional, versatile cross-media laboratory dedicated to mapping, music, 3D, arts; and a collective consisting of talents that had given rise to various Sleep Concert in different locations and with different line-ups. Formerly based in Bristol, UK, Aner Andros has performed at the Cube Cinema Plex and have collaborated with Parallel Madness. Also noteworthy are the live shows at Crux Events in London and the Cronosfera Festival in Italy." ]
            ]
        ]


live : Html Msg
live =
    -- live (resp. sort of calendar)
    section
        [ id "live"
        , class "bg-pink-200"
        ]
        [ text "live" ]


footer_ : Html Msg
footer_ =
    footer
        [ class "bg-gray-50"
        ]
        [ div []
            [ p []
                [ text "© Copyright Aner Andros. All Rights Reserved. Made with love and "
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
