module Main exposing (Flags, Model, Msg(..), ReleaseKind, main)

import Accessibility.Aria as Aria
import Browser
import Browser.Events
import Dict exposing (Dict)
import Html
    exposing
        ( Html
        , a
        , div
        , footer
        , h1
        , h2
        , h3
        , header
        , i
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
import Svg exposing (svg)
import Svg.Attributes as SvgAttr



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
   releases are progressively numbered from oldest to newest

   foldl orders them in descending order
   foldr orders them in ascending order

   pick your fav in the showReleases function
-}


allReleases : Dict Int ReleaseData
allReleases =
    Dict.fromList
        [ ( 100, remapEthosStream )
        , ( 101, eosVolOne )
        , ( 102, liminalTales )
        , ( 103, artefactsASb )
        , ( 104, ispirazione )
        , ( 105, enkefalina )
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
    , cover = "https://placekitten.com/240"
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
    , cover = "https://placekitten.com/240"
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
    , cover = "https://placekitten.com/240"
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
    , cover = "https://placekitten.com/240"
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
    , cover = "https://placekitten.com/240"
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
    , cover = "https://placekitten.com/240"
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
        [ Attr.class "container mx-auto max-w-7xl"
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
        [ Attr.class "flex flex-row justify-center sm:justify-between sticky top-0 bg-white md:mb-4 md:py-2 border-b border-slate-300"
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
        [ Attr.id "hero", Attr.class "mx-0 sm:mx-2 lg:m-8", Aria.label "hero section" ]
        [ div
            [ Attr.class "flex flex-col sm:flex-row sm:justify-between text-center px-2 lg:px-8"
            ]
            [ h2
                [ Attr.class "sm:font-bold py-2 block underline md:hidden landscape:hidden" ]
                [ Html.text "aner andros"
                ]
            , div
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
                , outlets
                ]
            ]
        ]


brand : Html Msg
brand =
    div
        [ Attr.class "flex flex-row justify-center w-full"
        , Aria.label "brand logo"
        ]
        [ img [ Attr.class "rounded-none md:rounded-full", Attr.src "https://placekitten.com/480", Attr.alt "Aner Andros" ] []
        ]


latestAlbum : Html Msg
latestAlbum =
    div
        [ Attr.class "flex flex-col justify-center border-t md:border-0 border-slate-300"
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
                            [ h3
                                [ Attr.class "text-2xl text-gray-900 font-medium"
                                ]
                                [ Html.text "00h" ]
                            , p
                                [ Attr.class "text-sm text-gray-500 mt-1"
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


outlets : Html Msg
outlets =
    div [ Aria.label "music outlets social links" ]
        [ ul
            [ Attr.class "inline-flex my-2 py-2 justify-center text-lg lg:text-xl"
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
                [ Attr.class "pl-0 px-5"
                , Aria.label (Tuple.second soc)
                ]
                [ a
                    [ Attr.href <| Tuple.first soc
                    , Attr.target "_blank"
                    , Attr.rel "noopener noreferrer"
                    ]
                    [ i
                        [ Attr.class <| String.append "bx-fw bx bxl-" (Tuple.second soc)
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
        [ Attr.id "music", Attr.class "mt-2 mx-0 md:mx-2", Aria.label "discography section" ]
        [ div
            [ Attr.class "text-md lg:text-base border-t border-slate-300 text-center md:px-14" ]
            [ h2 [ Attr.class "sm:font-semibold pt-4 mb-4 md:mb-6 underline" ]
                [ Html.text "music"
                ]
            , discog model
            , ul
                [ Attr.class "hidden sm:flex flex-row justify-center text-sm lg:text-base my-4 sm:mr-4"
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
                [ Attr.class "px-2 hover:underline hover:underline-offset-4"
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
        [ Attr.class "grid grid-flow-col gap-2 auto-cols-max overflow-contain overflow-x-scroll overflow-y-hidden snap-mandatory snap-x"
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
                [ Attr.class "relative snap-always snap-center min-w-fit object-cover cursor-pointer group" ]
                [ img
                    [ Attr.class "max-w-xs lg:max-w-sm 2xl:max-w-full h-auto group-hover:opacity-70"
                    , Attr.src i.cover
                    , Attr.alt i.name
                    , Attr.title i.name
                    ]
                    []

                -- this is how I would do it in parceljs if sharp worked
                --   node "picture"
                --     []
                --     [ source
                --         [ Attr.attribute "srcset" <| String.append i.cover "as=avif&?width=800"
                --         , Attr.type_ "image/avif"
                --         ]
                --         []
                --     , source
                --         [ Attr.attribute "srcset" <| String.append i.cover "?as=webp&width=800"
                --         , Attr.type_ "image/webp"
                --         ]
                --         []
                --     , source
                --         [ Attr.attribute "srcset" <| String.append i.cover "?width=800"
                --         , Attr.type_ "image/jpeg"
                --         ]
                --         []
                --     , img
                --         [ Attr.src <| String.append i.cover "?width=200"
                --         , Attr.alt i.name
                --         , Attr.title i.name
                --         ]
                --         []
                --     ]
                , div
                    [ Attr.class "absolute bottom-0 bg-zinc-200 bg-opacity-50 group-hover:bg-zinc-900 group-hover:bg-opacity-60 w-full h-1/3 py-4 md:py-8 text-neutral-900 group-hover:text-gray-100 text-center text-xs md:text-sm font-light"
                    ]
                    [ Html.text i.name ]
                ]
        )
        data


showReleases : Dict Int ReleaseData -> List ReleaseData
showReleases =
    {-
       to order them in descending order:
        - Dict.foldl listTheseReleases []
       to order them in ascending order:
        - Dict.foldr listTheseReleases []
    -}
    Dict.foldl listTheseReleases []


listTheseReleases : Int -> ReleaseData -> List ReleaseData -> List ReleaseData
listTheseReleases _ rel releases =
    rel :: releases



-- ABOUT


about : Html Msg
about =
    -- about (resp. paragraph)
    section
        [ Attr.id "about", Attr.class "mt-2 mx-0 sm:mx-2", Aria.label "about section" ]
        [ div [ Attr.class "text-md lg:text-base border-t border-slate-300" ]
            [ h2 [ Attr.class "sm:font-semibold pt-4 mb-4 md:mb-0 underline text-center" ]
                [ Html.text "about"
                ]
            , div [ Attr.class "bg-lime-200 md:bg-inherit rounded-lg m-2 lg:m-0 p-4 mb-4 md:px-8 lg:px-14 md:mb-8 text-center md:text-left" ]
                [ p [ Attr.class "p-2" ]
                    [ Html.text "Eclectic producer of cinematic ambient, avant-garde, left-field, glitch, and softronica. Fond of improvisation, of the studio as an instrument and of meticulously prepared live shows. While preserving empathy and intuition as key factors when drawing oneiric soundscapes in the making of musical voyages. "
                    , a
                        [ Attr.href "https://vfs.edu/programs/sound-design"
                        , Attr.target "_blank"
                        , Attr.rel "noopener noreferrer"
                        ]
                        [ Html.text "VFS Alumnus and Sound Design for Visual Media graduate." ]
                    ]
                , p [ Attr.class "p-2" ] [ Html.text "Member of Mi.S.Fu and Sleep Collective. The former: a multifunctional, versatile cross-media laboratory dedicated to mapping, music, 3D, arts. The latter: a collective consisting of talents that had given rise to various Sleep Concert in different Italian locations and with different line-ups." ]
                , p [ Attr.class "p-2" ]
                    [ Html.text "Formerly based in Bristol, UK, Aner Andros has performed at the "
                    , a
                        [ Attr.href "https://cubecinema.com/"
                        , Attr.target "_blank"
                        , Attr.rel "noopener noreferrer"
                        ]
                        [ Html.text "Cube Cinema Plex" ]
                    , Html.text " and has collaborated with "
                    , a
                        [ Attr.href "https://parallelmadness.com/"
                        , Attr.target "_blank"
                        , Attr.rel "noopener noreferrer"
                        ]
                        [ Html.text "Parallel Madness" ]
                    , Html.text ". Other noteworthy shows include "
                    , a
                        [ Attr.href "https://crux-events.org/"
                        , Attr.target "_blank"
                        , Attr.rel "noopener noreferrer"
                        ]
                        [ Html.text "Crux Events in London" ]
                    , Html.text " and the Cronosfera Festival in Italy."
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
    footer [ Attr.id "footer", Attr.class "mt-2", Aria.label "footer" ]
        [ div [ Attr.class "text-sm md:text-sm border-t border-slate-300 py-4 text-center" ]
            [ p []
                [ Html.text "© Copyright Aner Andros. All Rights Reserved." ]
            , p []
                [ Html.text "Made with love and "
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
