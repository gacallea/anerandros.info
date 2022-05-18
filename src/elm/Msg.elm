module Msg exposing (Msg(..))

import Catalogue exposing (ReleaseKind)



-- MESSAGES


type Msg
    = ChooseRelease ReleaseKind
