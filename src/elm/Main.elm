module Main exposing (Flags, Model, main)

import Accessibility.Aria as Aria
import Browser
import Browser.Events
import Catalogue
    exposing
        ( ReleaseData
        , ReleaseKind(..)
        , allAlbums
        , allCollages
        , allEps
        , allReleases
        , allRemixes
        , anerAppleMusic
        , anerDeezer
        , anerSongKick
        , anerSoundCloud
        , anerSpotify
        , anerYoutube
        , brandImage
        , gentleWashHome
        , latestAlbumTitle
        , showReleases
        )
import FontAwesome.Attributes as Icon
import FontAwesome.Brands as Icon
import FontAwesome.Icon as Icon exposing (Icon)
import FontAwesome.Solid as Icon
import FontAwesome.Styles as Icon
import Html
    exposing
        ( Html
        , a
        , div
        , footer
        , h1
        , h2
        , header
        , img
        , li
        , main_
        , nav
        , p
        , section
        , ul
        )
import Html.Attributes as Attr
import Html.Events exposing (onClick)
import Msg exposing (Msg(..))
import Svg exposing (svg)
import Svg.Attributes as SvgAttr
import VitePluginHelper



-- TYPES
-- MODEL


type alias Model =
    { viewport :
        { width : Int
        , height : Int
        }
    , showRelease : ReleaseKind
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
      , showRelease = All
      }
    , Cmd.none
    )



-- VIEW


view : Model -> Html Msg
view model =
    main_
        [ Attr.class "container mx-auto max-w-7xl"
        , Aria.label "main content"
        ]
        [ Icon.css
        , header_
        , hero
        , music model
        , about
        , footer_
        ]



-- HEADER


header_ : Html Msg
header_ =
    header
        [ Attr.class "flex flex-row justify-center sm:justify-between sticky top-0 bg-white border-b border-slate-300"
        , Aria.label "main header"
        ]
        [ logo
        , navbar
        ]


logo : Html Msg
logo =
    div
        [ Attr.class "text-md md:text-base my-2 sm:ml-4 xl:ml-0 hidden sm:inline-flex font-normal sm:font-medium"
        , Aria.label "brand name"
        ]
        [ ul
            [ Attr.class "inline-flex text-md md:text-base"
            ]
            [ li
                [ Attr.class "pl-2"
                ]
                [ Html.text "aner andros"
                ]
            ]
        ]


navbar : Html Msg
navbar =
    nav [ Aria.label "main menu" ]
        [ ul
            [ Attr.class "inline-flex text-md md:text-base my-2 sm:mr-4 xl:mr-0"
            ]
          <|
            navLink links
        ]


links : List ( String, String )
links =
    [ ( "#top", "home" )
    , ( "#music", "music" )
    , ( "#about", "about" )
    , ( anerSongKick, "live" )
    ]


navLink : List ( String, String ) -> List (Html msg)
navLink list =
    let
        target_ : ( String, b ) -> String
        target_ link =
            if String.startsWith "http" (Tuple.first link) then
                "_blank"

            else
                "_self"
    in
    List.map
        (\lnk ->
            li
                [ Aria.label "main menu link" ]
                [ a
                    [ Attr.class "p-2 hover:underline hover:underline-offset-4"
                    , Attr.href <| Tuple.first lnk
                    , Attr.target (target_ lnk)
                    , Attr.rel "noopener noreferrer"
                    ]
                    [ Html.text <| Tuple.second lnk
                    ]
                ]
        )
        list



-- HERO


hero : Html Msg
hero =
    section
        [ Attr.id "hero", Attr.class "mx-0 md:mx-2", Aria.label "hero section" ]
        [ div
            [ Attr.class "mx-0 md:mx-14 flex flex-col sm:flex-row sm:justify-between text-center"
            ]
            [ div
                [ Attr.class "text-sm lg:text-base"
                ]
                [ brand
                , h1 [ Attr.class "sm:font-semibold py-4 overline" ]
                    [ Html.text "musician. sound designer. creative coder. sound artist."
                    ]
                ]
            , div
                [ Attr.class "sm:self-end text-md lg:text-base content-end md:w-4/12" ]
                [ latestAlbum
                , outlets "text-xl lg:text-2xl my-2 py-2"
                ]
            ]
        ]


brand : Html Msg
brand =
    div
        [ Attr.class "flex flex-row justify-center w-full p-2 lg:p-0"
        , Aria.label "brand logo"
        ]
        [ img
            [ Attr.class "mt-2 md:mt-4 rounded-full border-slate-300 border border-dashed"
            , Attr.src brandImage
            , Attr.alt "Aner Andros"
            ]
            []
        ]


latestAlbum : Html Msg
latestAlbum =
    div
        [ Attr.class "flex flex-col justify-center border-t sm:border-0 border-slate-300 p-2 lg:p-0"
        , Aria.label "latest album player"
        ]
        [ h2 [ Attr.class "sm:font-semibold py-4 md:p-0 underline block md:hidden landscape:hidden" ]
            [ Html.text "latest release"
            ]

        -- , iframe
        --     [ Attr.class "w-full h-96"
        --     , Attr.src latestAlbumLink
        --     , Attr.title latestAlbumTitle
        --     ]
        --     []
        , div
            [ Attr.class "bg-amber-100 shadow-lg rounded-lg w-full h-auto text-left"
            ]
            [ div
                [ Attr.class "flex"
                ]
                [ div
                    [ Attr.class "w-full p-8"
                    ]
                    [ --  div []
                      --     [ img
                      --         [ Attr.class "w-1/2 h-auto rounded"
                      --         , Attr.src "https://tailwindcss.com/img/card-top.jpg"
                      --         , Attr.alt "Album Pic"
                      --         ]
                      --         []
                      --     ]
                      -- ,
                      div
                        [ Attr.class ""
                        ]
                        [ div []
                            [ h1
                                [ Attr.class "text-2xl text-gray-900 font-medium"
                                ]
                                [ Html.text "00h" ]
                            , p
                                [ Attr.class "text-sm text-gray-700 mt-1"
                                ]
                                [ Html.text latestAlbumTitle ]
                            ]
                        ]
                    , div
                        [ Attr.class "flex justify-between items-center mt-8"
                        ]
                        [ div
                            [ Attr.class "text-gray-700"
                            ]
                            [ svg
                                [ SvgAttr.class "w-8 h-8"
                                , SvgAttr.fill "currentColor"
                                , SvgAttr.viewBox "0 0 20 20"
                                ]
                                [ Svg.path
                                    [ SvgAttr.d "M6.59 12.83L4.4 15c-.58.58-1.59 1-2.4 1H0v-2h2c.29 0 .8-.2 1-.41l2.17-2.18 1.42 1.42zM16 4V1l4 4-4 4V6h-2c-.29 0-.8.2-1 .41l-2.17 2.18L9.4 7.17 11.6 5c.58-.58 1.59-1 2.41-1h2zm0 10v-3l4 4-4 4v-3h-2c-.82 0-1.83-.42-2.41-1l-8.6-8.59C2.8 6.21 2.3 6 2 6H0V4h2c.82 0 1.83.42 2.41 1l8.6 8.59c.2.2.7.41.99.41h2z"
                                    ]
                                    []
                                ]
                            ]
                        , div
                            [ Attr.class "text-gray-700"
                            ]
                            [ svg
                                [ SvgAttr.class "w-8 h-8"
                                , SvgAttr.fill "currentColor"
                                , SvgAttr.viewBox "0 0 20 20"
                                ]
                                [ Svg.path
                                    [ SvgAttr.d "M4 5h3v10H4V5zm12 0v10l-9-5 9-5z"
                                    ]
                                    []
                                ]
                            ]
                        , div
                            [ Attr.class "text-slate-100 p-8 rounded-full bg-red-500 shadow-lg"
                            ]
                            [ svg
                                [ SvgAttr.class "w-8 h-8"
                                , SvgAttr.fill "currentColor"
                                , SvgAttr.viewBox "0 0 20 20"
                                ]
                                [ Svg.path
                                    [ SvgAttr.d "M5 4h3v12H5V4zm7 0h3v12h-3V4z"
                                    ]
                                    []
                                ]
                            ]
                        , div
                            [ Attr.class "text-gray-700"
                            ]
                            [ svg
                                [ SvgAttr.class "w-8 h-8"
                                , SvgAttr.fill "currentColor"
                                , SvgAttr.viewBox "0 0 20 20"
                                ]
                                [ Svg.path
                                    [ SvgAttr.d "M13 5h3v10h-3V5zM4 5l9 5-9 5V5z"
                                    ]
                                    []
                                ]
                            ]
                        , div
                            [ Attr.class "text-gray-700"
                            ]
                            [ svg
                                [ SvgAttr.class "w-8 h-8"
                                , SvgAttr.fill "currentColor"
                                , SvgAttr.viewBox "0 0 20 20"
                                ]
                                [ Svg.path
                                    [ SvgAttr.d "M5 4a2 2 0 0 0-2 2v6H0l4 4 4-4H5V6h7l2-2H5zm10 4h-3l4-4 4 4h-3v6a2 2 0 0 1-2 2H6l2-2h7V8z"
                                    ]
                                    []
                                ]
                            ]
                        ]
                    ]
                ]
            , div
                [ Attr.class "mx-8 py-4"
                ]
                [ div
                    [ Attr.class "flex justify-between text-sm text-gray-700"
                    ]
                    [ p []
                        [ Html.text "0:40" ]
                    , p []
                        [ Html.text "4:20" ]
                    ]
                , div
                    [ Attr.class "mt-1"
                    ]
                    [ div
                        [ Attr.class "h-1 bg-gray-800 rounded-full"
                        ]
                        [ div
                            [ Attr.class "w-1/5 h-1 bg-red-500 rounded-full relative"
                            ]
                            []
                        ]
                    ]
                ]
            ]
        ]


outlets : String -> Html Msg
outlets addClassCss =
    div
        [ Aria.label "music outlets social links"
        , Attr.class "flex justify-center justify-items-center"
        ]
        [ ul
            [ Attr.class <| String.append "inline-flex justify-center" addClassCss
            ]
          <|
            List.map
                (\service ->
                    li
                        [ Attr.class "pl-0 px-5"
                        , Aria.label (Tuple.second service)
                        ]
                        [ a
                            [ Attr.href <| Tuple.first service
                            , Attr.target "_blank"
                            , Attr.rel "noopener noreferrer"
                            , Icon.fw
                            ]
                            [ Icon.viewIcon <| returnicon (Tuple.second service) ]
                        ]
                )
                streamingServices
        ]


streamingServices : List ( String, String )
streamingServices =
    [ ( anerSoundCloud, "soundcloud" )
    , ( anerSpotify, "spotify" )
    , ( anerAppleMusic, "apple" )
    , ( anerYoutube, "youtube" )
    , ( anerDeezer, "deezer" )
    ]


returnicon : String -> Icon
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

        _ ->
            Icon.smile



-- DISCOGRAPHY


music : Model -> Html Msg
music model =
    section
        [ Attr.id "music", Attr.class "mx-0 md:mx-2", Aria.label "discography section" ]
        [ div
            [ Attr.class "text-md lg:text-base border-t border-slate-300 text-center md:px-14" ]
            [ h2 [ Attr.class "sm:font-semibold pt-4 mb-4 md:mb-6 underline" ]
                [ Html.text "music"
                ]
            , discog model
            , ul
                [ Attr.class "hidden sm:flex flex-row justify-center text-sm lg:text-base mt-2 py-2"
                ]
              <|
                releaseSelector selectors
            ]
        ]


selectors : List ( String, ReleaseKind )
selectors =
    [ ( "all", All )
    , ( "albums", Albums )
    , ( "eps", Eps )
    , ( "remixes", Remixes )
    , ( "collages", Collages )
    ]


releaseSelector : List ( String, ReleaseKind ) -> List (Html Msg)
releaseSelector list =
    List.map
        (\sel ->
            li
                [ Attr.class "m-2 mt-0 hover:underline hover:underline-offset-4"
                , Aria.label "kind of release selectors"
                , onClick (ChooseRelease (Tuple.second sel))
                ]
                [ a
                    [ Attr.href <| String.append "#" (Tuple.first sel)
                    ]
                    [ Html.text <| Tuple.first sel ]
                ]
        )
        list


discog : Model -> Html Msg
discog model =
    div
        [ Attr.class "grid grid-flow-col auto-cols-max gap-2 overflow-contain overflow-x-scroll overflow-y-hidden snap-mandatory snap-x"
        , Aria.label "all published releases"
        ]
    <|
        renderReleases <|
            case model.showRelease of
                All ->
                    showReleases allReleases

                Albums ->
                    showReleases allAlbums

                Eps ->
                    showReleases allEps

                Remixes ->
                    showReleases allRemixes

                Collages ->
                    showReleases allCollages


renderReleases : List ReleaseData -> List (Html msg)
renderReleases data =
    List.map
        (\i ->
            div
                [ Attr.class "relative snap-always snap-center min-w-fit object-cover cursor-pointer group hover:bg-slate-900" ]
                [ img
                    [ Attr.class "w-full h-auto max-w-xs lg:max-w-md group-hover:opacity-70"
                    , Attr.src <| i.cover
                    , Attr.alt i.name
                    , Attr.title i.name
                    ]
                    []
                , div
                    [ Attr.class "absolute top-1/2 w-full invisible group-hover:visible text-center group-hover:text-white group-hover:text-sm group-hover:lg:text-md font-light"
                    ]
                    [ Html.text i.name ]
                ]
        )
        data



-- ABOUT


about : Html Msg
about =
    -- about (resp. paragraph)
    section
        [ Attr.id "about", Attr.class "mx-0 sm:mx-2", Aria.label "about section" ]
        [ div [ Attr.class "text-md lg:text-base border-t border-slate-300" ]
            [ h2 [ Attr.class "sm:font-semibold pt-4 mb-4 md:mb-0 underline text-center" ]
                [ Html.text "about"
                ]
            , div [ Attr.class "p-0 md:p-4 md:px-4 lg:px-14 text-center md:text-left" ]
                [ p [ Attr.class "p-2 pt-0" ]
                    [ Html.text "Eclectic producer of cinematic ambient, avant-garde, left-field, glitch, and softronica. Fond of improvisation, of the studio as an instrument and of meticulously prepared live shows. While preserving empathy and intuition as key factors when drawing oneiric soundscapes in the making of musical voyages. "
                    , a [ Attr.href "https://vfs.edu/programs/sound-design", Attr.target "_blank", Attr.rel "noopener noreferrer" ] [ Html.text "VFS Alumnus and Sound Design for Visual Media graduate." ]
                    ]
                , p [ Attr.class "p-2" ] [ Html.text "Member of Mi.S.Fu and Sleep Collective. The former: a multifunctional, versatile cross-media laboratory dedicated to mapping, music, 3D, arts. The latter: a collective consisting of talents that had given rise to various Sleep Concert in different Italian locations and with different line-ups." ]
                , p [ Attr.class "p-2" ]
                    [ Html.text "Formerly based in Bristol, UK, Aner Andros has performed at the "
                    , a [ Attr.href "https://cubecinema.com/", Attr.target "_blank", Attr.rel "noopener noreferrer" ] [ Html.text "Cube Cinema Plex" ]
                    , Html.text " and has collaborated with "
                    , a [ Attr.href "https://parallelmadness.com/", Attr.target "_blank", Attr.rel "noopener noreferrer" ] [ Html.text "Parallel Madness" ]
                    , Html.text ". Other noteworthy shows include "
                    , a [ Attr.href "https://crux-events.org/", Attr.target "_blank", Attr.rel "noopener noreferrer" ] [ Html.text "Crux Events in London" ]
                    , Html.text " and the Cronosfera Festival in Italy."
                    ]
                , p [ Attr.class "p-2 pb-4" ]
                    [ Html.text "Aner Andros music is released on his own vanity record label, "
                    , a [ Attr.href gentleWashHome, Attr.target "_blank", Attr.rel "noopener noreferrer" ] [ Html.text "Gentle Wash Records, " ]
                    , Html.text " and it is available on the majority of digital streaming outlets including, but not limited to, "
                    , a [ Attr.href anerSpotify, Attr.target "_blank", Attr.rel "noopener noreferrer" ] [ Html.text "Spotify, " ]
                    , a [ Attr.href anerAppleMusic, Attr.target "_blank", Attr.rel "noopener noreferrer" ] [ Html.text "Apple Music, " ]
                    , a [ Attr.href anerDeezer, Attr.target "_blank", Attr.rel "noopener noreferrer" ] [ Html.text "Deezer, " ]
                    , a [ Attr.href anerSoundCloud, Attr.target "_blank", Attr.rel "noopener noreferrer" ] [ Html.text "SoundCloud Go, " ]
                    , a [ Attr.href anerYoutube, Attr.target "_blank", Attr.rel "noopener noreferrer" ] [ Html.text "and YouTube Music." ]
                    ]
                ]
            ]
        ]



-- LIVE
{-
   live : Html Msg
   live =
       -- live (resp. sort of calendar)
       section [ Attr.id "live", Aria.label "live shows section" ] [ Html.text "live" ]
-}
-- FOOTER


footer_ : Html Msg
footer_ =
    footer [ Attr.id "footer", Aria.label "footer" ]
        [ div [ Attr.class "flex flex-col md:flex-row justify-between border-t border-slate-300 p-4 px-2" ]
            [ p [ Attr.class "text-center text-sm md:text-md" ]
                [ Html.text "© Copyright Aner Andros." ]
            , outlets "text-center text-sm md:text-md"
            , p [ Attr.class "text-center text-sm md:text-md" ]
                [ Html.text "Made with "
                , a
                    [ Attr.href <| VitePluginHelper.asset "../img/love.gif"
                    , Attr.target "_blank"
                    , Attr.rel "noopener noreferrer"
                    ]
                    [ Html.text "Love " ]
                , Html.text "and "
                , a
                    [ Attr.href "https://elm-lang.org/"
                    , Attr.target "_blank"
                    , Attr.rel "noopener noreferrer"
                    ]
                    [ Html.text "Elm." ]
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

        ChooseRelease kind ->
            ( { model | showRelease = kind }
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
