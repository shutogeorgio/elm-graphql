module Api.Object.AddProjectCardPayload exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.AddProjectCardPayload
build constructor =
    Object.object constructor


cardEdge : Object cardEdge Api.Object.ProjectCardEdge -> FieldDecoder cardEdge Api.Object.AddProjectCardPayload
cardEdge object =
    Object.single "cardEdge" [] object


clientMutationId : FieldDecoder String Api.Object.AddProjectCardPayload
clientMutationId =
    Field.fieldDecoder "clientMutationId" [] Decode.string


projectColumn : Object projectColumn Api.Object.Project -> FieldDecoder projectColumn Api.Object.AddProjectCardPayload
projectColumn object =
    Object.single "projectColumn" [] object