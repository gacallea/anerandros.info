module Catalogue exposing
    ( ReleaseData
    , ReleaseKind(..)
    , allAlbums
    , allCollages
    , allEps
    , allReleases
    , allRemixes
    , anerAppleMusic
    , anerDeezer
    , anerLogo
    , anerSongKick
    , anerSoundCloud
    , anerSpotify
    , anerYoutube
    , gentleWashHome
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



-- CONSTANTS


latestAlbum : ReleaseData
latestAlbum =
    artefactsASb



-- souncloudPlayerAPI : String
-- souncloudPlayerAPI =
-- not used just yet, need to finish the player UI first
--     "https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/playlists/363304199&color=%23ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true&visual=true"
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



-- GENTLE WASH, ANER AND ALBUMS DATA


gentleWashHome : String
gentleWashHome =
    "https://gentlewashrecords.com/"



-- ALBUMS


liminalTales : ReleaseData
liminalTales =
    { kind = Albums
    , label = Just "Gentle Wash Records"
    , catalog = Just "GWR0002"
    , year = "2016"
    , name = "Liminal Tales"
    , cover = liminalCover
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
    , cover = remapCover
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
    , cover = aasbCover
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
    , cover = eosVolOneCover
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
    , cover = enkefalinaCover
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
    , cover = ispirazioneCover
    , coverArtist = "https://carolrollo.it/"
    , apple = Nothing
    , amazon = Nothing
    , soundcloud = Nothing
    , spotify = Nothing
    , youtube = Nothing
    , mixcloud = Just "https://www.mixcloud.com/aasmixes/playlists/aas-collages/"
    , bandcamp = Nothing
    }



-- IMAGES


anerLogo : String
anerLogo =
    VitePluginHelper.asset "../img/aa.svg"


liminalCover : String
liminalCover =
    VitePluginHelper.asset "../img/covers/liminal.svg"


remapCover : String
remapCover =
    VitePluginHelper.asset "../img/covers/res.svg"


aasbCover : String
aasbCover =
    VitePluginHelper.asset "../img/covers/aasb.svg"


eosVolOneCover : String
eosVolOneCover =
    VitePluginHelper.asset "../img/covers/eos1.svg"


enkefalinaCover : String
enkefalinaCover =
    VitePluginHelper.asset "../img/covers/enkefalina.svg"


ispirazioneCover : String
ispirazioneCover =
    VitePluginHelper.asset "../img/covers/collage.svg"



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
