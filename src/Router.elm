module Router exposing (..)

import Conn exposing (..)
import Json.Encode
import Serverless.Conn exposing (jsonBody, method, respond, route)
import Serverless.Conn.Request exposing (Method(..))
import Todo exposing (dummyTodos, getTodoById, todoEncoder, todosEncoder)
import UrlParser exposing ((</>), map, oneOf, s, string, top)


errorEncoder : String -> Json.Encode.Value
errorEncoder message =
    Json.Encode.object
        [ ( "error", Json.Encode.string message )
        ]


urlParser : String -> Maybe Route
urlParser =
    UrlParser.parseString <|
        oneOf
            [ map TodoIndex (s "todos")
            , map TodoShow (s "todos" </> string)
            ]


router : Conn -> ( Conn, Cmd msg )
router conn =
    case
        ( method conn
        , route conn
        )
    of
        ( GET, TodoIndex ) ->
            respond ( 200, jsonBody <| todosEncoder dummyTodos ) conn

        ( GET, TodoShow id ) ->
            case (getTodoById id dummyTodos) of
                Just todo ->
                    respond ( 200, jsonBody <| todoEncoder <| todo ) conn

                Nothing ->
                    respond ( 404, jsonBody <| errorEncoder <| "Not Found id: " ++ id ) conn

        _ ->
            respond ( 405, jsonBody <| errorEncoder "Method not allowed" ) conn
