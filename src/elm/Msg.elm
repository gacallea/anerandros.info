module Msg exposing (Msg(..))

import Catalogue exposing (ReleaseKind)



-- MESSAGES


type Msg
    = OnResize Int Int
    | ChooseRelease ReleaseKind
