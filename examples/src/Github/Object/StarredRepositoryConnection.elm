module Github.Object.StarredRepositoryConnection exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.StarredRepositoryConnection
selection constructor =
    Object.object constructor


edges : SelectionSet edges Github.Object.StarredRepositoryEdge -> FieldDecoder (List edges) Github.Object.StarredRepositoryConnection
edges object =
    Object.selectionFieldDecoder "edges" [] object (identity >> Decode.list)


nodes : SelectionSet nodes Github.Object.Repository -> FieldDecoder (List nodes) Github.Object.StarredRepositoryConnection
nodes object =
    Object.selectionFieldDecoder "nodes" [] object (identity >> Decode.list)


pageInfo : SelectionSet pageInfo Github.Object.PageInfo -> FieldDecoder pageInfo Github.Object.StarredRepositoryConnection
pageInfo object =
    Object.selectionFieldDecoder "pageInfo" [] object identity


totalCount : FieldDecoder Int Github.Object.StarredRepositoryConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int