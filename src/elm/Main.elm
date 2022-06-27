module Main exposing (Model, Msg, main)

import Accessibility.Aria as Aria
import Browser
import Catalogue
    exposing
        ( Release
        , ReleaseKind(..)
        , allAlbums
        , allCollages
        , allEps
        , allReleases
        , allRemixes
        , anerandros
        , gentlewash
        , latestAlbum
        , showReleases
        )
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
import VitePluginHelper



-- CONSTANTS


bgGradient : String
bgGradient =
    "bg-gradient-to-r from-indigo-500 to-purple-500"


navLinks : List ( String, String )
navLinks =
    [ ( "#top", "home" )
    , ( "#music", "music" )
    , ( "#about", "about" )
    , ( anerandros.songkick, "live" )
    ]


latestAlbumOutlets : List ( String, String )
latestAlbumOutlets =
    [ ( Maybe.withDefault "" latestAlbum.soundcloud, "soundcloud" )
    , ( Maybe.withDefault "" latestAlbum.spotify, "spotify" )
    , ( Maybe.withDefault "" latestAlbum.apple, "apple" )
    , ( Maybe.withDefault "" latestAlbum.youtube, "youtube" )
    , ( Maybe.withDefault "" latestAlbum.deezer, "deezer" )
    ]


anerAndrosOutlets : List ( String, String )
anerAndrosOutlets =
    [ ( anerandros.soundcloud, "soundcloud" )
    , ( anerandros.spotify, "spotify" )
    , ( anerandros.apple, "apple" )
    , ( anerandros.youtube, "youtube" )
    , ( anerandros.deezer, "deezer" )
    ]


heroCloudWords : List String
heroCloudWords =
    [ "Sound Design"
    , "Collages"
    , "Softronica"
    , "Mixtapes"
    , "Oneiric"
    , "Story Telling"
    , "Remixes"
    , "Moon Musick"
    , "Left-Field"
    , "Cinematic Ambient"
    , "Soundscapes"
    , "Avant-Garde"
    , "Creative Coding"
    , "Glitch"
    , "Ambient Music"
    ]


selectors : List ( String, ReleaseKind )
selectors =
    [ ( "all", All )
    , ( "albums", Albums )
    , ( "eps", Eps )
    , ( "remixes", Remixes )
    , ( "collages", Collages )
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

        _ ->
            Icon.smile



-- MESSAGES


type Msg
    = ChooseRelease ReleaseKind



-- MODEL


type alias Model =
    { showRelease : ReleaseKind
    }



-- INIT


init : ( Model, Cmd Msg )
init =
    ( { showRelease = All
      }
    , Cmd.none
    )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChooseRelease kind ->
            ( { model | showRelease = kind }
            , Cmd.none
            )



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- VIEW


view : Model -> Html Msg
view model =
    main_
        [ Aria.label "main content"
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
        [ Attr.class <|
            String.append
                """
                    flex flex-row justify-center sm:justify-between
                    sticky top-0 z-30
                    text-white text-md md:text-lg
                    shadow-md sm:shadow-inherit
                """
                bgGradient
        , Aria.label "main header"
        ]
        [ navLogo
        , navbar
        ]


navLogo : Html Msg
navLogo =
    div
        [ Attr.class "hidden sm:inline-flex sm:p-4"
        , Aria.label "brand name"
        ]
        [ ul
            [ Attr.class "inline-flex"
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
            [ Attr.class "inline-flex my-2 sm:my-0 sm:p-4"
            ]
          <|
            navLink navLinks
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
        [ Attr.id "hero", Attr.class <| bgGradient, Aria.label "hero section" ]
        [ div
            [ Attr.class "mx-0 md:mx-14 flex flex-col sm:justify-between text-center text-neutral-100"
            ]
            [ div
                [ Attr.class "text-sm lg:text-base relative"
                ]
                [ bigFaceLogo
                , h1 [ Attr.class "sm:font-medium pb-4 text-white text-md md:text-lg" ]
                    [ Html.text "musician. sound designer. creative coder. sound artist."
                    ]
                , wordsCloud heroCloudWords
                ]
            ]
        ]


bigFaceLogo : Html Msg
bigFaceLogo =
    div
        [ Attr.class "flex flex-row justify-center w-full p-2 sm:pb-4 md:pt-0"
        , Aria.label "brand logo"
        ]
        [ img
            [ Attr.class "aspect-square w-full sm:w-1/3 h-auto my-2 md:my-4 rounded-full border-slate-300 border border-dashed bg-indigo-100 opacity-90 z-20"
            , Attr.src anerandros.logo
            , Attr.alt "Aner Andros"
            ]
            []
        ]


wordsCloud : List String -> Html Msg
wordsCloud list =
    div [ Attr.class "absolute top-8 clear-left w-full -z-10" ]
        [ ul
            [ Attr.class "sm:font-medium pl-0 hidden sm:flex flex-wrap justify-around items-center leading-10"
            , Aria.roleDescription "purely aestethic"
            , Aria.label "words cloud"
            ]
          <|
            List.map
                (\word ->
                    li
                        [ Attr.class "pt-1 pb-8 text-6xl" ]
                        [ Html.text <| word
                        ]
                )
                list
        ]



-- DISCOGRAPHY


music : Model -> Html Msg
music model =
    section
        [ Attr.id "music", Attr.class "container mx-auto max-w-6xl", Aria.label "discography section" ]
        [ div
            [ Attr.class "text-md lg:text-base text-center md:px-14" ]
            [ ul
                [ Attr.class "flex flex-row justify-center mt-2 py-2 font-medium"
                ]
              <|
                releaseSelector selectors
            , discog model
            , latestAlbumPlayer
            ]
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
        [ Attr.class "grid grid-flow-col auto-cols-max gap-1 overflow-contain overflow-x-scroll overflow-y-hidden snap-mandatory snap-x mx-0 sm:mx-2"
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


renderReleases : List Release -> List (Html msg)
renderReleases data =
    List.map
        (\i ->
            div
                [ Attr.class "relative snap-always snap-center min-w-fit object-cover cursor-pointer group hover:bg-slate-900" ]
                [ img
                    [ Attr.class "w-64 h-64 sm:w-60 sm:h-60 group-hover:opacity-70"
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


outlets : List ( String, String ) -> String -> String -> Html Msg
outlets outletKind ulAdditionalCss liPadding =
    div
        [ Aria.label "music outlets social links"
        , Attr.class "flex justify-center justify-items-center"
        ]
        [ ul
            [ Attr.class "inline-flex justify-center"
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


latestAlbumPlayer : Html Msg
latestAlbumPlayer =
    div
        [ Attr.class "flex flex-col justify-center pb-8 text-base"
        , Aria.label "latest album player"
        ]
        [ p [ Attr.class "font-medium py-4 underline text-md" ]
            [ Html.text "latest release"
            ]
        , div
            [ Attr.class "mx-8 sm:mx-2 h-auto text-left max-w-md sm:max-w-full bg-white rounded-xl sm:rounded-none shadow-md overflow-hidden"
            ]
            [ div
                [ Attr.class "sm:flex"
                ]
                [ div
                    [ Attr.class "sm:shrink-0"
                    ]
                    [ img
                        [ Attr.class "h-56 w-full object-cover md:h-52 md:w-52"
                        , Attr.src latestAlbum.cover
                        , Attr.alt latestAlbum.name
                        , Attr.title latestAlbum.name
                        ]
                        []
                    ]
                , div
                    [ Attr.class "w-4/5 m-auto py-4 sm:py-2 sm:px-8"
                    ]
                    [ h1
                        [ Attr.class "block text-lg sm:text-xl leading-tight font-medium text-gray-900"
                        ]
                        [ Html.text "00h" ]
                    , p
                        [ Attr.class "text-sm sm:text-base text-gray-700 my-2"
                        ]
                        [ Html.text latestAlbum.name ]
                    , div []
                        [ div
                            [ Attr.class "flex justify-around items-center text-gray-700 text-xl mt-6 sm:mt-4 w-10/12 sm:w-7/12 lg:w-4/12 mx-auto"
                            ]
                            [ div
                                []
                                [ Icon.view Icon.shuffle
                                ]
                            , div
                                []
                                [ Icon.view Icon.backward
                                ]
                            , div
                                [ Attr.class "text-5xl text-red-500" ]
                                [ --Icon.view Icon.playCircle
                                  Icon.view Icon.pauseCircle
                                ]
                            , div
                                []
                                [ Icon.view Icon.forward
                                ]
                            , div
                                []
                                [ Icon.view Icon.repeat
                                ]
                            ]
                        , div
                            [ Attr.class "flex justify-between text-sm text-gray-700"
                            ]
                            [ p []
                                [ Html.text "0:42" ]
                            , p []
                                [ Html.text "4:20" ]
                            ]
                        , div
                            []
                            [ div
                                [ Attr.class "h-1 bg-gray-800 rounded-full"
                                ]
                                [ div
                                    [ Attr.class "w-1/5 h-1 bg-red-500 rounded-full relative"
                                    ]
                                    []
                                ]
                            ]
                        , outlets latestAlbumOutlets "text-gray-700 text-lg md:text-base mt-4" "px-2"
                        ]
                    ]
                ]
            ]
        ]



-- ABOUT


about : Html Msg
about =
    section
        [ Attr.id "about", Attr.class "container mx-auto max-w-6xl", Aria.label "about section" ]
        [ div [ Attr.class "border-t border-slate-300 md:border-0 md:px-14" ]
            [ h2 [ Attr.class "font-medium pt-4 mb-4 md:mb-0 md:pt-0 underline text-center text-base" ]
                [ Html.text "about"
                ]
            , div [ Attr.class "p-0 px-4 md:py-4 md:px-0 text-center sm:text-left text-base" ]
                [ p [ Attr.class "p-2 pt-0" ]
                    [ Html.text "Eclectic non-musician and producer of cinematic ambient, avant-garde, left-field, glitch, and softronica. Fond of improvisation, of the studio as an instrument and of meticulously prepared live shows. While preserving empathy and intuition as key factors, when drawing oneiric soundscapes into a story, in the making of musical voyages. "
                    , a [ Attr.href "https://vfs.edu/programs/sound-design", Attr.target "_blank", Attr.rel "noopener noreferrer" ] [ Html.text "VFS Alumnus and Sound Design for Visual Media graduate." ]
                    ]
                , p [ Attr.class "p-2" ] [ Html.text "Member of Mi.S.Fu and Sleep Collective. The former: a multifunctional, versatile cross-media laboratory dedicated to mapping, music, 3D, arts. The latter: a collective consisting of talents that had given rise to various Sleep Concert in different Italian locations and with different line-ups." ]
                , p [ Attr.class "p-2" ]
                    [ Html.text "Formerly based in Bristol, UK, Aner Andros has performed at the "
                    , a [ Attr.href "https://cubecinema.com/", Attr.target "_blank", Attr.rel "noopener noreferrer" ] [ Html.text "Cube Cinema Plex" ]
                    , Html.text " and has collaborated with "
                    , a [ Attr.href "https://parallelmadness.com/", Attr.target "_blank", Attr.rel "noopener noreferrer" ] [ Html.text "Parallel Madness. " ]
                    , Html.text "Notable shows include: "
                    , a [ Attr.href "https://www.cubecinema.com/id/8295/", Attr.target "_blank", Attr.rel "noopener noreferrer" ] [ Html.text "'100 Years of DADA' " ]
                    , Html.text "celebratory event at the Cube Cinema, and bespoke lives at "
                    , a [ Attr.href "https://crux-events.org/", Attr.target "_blank", Attr.rel "noopener noreferrer" ] [ Html.text "Crux Events in London, " ]
                    , Html.text "and Cronosfera Festival in Italy."
                    ]
                , p [ Attr.class "p-2 pb-4" ]
                    [ Html.text "Aner Andros releases his music on his own vanity record label, "
                    , a [ Attr.href gentlewash.home, Attr.target "_blank", Attr.rel "noopener noreferrer" ] [ Html.text <| String.append gentlewash.name ". " ]
                    , Html.text "His music is available on the majority of digital streaming outlets including, but not limited to, Spotify, Apple Music, Deezer, SoundCloud Go, Amazon Music, and YouTube Music."
                    ]
                , outlets anerAndrosOutlets "text-center text-md lg:text-lg mb-4 md:mb-0" "px-2"
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
        [ div [ Attr.class "border-t border-slate-300 p-4 text-center text-xs md:text-sm" ]
            [ p []
                [ Html.text "© Copyright Aner Andros. All Rights Reserved." ]
            , p []
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
