-- Do not manually edit this file, it was auto-generated by Graphqelm
-- npm package version 1.0.1
-- Target elm package version 4.1.0
-- https://github.com/dillonkearns/graphqelm


module Swapi.InputObject.GreetingOptions exposing (..)

import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Internal.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Internal.Builder.Object as Object
import Graphqelm.Internal.Encode as Encode exposing (Value)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode
import Swapi.InputObject
import Swapi.Interface
import Swapi.Object
import Swapi.Scalar
import Swapi.Union


{-| Encode a GreetingOptions into a value that can be used as an argument.
-}
encode : GreetingOptions -> Value
encode input =
    Encode.maybeObject
        [ ( "prefix", Encode.string |> Encode.optional input.prefix ) ]


{-| Type for the GreetingOptions input object.
-}
type alias GreetingOptions =
    { prefix : OptionalArgument String }