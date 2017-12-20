module Todo exposing (..)

import Json.Decode exposing (Decoder, decodeValue, int, string, bool)
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode


dummyTodos : List Todo
dummyTodos =
    [ { id = "1", title = "This is todo1", finished = False }
    , { id = "2", title = "This is todo2", finished = True }
    , { id = "3", title = "This is todo3", finished = False }
    ]


type alias Todo =
    { id : String
    , title : String
    , finished : Bool
    }


todoDecoder : Decoder Todo
todoDecoder =
    decode Todo
        |> required "id" string
        |> required "title" string
        |> required "finished" bool


todoEncoder : Todo -> Json.Encode.Value
todoEncoder todo =
    Json.Encode.object
        [ ( "id", Json.Encode.string todo.id )
        , ( "title", Json.Encode.string todo.title )
        , ( "finished", Json.Encode.bool todo.finished )
        ]


todosEncoder : List Todo -> Json.Encode.Value
todosEncoder todos =
    Json.Encode.list (List.map (\todo -> todoEncoder todo) todos)


getTodoById : String -> List Todo -> Maybe Todo
getTodoById id todos =
    List.head <| List.filter (\todo -> todo.id == id) <| todos
