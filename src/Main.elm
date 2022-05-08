module Main exposing (Flags, Model, Msg(..), main)

import Accessibility.Aria as Aria exposing (..)
import Browser
import Browser.Events
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)



-- TYPES


type ReleaseKind
    = All
    | Albums
    | Eps
    | Remixes
    | Collages


type alias ReleaseData =
    { kind : ReleaseKind
    , label : Maybe String
    , catalog : Maybe String
    , year : String
    , name : String
    , cover : String
    , coverArtist : String
    , apple : Maybe String
    , amazon : Maybe String
    , soundcloud : Maybe String
    , spotify : Maybe String
    , youtube : Maybe String
    , mixcloud : Maybe String
    , bandcamp : Maybe String
    }



-- MESSAGES


type Msg
    = OnResize Int Int
    | ChooseRelease ReleaseKind



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



-- LIVE SHOWS


anerSongKick : String
anerSongKick =
    "https://www.songkick.com/artists/8738984-aner-andros"



-- RELEASES
{-
   releases (albums, eps) are progressively numbered:

   3xx - releases
   2xx - collages
   1xx - remixes

   foldl orders them in descending order
-}


allReleases : Dict Int ReleaseData
allReleases =
    Dict.fromList
        [ ( 300, remapEthosStream )
        , ( 301, eosVolOne )
        , ( 302, liminalTales )
        , ( 303, artefactsASb )
        , ( 200, ispirazione )
        , ( 100, enkefalina )
        ]


derivateReleaseDict : ReleaseKind -> Dict Int ReleaseData
derivateReleaseDict kind =
    Dict.values allReleases
        |> List.filter (\rel -> rel.kind == kind)
        |> List.indexedMap Tuple.pair
        |> Dict.fromList


allAlbums : Dict Int ReleaseData
allAlbums =
    derivateReleaseDict Albums


allEps : Dict Int ReleaseData
allEps =
    derivateReleaseDict Eps


allRemixes : Dict Int ReleaseData
allRemixes =
    derivateReleaseDict Remixes


allCollages : Dict Int ReleaseData
allCollages =
    derivateReleaseDict Collages


liminalTales : ReleaseData
liminalTales =
    { kind = Albums
    , label = Just "Gentle Wash Records"
    , catalog = Just "GWR0002"
    , year = "2016"
    , name = "Liminal Tales"
    , cover = "https://placekitten.com/420"
    , coverArtist = "https://www.flickr.com/photos/ramocchia/"
    , apple = Just "https://music.apple.com/album/liminal-tales/1091282352"
    , amazon = Just "https://www.amazon.co.uk/Liminal-Tales-Aner-Andros/dp/B01CQHFGNU"
    , soundcloud = Just "https://soundcloud.com/aascloud/sets/liminal-tales"
    , spotify = Just "https://open.spotify.com/album/7lXlg36oOH20eHjw0ZJ4gG"
    , youtube = Just "https://www.youtube.com/watch?v=N-HR7dEHIT4&list=OLAK5uy_meDmf2_3kFZJK11JuoDQ0mLZQPPH7NDhc"
    , mixcloud = Nothing
    , bandcamp = Nothing
    }


remapEthosStream : ReleaseData
remapEthosStream =
    { kind = Albums
    , label = Just "Gentle Wash Records"
    , catalog = Just "GWR0000"
    , year = "2015"
    , name = "Remap Ethos Stream"
    , cover = "https://placekitten.com/420"
    , coverArtist = "http://www.riccardoarena.org/"
    , apple = Just "https://music.apple.com/it/album/remap-ethos-stream/1034283468"
    , amazon = Just "https://www.amazon.co.uk/Remap-Ethos-Stream-Aner-Andros/dp/B014MFIF28"
    , soundcloud = Just "https://soundcloud.com/aascloud/sets/remap-ethos-stream"
    , spotify = Just "https://open.spotify.com/album/6ezmJo8RpXfyJQNeT40kaJ"
    , youtube = Just "https://www.youtube.com/watch?v=MpBklnNxaXs&list=PLXR_uSsXKC8lJWDk40IswaLbLzfn28y3j"
    , mixcloud = Nothing
    , bandcamp = Nothing
    }


artefactsASb : ReleaseData
artefactsASb =
    { kind = Eps
    , label = Just "Gentle Wash Records"
    , catalog = Just "GWR0003"
    , year = "2017"
    , name = "Artefacts and Sonic Brushstrokes"
    , cover = "https://placekitten.com/420"
    , coverArtist = "http://trashriotart.tumblr.com/"
    , apple = Just "https://music.apple.com/album/artefacts-and-sonic-brushstrokes-ep/1281231021"
    , amazon = Just "https://www.amazon.com/Artefacts-Sonic-Brushstrokes-Aner-Andros/dp/B075M7SFZL"
    , soundcloud = Just "https://soundcloud.com/aascloud/sets/artefacts-and-sonic"
    , spotify = Just "https://open.spotify.com/album/0UTE8yS5IBpV1ov6h08Jwx"
    , youtube = Just "https://www.youtube.com/watch?v=nsgzFFrYer8&list=PLXR_uSsXKC8llnnqiwCN6xMJlWohyU-tS"
    , mixcloud = Nothing
    , bandcamp = Nothing
    }


eosVolOne : ReleaseData
eosVolOne =
    { kind = Eps
    , label = Just "Gentle Wash Records"
    , catalog = Just "GWR0001"
    , year = "2015"
    , name = "Embroidering on Silence Vol. I"
    , cover = "https://placekitten.com/420"
    , coverArtist = "https://carolrollo.it/"
    , apple = Just "https://music.apple.com/ca/album/embroidering-on-silence-vol-i/1242232285"
    , amazon = Just "https://www.amazon.com/Embroidering-Silence-Vol-Aner-Andros/dp/B072634MT3/143-8572494-9262537"
    , soundcloud = Just "https://soundcloud.com/aascloud/sets/embroidering-on-silence-vol-i"
    , spotify = Just "https://open.spotify.com/album/2zQ5hqT9Z2D140rywnebL2"
    , youtube = Just "https://www.youtube.com/watch?v=CeIByiQU4HM"
    , mixcloud = Nothing
    , bandcamp = Nothing
    }


enkefalina : ReleaseData
enkefalina =
    { kind = Remixes
    , label = Just "Nomad Records"
    , catalog = Nothing
    , year = "2017"
    , name = "Enkefalina (Aner Andros Remix)"
    , cover = "https://placekitten.com/420"
    , coverArtist = "https://carolrollo.it/"
    , apple = Nothing
    , amazon = Nothing
    , soundcloud = Nothing
    , spotify = Nothing
    , youtube = Nothing
    , mixcloud = Nothing
    , bandcamp = Just "https://olim.bandcamp.com/track/enkefalina-aner-andros-remix"
    }


ispirazione : ReleaseData
ispirazione =
    { kind = Collages
    , label = Nothing
    , catalog = Nothing
    , year = "2016"
    , name = "ISPIRAZIONE"
    , cover = "https://placekitten.com/420"
    , coverArtist = "https://carolrollo.it/"
    , apple = Nothing
    , amazon = Nothing
    , soundcloud = Nothing
    , spotify = Nothing
    , youtube = Nothing
    , mixcloud = Just "https://www.mixcloud.com/aasmixes/playlists/aas-collages/"
    , bandcamp = Nothing
    }



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
        [ class "container mx-auto max-w-7xl"
        , Aria.label "main content"
        ]
        [ header_
        , hero
        , music model
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
                    [ class "p-2 hover:underline hover:underline-offset-4"
                    , href <| Tuple.first lnk
                    , target (target_ lnk)
                    , rel "noopener noreferrer"
                    ]
                    [ text <| Tuple.second lnk
                    ]
                ]
        )
        list



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
                [ class "text-sm lg:text-base"
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
        [ img [ src "https://placekitten.com/480", alt "Aner Andros" ] []
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


outlets : Html Msg
outlets =
    div [ Aria.label "music outlets social links" ]
        [ ul
            [ class "inline-flex py-2 justify-center text-lg lg:text-xl"
            ]
          <|
            socialIcons streamingServices
        ]


streamingServices : List ( String, String )
streamingServices =
    [ ( anerSoundCloud, "soundcloud" )
    , ( anerSpotify, "spotify" )
    , ( anerAppleMusic, "apple" )
    , ( anerYoutube, "youtube" )
    , ( anerDeezer, "deezer" )
    ]


socialIcons : List ( String, String ) -> List (Html msg)
socialIcons list =
    List.map
        (\soc ->
            li
                [ class "pl-0 px-5"
                , Aria.label (Tuple.second soc)
                ]
                [ a
                    [ href <| Tuple.first soc
                    , target "_blank"
                    , rel "noopener noreferrer"
                    ]
                    [ i
                        [ class <| String.append "bx-fw bx bxl-" (Tuple.second soc)
                        ]
                        []
                    ]
                ]
        )
        list



-- DISCOGRAPHY


music : Model -> Html Msg
music model =
    section
        [ id "music", class "mt-2 mx-1 md:mx-2", Aria.label "discography section" ]
        [ div
            [ class "text-md lg:text-base border-t border-slate-300 text-center" ]
            [ h2 [ class "sm:font-semibold pt-4 mb-4 underline" ]
                [ text "music"
                ]
            , discog model
            , ul
                [ class "hidden sm:flex flex-row justify-center text-sm lg:text-base my-4 sm:mr-4"
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
                [ class "px-2 hover:underline hover:underline-offset-4"
                , Aria.label "kind of release selectors"
                , onClick (ChooseRelease (Tuple.second sel))
                ]
                [ a
                    [ href <| String.append "#" (Tuple.first sel)
                    ]
                    [ text <| Tuple.first sel ]
                ]
        )
        list


discog : Model -> Html Msg
discog model =
    ul
        [ class "flex flex-row justify-between p-2 m-2"
        , Aria.label "all published releases"
        ]
    <|
        release <|
            case model.showRelease of
                All ->
                    Dict.foldl showReleases [] allReleases

                Albums ->
                    Dict.foldl showReleases [] allAlbums

                Eps ->
                    Dict.foldl showReleases [] allEps

                Remixes ->
                    Dict.foldl showReleases [] allRemixes

                Collages ->
                    Dict.foldl showReleases [] allCollages


showReleases : Int -> ReleaseData -> List ReleaseData -> List ReleaseData
showReleases _ rel releases =
    rel :: releases


release : List ReleaseData -> List (Html msg)
release data =
    List.map
        (\i ->
            li []
                [ img
                    [ src i.cover
                    , alt i.name
                    , title i.name
                    ]
                    []
                ]
        )
        data



-- ABOUT


about : Html Msg
about =
    -- about (resp. paragraph)
    section
        [ id "about", class "mt-2 mx-1 md:mx-2", Aria.label "about section" ]
        [ div [ class "text-md lg:text-base border-t border-slate-300" ]
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
        [ div [ class "text-sm md:text-sm border-t border-slate-300 py-4 text-center" ]
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
