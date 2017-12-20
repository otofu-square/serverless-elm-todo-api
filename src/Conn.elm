module Conn exposing (..)

import Serverless.Conn


type Route
    = TodoIndex
    | TodoShow String


type alias Conn =
    Serverless.Conn.Conn () () Route ()
