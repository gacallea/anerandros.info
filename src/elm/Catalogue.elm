module Catalogue exposing
    ( AnerAndros
    , GentleWash
    , Release
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

import Dict exposing (Dict)
import VitePluginHelper



-- TYPES


type ReleaseKind
    = All
    | Albums
    | Eps
    | Remixes
    | Collages


type alias Release =
    { kind : ReleaseKind
    , year : String
    , name : String
    , cover : String
    , coverArtist : String
    , label : Maybe String
    , catalog : Maybe String
    , apple : Maybe String
    , soundcloud : Maybe String
    , spotify : Maybe String
    , youtube : Maybe String
    , deezer : Maybe String
    , mixcloud : Maybe String
    , bandcamp : Maybe String
    }


type alias GentleWash =
    { home : String
    , logo : String
    , name : String
    }


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
    }



-- GENTLE WASH


gentlewash : GentleWash
gentlewash =
    { name = "Gentle Wash Records"
    , home = "https://gentlewashrecords.com/"
    , logo = VitePluginHelper.asset "../img/gwr.svg"
    }



-- ANER ANDROS


anerandros : AnerAndros
anerandros =
    { name = "Aner Andros"
    , logo = VitePluginHelper.asset "../img/aa.svg"
    , apple = "https://music.apple.com/artist/aner-andros/1034283469"
    , soundcloud = "https://soundcloud.com/aascloud"
    , spotify = "https://open.spotify.com/artist/00Cg2yZTaYr1EfRZDjStlh"
    , youtube = "https://www.youtube.com/channel/UC2ZkNnT2pHj01jKuj56mJfg"
    , mixcloud = "https://www.mixcloud.com/aasmixes/"
    , deezer = "https://www.deezer.com/artist/8776748"
    , songkick = "https://www.songkick.com/artists/8738984-aner-andros"
    }



-- LATEST ALBUM


latestAlbum : Release
latestAlbum =
    artefactsASb



-- not used just yet, 1) finish the player UI first, 2) the API seems not available anymore...
-- souncloudPlayerAPI : String
-- souncloudPlayerAPI =
--     "https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/playlists/363304199&color=%23ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true&visual=true"
-- RELEASES


allReleases : Dict Int Release
allReleases =
    -- releases are progressively numbered from oldest to newest
    Dict.fromList
        [ ( 100, remapEthosStream )
        , ( 101, eosVolOne )
        , ( 102, liminalTales )
        , ( 103, artefactsASb )
        , ( 104, ispirazione )
        , ( 105, enkefalina )
        ]


derivateReleaseDict : ReleaseKind -> Dict Int Release
derivateReleaseDict kind =
    Dict.values allReleases
        |> List.filter (\rel -> rel.kind == kind)
        |> List.indexedMap Tuple.pair
        |> Dict.fromList


allAlbums : Dict Int Release
allAlbums =
    derivateReleaseDict Albums


allEps : Dict Int Release
allEps =
    derivateReleaseDict Eps


allRemixes : Dict Int Release
allRemixes =
    derivateReleaseDict Remixes


allCollages : Dict Int Release
allCollages =
    derivateReleaseDict Collages


showReleases : Dict Int Release -> List Release
showReleases =
    {-
       newest to oldest: Dict.foldl listTheseReleases []
       oldest to newest: Dict.foldr listTheseReleases []
    -}
    Dict.foldl listTheseReleases []


listTheseReleases : Int -> Release -> List Release -> List Release
listTheseReleases _ rel releases =
    rel :: releases



-- ALBUMS


liminalTales : Release
liminalTales =
    { kind = Albums
    , year = "2016"
    , name = "Liminal Tales"
    , cover = VitePluginHelper.asset "../img/covers/liminal.svg"
    , coverArtist = "https://www.flickr.com/photos/ramocchia/"
    , label = Just "Gentle Wash Records"
    , catalog = Just "GWR0002"
    , apple = Just "https://music.apple.com/album/liminal-tales/1091282352"
    , soundcloud = Just "https://soundcloud.com/aascloud/sets/liminal-tales"
    , spotify = Just "https://open.spotify.com/album/7lXlg36oOH20eHjw0ZJ4gG"
    , youtube = Just "https://www.youtube.com/watch?v=N-HR7dEHIT4&list=OLAK5uy_meDmf2_3kFZJK11JuoDQ0mLZQPPH7NDhc"
    , deezer = Just "https://www.deezer.com/album/12583042"
    , mixcloud = Nothing
    , bandcamp = Nothing
    }


remapEthosStream : Release
remapEthosStream =
    { kind = Albums
    , year = "2015"
    , name = "Remap Ethos Stream"
    , cover = VitePluginHelper.asset "../img/covers/res.svg"
    , coverArtist = "http://www.riccardoarena.org/"
    , label = Just "Gentle Wash Records"
    , catalog = Just "GWR0000"
    , apple = Just "https://music.apple.com/it/album/remap-ethos-stream/1034283468"
    , soundcloud = Just "https://soundcloud.com/aascloud/sets/remap-ethos-stream"
    , spotify = Just "https://open.spotify.com/album/6ezmJo8RpXfyJQNeT40kaJ"
    , youtube = Just "https://www.youtube.com/watch?v=MpBklnNxaXs&list=PLXR_uSsXKC8lJWDk40IswaLbLzfn28y3j"
    , deezer = Just "https://www.deezer.com/album/11098134"
    , mixcloud = Nothing
    , bandcamp = Nothing
    }


artefactsASb : Release
artefactsASb =
    { kind = Eps
    , year = "2017"
    , name = "Artefacts and Sonic Brushstrokes"
    , cover = VitePluginHelper.asset "../img/covers/aasb.svg"
    , coverArtist = "http://trashriotart.tumblr.com/"
    , label = Just "Gentle Wash Records"
    , catalog = Just "GWR0003"
    , apple = Just "https://music.apple.com/album/artefacts-and-sonic-brushstrokes-ep/1281231021"
    , soundcloud = Just "https://soundcloud.com/aascloud/sets/artefacts-and-sonic"
    , spotify = Just "https://open.spotify.com/album/0UTE8yS5IBpV1ov6h08Jwx"
    , youtube = Just "https://www.youtube.com/watch?v=nsgzFFrYer8&list=PLXR_uSsXKC8llnnqiwCN6xMJlWohyU-tS"
    , deezer = Just "https://www.deezer.com/album/47802142"
    , mixcloud = Nothing
    , bandcamp = Nothing
    }


eosVolOne : Release
eosVolOne =
    { kind = Eps
    , year = "2015"
    , name = "Embroidering on Silence Vol. I"
    , cover = VitePluginHelper.asset "../img/covers/eos1.svg"
    , coverArtist = "https://carolrollo.it/"
    , label = Just "Gentle Wash Records"
    , catalog = Just "GWR0001"
    , apple = Just "https://music.apple.com/ca/album/embroidering-on-silence-vol-i/1242232285"
    , soundcloud = Just "https://soundcloud.com/aascloud/sets/embroidering-on-silence-vol-i"
    , spotify = Just "https://open.spotify.com/album/2zQ5hqT9Z2D140rywnebL2"
    , youtube = Just "https://www.youtube.com/watch?v=CeIByiQU4HM"
    , deezer = Just "https://www.deezer.com/album/42391771"
    , mixcloud = Nothing
    , bandcamp = Nothing
    }



-- REMIXES


enkefalina : Release
enkefalina =
    { kind = Remixes
    , year = "2017"
    , name = "Enkefalina (Aner Andros Remix)"
    , cover = VitePluginHelper.asset "../img/covers/enkefalina.svg"
    , coverArtist = "https://carolrollo.it/"
    , label = Just "Nomad Records"
    , bandcamp = Just "https://olim.bandcamp.com/track/enkefalina-aner-andros-remix"
    , catalog = Nothing
    , apple = Nothing
    , soundcloud = Nothing
    , spotify = Nothing
    , youtube = Nothing
    , mixcloud = Nothing
    , deezer = Nothing
    }



-- MIXTAPES, COLLAGES


ispirazione : Release
ispirazione =
    { kind = Collages
    , year = "2016"
    , name = "ISPIRAZIONE"
    , cover = VitePluginHelper.asset "../img/covers/collage.svg"
    , coverArtist = "https://carolrollo.it/"
    , mixcloud = Just "https://www.mixcloud.com/aasmixes/playlists/aas-collages/"
    , label = Nothing
    , catalog = Nothing
    , apple = Nothing
    , soundcloud = Nothing
    , spotify = Nothing
    , youtube = Nothing
    , bandcamp = Nothing
    , deezer = Nothing
    }
