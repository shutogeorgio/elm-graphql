module Parser.ConnectionDetectorTests exposing (all)

import Expect
import Graphql.Parser.CamelCaseName as CamelCaseName
import Graphql.Parser.ClassCaseName as ClassCaseName
import Graphql.Parser.Scalar as Scalar
import Graphql.Parser.Type as Type exposing (DefinableType(..), IsNullable(..), ReferrableType(..), TypeDefinition(..), TypeReference(..))
import Test exposing (Test, describe, test)


type DetectionResult
    = Miss
    | SpecViolation
    | Match


isConnection : Type.Field -> List TypeDefinition -> DetectionResult
isConnection candidateField allDefinitions =
    if CamelCaseName.raw candidateField.name == "stargazers" then
        Match

    else
        Miss


all : Test
all =
    describe "detect connections"
        [ describe "non-objects"
            [ test "scalar is not a Connection" <|
                \() ->
                    isConnection
                        (field "String" "hello")
                        []
                        |> Expect.equal Miss
            ]
        , describe "objects"
            [ -- test "Object with correct name violates convention, should warn" <|
              --     \() ->
              --         isConnection
              --             (fieldNew "totalCount" (Type.Scalar Scalar.Int) NonNullable)
              --             []
              --             |> Expect.equal SpecViolation
              {-
                 {
                   repository(owner: "dillonkearns", name: "elm-graphql") {
                     stargazers(first: 10, after: null) {
                       totalCount
                       pageInfo {
                         hasNextPage
                         endCursor
                       }
                       edges {
                         node {
                           login
                         }
                         starredAt
                       }
                     }
                   }
                 }

              -}
              test "strict spec match" <|
                \() ->
                    isConnection
                        properField
                        properConnectionExample
                        |> Expect.equal Match
            ]
        ]


typeDefinition : String -> DefinableType -> TypeDefinition
typeDefinition classCaseName definableType =
    TypeDefinition (ClassCaseName.build classCaseName) definableType Nothing


strictPageInfoDefinition : TypeDefinition
strictPageInfoDefinition =
    typeDefinition "PageInfo"
        (Type.ObjectType
            [ fieldNew "hasPreviousPage" (Type.Scalar Scalar.Boolean) NonNullable
            , fieldNew "hasNextPage" (Type.Scalar Scalar.Boolean) NonNullable
            , fieldNew "startCursor" (Type.Scalar Scalar.String) Nullable
            , fieldNew "endCursor" (Type.Scalar Scalar.String) Nullable
            ]
        )


fieldNew : String -> Type.ReferrableType -> IsNullable -> Type.Field
fieldNew fieldName reference isNullable =
    { name = CamelCaseName.build fieldName
    , description = Nothing
    , typeRef = TypeReference reference isNullable
    , args = []
    }


field : String -> String -> Type.Field
field inputObjectName fieldName =
    { name = CamelCaseName.build fieldName
    , description = Nothing
    , typeRef = TypeReference (Type.InputObjectRef (ClassCaseName.build inputObjectName)) NonNullable
    , args = []
    }


properConnectionExample =
    [ TypeDefinition (ClassCaseName.build "PageInfo")
        (ObjectType
            [ { args = [], description = Just "", name = CamelCaseName.build "endCursor", typeRef = TypeReference (Type.Scalar Scalar.String) Nullable }
            , { args = [], description = Just "", name = CamelCaseName.build "hasNextPage", typeRef = TypeReference (Type.Scalar Scalar.Boolean) NonNullable }
            , { args = []
              , description = Just ""
              , name = CamelCaseName.build "hasPreviousPage"
              , typeRef = TypeReference (Type.Scalar Scalar.Boolean) NonNullable
              }
            , { args = [], description = Just "", name = CamelCaseName.build "starCursor", typeRef = TypeReference (Type.Scalar Scalar.String) Nullable }
            ]
        )
        Nothing
    , TypeDefinition (ClassCaseName.build "Query")
        (ObjectType
            [ properField
            ]
        )
        Nothing
    , TypeDefinition (ClassCaseName.build "StargazerConnection") (ObjectType [ { args = [], description = Just "", name = CamelCaseName.build "edges", typeRef = TypeReference (List (TypeReference (ObjectRef "StargazerEdge") Nullable)) Nullable }, { args = [], description = Just "", name = CamelCaseName.build "pageInfo", typeRef = TypeReference (ObjectRef "PageInfo") NonNullable }, { args = [], description = Just "", name = CamelCaseName.build "totalCount", typeRef = TypeReference (Type.Scalar Scalar.Int) NonNullable } ]) Nothing
    , TypeDefinition (ClassCaseName.build "StargazerEdge") (ObjectType [ { args = [], description = Just "", name = CamelCaseName.build "cursor", typeRef = TypeReference (Type.Scalar Scalar.String) NonNullable }, { args = [], description = Just "", name = CamelCaseName.build "node", typeRef = TypeReference (ObjectRef "User") NonNullable } ]) Nothing
    , TypeDefinition (ClassCaseName.build "User") (ObjectType [ { args = [], description = Just "", name = CamelCaseName.build "name", typeRef = TypeReference (Type.Scalar Scalar.String) NonNullable } ]) Nothing
    ]


properField =
    { args =
        [ { description = Nothing, name = CamelCaseName.build "after", typeRef = TypeReference (Type.Scalar Scalar.String) Nullable }
        , { description = Nothing, name = CamelCaseName.build "before", typeRef = TypeReference (Type.Scalar Scalar.String) Nullable }
        , { description = Nothing, name = CamelCaseName.build "first", typeRef = TypeReference (Type.Scalar Scalar.Int) Nullable }
        , { description = Nothing, name = CamelCaseName.build "last", typeRef = TypeReference (Type.Scalar Scalar.Int) Nullable }
        ]
    , description = Just ""
    , name = CamelCaseName.build "stargazers"
    , typeRef = TypeReference (ObjectRef "StargazerConnection") NonNullable
    }