module Main exposing (Model, Msg, main)

import Accessibility.Aria as Aria
import Browser
import FontAwesome as Icon exposing (Icon, WithoutId)
import FontAwesome.Attributes as Icon
import FontAwesome.Brands as Icon
import FontAwesome.Solid as Icon
import FontAwesome.Styles as Icon
import Html
    exposing
        ( Html
        , a
        , div
        , footer
        , h1
        , img
        , label
        , li
        , main_
        , p
        , section
        , text
        , ul
        )
import Html.Attributes as Attr
import Html.Events exposing (onClick)
import VitePluginHelper exposing (asset)



-- ANER ANDROS


type alias AnerAndros =
    { name : String
    , logo : String
    , apple : String
    , soundcloud : String
    , spotify : String
    , youtube : String
    , mixcloud : String
    , deezer : String
    , songkick : String
    , twitter : String
    }


anerandros : AnerAndros
anerandros =
    { name = "Aner Andros"
    , logo = asset "../img/aa.svg"
    , apple = "https://music.apple.com/artist/aner-andros/1034283469"
    , soundcloud = "https://soundcloud.com/aascloud"
    , spotify = "https://open.spotify.com/artist/00Cg2yZTaYr1EfRZDjStlh"
    , youtube = "https://www.youtube.com/channel/UC2ZkNnT2pHj01jKuj56mJfg"
    , mixcloud = "https://www.mixcloud.com/aasmixes/"
    , deezer = "https://www.deezer.com/artist/8776748"
    , songkick = "https://www.songkick.com/artists/8738984-aner-andros"
    , twitter = "https://twitter.com/thecallea/"
    }


anerAndrosOutlets : List ( String, String )
anerAndrosOutlets =
    [ ( anerandros.soundcloud, "soundcloud" )
    , ( anerandros.spotify, "spotify" )
    , ( anerandros.apple, "apple" )
    , ( anerandros.youtube, "youtube" )
    , ( anerandros.deezer, "deezer" )
    , ( anerandros.songkick, "songkick" )
    , ( anerandros.twitter, "twitter" )
    ]



-- MESSAGES


type Msg
    = ShowAbout Bool



-- MODEL


type alias Model =
    { aboutVisible : Bool
    }



-- INIT


initialModel : ( Model, Cmd Msg )
initialModel =
    ( { aboutVisible = False }
    , Cmd.none
    )



--MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> initialModel
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- VIEW


view : Model -> Html Msg
view model =
    main_
        [ Aria.label "main content", Attr.class "min-h-screen" ]
        [ Icon.css
        , hero model
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ShowAbout bool ->
            ( { model | aboutVisible = bool }, Cmd.none )



-- HERO


hero : Model -> Html Msg
hero model =
    div
        [ Attr.class "hero min-h-screen md:py-8 bg-base-100"
        ]
        [ div
            [ Attr.class "hero-content flex-col lg:flex-row"
            ]
                [ Attr.src anerandros.logo
                , Attr.alt "Aner Andros Logo"
                , Attr.title "Aner Andros Logo"
                , Attr.class "w-full h-full max-w-md rounded-2xl shadow-2xl bg-base-content mask mask-hexagon"
                ]
                , p
                    [ Attr.class "py-2 md:py-6" ]
                    [ text "Left-Field. Cinematic Ambient. Soundscapes. Avant-Garde. Sound Design. Collages. Softronica. Oneiric Story Telling. Remixes. Moon Musick. Glitch. Mixtapes. Creative Coding. Ambient Music." ]
                , div [ Attr.class "flex flex-col md:flex-row items-center justify-between xl:mr-10" ]
                    [ outlets anerAndrosOutlets "justify-center md:justify-start md:grow" "text-center text-xl" "md:first:pl-0 px-2 mb-4"
                    , label
                        [ Attr.class "btn btn-xs btn-outline swap swap-rotate mb-4"
                        , onClick (ShowAbout (not model.aboutVisible))
                        ]
                        [ if model.aboutVisible == False then
                            text "About"

                          else
                            Icon.view Icon.xmark
                        ]
                    ]
                , if model.aboutVisible then
                    div [ Attr.class "xl:mr-10 block" ] [ about ]

                  else
                    div [ Attr.class "xl:mr-10 hidden" ] [ about ]
                , div [ Attr.class "xl:mr-10" ] [ footer_ ]
                ]
            ]
        ]


outlets : List ( String, String ) -> String -> String -> String -> Html msg
outlets outletKind justification ulAdditionalCss liPadding =
    div
        [ Aria.label "music outlets and social links"
        , Attr.class "flex"
        , Attr.class justification
        ]
        [ ul
            [ Attr.class "inline-flex"
            , Attr.class ulAdditionalCss
            ]
          <|
            List.map
                (\service ->
                    li
                        [ Attr.class liPadding
                        , Aria.label (Tuple.second service)
                        ]
                        [ a
                            [ Attr.href <| Tuple.first service
                            , Attr.target "_blank"
                            , Attr.rel "noopener noreferrer"
                            , Icon.fw
                            ]
                            [ Icon.view <| returnicon (Tuple.second service) ]
                        ]
                )
                outletKind
        ]


returnicon : String -> Icon WithoutId
returnicon str =
    case str of
        "soundcloud" ->
            Icon.soundcloud

        "spotify" ->
            Icon.spotify

        "apple" ->
            Icon.apple

        "youtube" ->
            Icon.youtube

        "deezer" ->
            Icon.deezer

        "songkick" ->
            Icon.starOfLife

        "twitter" ->
            Icon.twitter

        _ ->
            Icon.smile



-- ABOUT


about : Html msg
about =
    section
        [ Attr.id "about", Aria.label "about section" ]
        [ div [ Attr.class "border-t border-base-content py-4" ]
            [ div [ Attr.class "text-center sm:text-left" ]
                [ p [ Attr.class "pb-1" ]
                    [ text
                        "Eclectic non-musician and producer of cinematic ambient, avant-garde, left-field, glitch, and softronica. Fond of improvisation, of the "
                    , a
                        [ Attr.href "https://www.ableton.com/en/blog/studio-as-an-instrument-part-1/"
                        , Attr.class "link"
                        , Attr.target "_blank"
                        , Attr.rel "noopener noreferrer"
                        ]
                        [ text
                            "studio as an instrument"
                        ]
                    , text
                        " and of meticulously prepared live shows. While preserving empathy and intuition as key factors, when drawing oneiric soundscapes into a story, in the making of musical voyages. "
                    , a
                        [ Attr.href "https://vfs.edu/programs/sound-design"
                        , Attr.class "link"
                        , Attr.target "_blank"
                        , Attr.rel "noopener noreferrer"
                        ]
                        [ text "VFS Sound Design graduate. " ]
                    ]
                , p [ Attr.class "py-1" ]
                    [ text "Formerly based in Bristol, UK, he has performed at the "
                    , a
                        [ Attr.href "https://cubecinema.com/"
                        , Attr.class "link"
                        , Attr.target "_blank"
                        , Attr.rel "noopener noreferrer"
                        ]
                        [ text "Cube Cinema" ]
                    , text " and has collaborated with "
                    , a
                        [ Attr.href "https://parallelmadness.com/"
                        , Attr.class "link"
                        , Attr.target "_blank"
                        , Attr.rel "noopener noreferrer"
                        ]
                        [ text "Parallel Madness." ]
                    , text " Notable shows include: "
                    , a
                        [ Attr.href "https://www.cubecinema.com/id/8295/"
                        , Attr.class "link"
                        , Attr.target "_blank"
                        , Attr.rel "noopener noreferrer"
                        ]
                        [ text "'100 Years of DADA'" ]
                    , text
                        " celebratory event at the Cube Cinema, and bespoke lives at "
                    , a
                        [ Attr.href "https://crux-events.org/"
                        , Attr.class "link"
                        , Attr.target "_blank"
                        , Attr.rel "noopener noreferrer"
                        ]
                        [ text "Crux Events in London" ]
                    , text ", and Cronosfera Festival in Italy."
                    ]
                ]
            ]
        ]



-- FOOTER


footer_ : Html msg
footer_ =
    footer [ Attr.id "footer", Aria.label "footer" ]
        [ div [ Attr.class "flex flex-col md:flex-row justify-between border-t border-base-content py-4 text-center text-sm" ]
            [ p []
                [ text "© ℗ "
                , a
                    [ Attr.href "https://gentlewashrecords.com/"
                    , Attr.class "link"
                    , Attr.target "_blank"
                    , Attr.rel "noopener noreferrer"
                    ]
                    [ text "Gentle Wash Records" ]
                ]
            , p []
                [ text "Made with "
                , a
                    [ Attr.href "https://github.com/gacallea/elm_vite_tailwind_template"
                    , Attr.class "link"
                    , Attr.target "_blank"
                    , Attr.rel "noopener noreferrer"
                    ]
                    [ text "Love" ]
                , text " and "
                , a
                    [ Attr.href "https://elm-lang.org/"
                    , Attr.class "link"
                    , Attr.target "_blank"
                    , Attr.rel "noopener noreferrer"
                    ]
                    [ text "Elm" ]
                ]
            ]
        ]
