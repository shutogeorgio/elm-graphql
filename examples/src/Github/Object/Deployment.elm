-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Github.Object.Deployment exposing (StatusesOptionalArguments, commit, createdAt, creator, databaseId, environment, id, latestStatus, payload, repository, state, statuses)

import Github.Enum.DeploymentState
import Github.InputObject
import Github.Interface
import Github.Object
import Github.Scalar
import Github.Union
import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


{-| Identifies the commit sha of the deployment.
-}
commit : SelectionSet decodesTo Github.Object.Commit -> SelectionSet (Maybe decodesTo) Github.Object.Deployment
commit object_ =
    Object.selectionForCompositeField "commit" [] object_ (identity >> Decode.nullable)


{-| Identifies the date and time when the object was created.
-}
createdAt : SelectionSet Github.Scalar.DateTime Github.Object.Deployment
createdAt =
    Object.selectionForField "Scalar.DateTime" "createdAt" [] (Object.scalarDecoder |> Decode.map Github.Scalar.DateTime)


{-| Identifies the actor who triggered the deployment.
-}
creator : SelectionSet decodesTo Github.Interface.Actor -> SelectionSet (Maybe decodesTo) Github.Object.Deployment
creator object_ =
    Object.selectionForCompositeField "creator" [] object_ (identity >> Decode.nullable)


{-| Identifies the primary key from the database.
-}
databaseId : SelectionSet (Maybe Int) Github.Object.Deployment
databaseId =
    Object.selectionForField "(Maybe Int)" "databaseId" [] (Decode.int |> Decode.nullable)


{-| The environment to which this deployment was made.
-}
environment : SelectionSet (Maybe String) Github.Object.Deployment
environment =
    Object.selectionForField "(Maybe String)" "environment" [] (Decode.string |> Decode.nullable)


id : SelectionSet Github.Scalar.Id Github.Object.Deployment
id =
    Object.selectionForField "Scalar.Id" "id" [] (Object.scalarDecoder |> Decode.map Github.Scalar.Id)


{-| The latest status of this deployment.
-}
latestStatus : SelectionSet decodesTo Github.Object.DeploymentStatus -> SelectionSet (Maybe decodesTo) Github.Object.Deployment
latestStatus object_ =
    Object.selectionForCompositeField "latestStatus" [] object_ (identity >> Decode.nullable)


{-| Extra information that a deployment system might need.
-}
payload : SelectionSet (Maybe String) Github.Object.Deployment
payload =
    Object.selectionForField "(Maybe String)" "payload" [] (Decode.string |> Decode.nullable)


{-| Identifies the repository associated with the deployment.
-}
repository : SelectionSet decodesTo Github.Object.Repository -> SelectionSet decodesTo Github.Object.Deployment
repository object_ =
    Object.selectionForCompositeField "repository" [] object_ identity


{-| The current state of the deployment.
-}
state : SelectionSet (Maybe Github.Enum.DeploymentState.DeploymentState) Github.Object.Deployment
state =
    Object.selectionForField "(Maybe Enum.DeploymentState.DeploymentState)" "state" [] (Github.Enum.DeploymentState.decoder |> Decode.nullable)


type alias StatusesOptionalArguments =
    { first : OptionalArgument Int
    , after : OptionalArgument String
    , last : OptionalArgument Int
    , before : OptionalArgument String
    }


{-| A list of statuses associated with the deployment.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.

-}
statuses : (StatusesOptionalArguments -> StatusesOptionalArguments) -> SelectionSet decodesTo Github.Object.DeploymentStatusConnection -> SelectionSet (Maybe decodesTo) Github.Object.Deployment
statuses fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "statuses" optionalArgs object_ (identity >> Decode.nullable)
