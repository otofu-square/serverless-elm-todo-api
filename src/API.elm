port module Hello.API exposing (main)

import Serverless
import Serverless.Conn exposing (respond, textBody)


main : Serverless.Program () () () () ()
main =
    Serverless.httpApi
        { configDecoder = Serverless.noConfig
        , initialModel = ()
        , parseRoute = Serverless.noRoutes
        , update = Serverless.noSideEffects
        , interop = Serverless.noInterop
        , endpoint = respond ( 200, textBody "Hello World" )
        , requestPort = requestPort
        , responsePort = responsePort
        }


port requestPort : Serverless.RequestPort msg


port responsePort : Serverless.ResponsePort msg
