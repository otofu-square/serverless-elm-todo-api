port module Hello.API exposing (main)

import Serverless
import Conn exposing (..)
import Router exposing (router, urlParser)


main : Serverless.Program () () Route () ()
main =
    Serverless.httpApi
        { configDecoder = Serverless.noConfig
        , initialModel = ()
        , parseRoute = urlParser
        , update = Serverless.noSideEffects
        , interop = Serverless.noInterop
        , requestPort = requestPort
        , responsePort = responsePort
        , endpoint = router
        }


port requestPort : Serverless.RequestPort msg


port responsePort : Serverless.ResponsePort msg
