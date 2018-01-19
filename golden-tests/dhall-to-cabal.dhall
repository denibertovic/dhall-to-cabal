let bytestring = { package = "bytestring" , bounds = majorVersion [ +0, +10 ] } in
    let base = { bounds = majorVersion [ +4, +10 ], package = "base" }

in  let Cabal = { bounds = majorVersion [ +2, +0 ], package = "Cabal" }

in  let dhall = { bounds = majorVersion [ +1, +8 ], package = "dhall" }

in  let text = { bounds = majorVersion [ +1, +2 ], package = "text" }

in  { benchmarks        = [] : List { main-is : Text, name : Text }
    , cabal-version     = [ +2, +0 ]
    , executables       =
        [ { build-dependencies =
              [ base
              , { bounds = anyVersion, package = "dhall-to-cabal" }
              , { bounds  = majorVersion [ +0, +14 ]
                , package = "optparse-applicative"
                }
              , text
              , dhall
              , Cabal
              ]
          , hs-source-dirs     = [ "exe" ]
          , main-is            = "Main.hs"
          , name               = "dhall-to-cabal"
          , other-modules      = [] : List Text
          }
        ]
    , foreign-libraries = [] : List { name : Text, type : < Shared : {} > }
    , library           =
        [ { build-dependencies =
              [ base
              , Cabal
              , dhall
              , text
              , { bounds = majorVersion [ +0, +5 ], package = "containers" }
              , { bounds = majorVersion [ +0, +12 ], package = "vector" }
              , bytestring
              , { bounds = majorVersion [ +1, +7 ], package = "trifecta" }
              , { bounds = majorVersion [ +0, +3 ], package = "text-format" }
              ]
          , exposed-modules    = [ "Distribution.Package.Dhall" ]
          , hs-source-dirs     = [ "lib" ]
          , name               = [] : Optional Text
          , other-modules      = [ "DhallToCabal" ]
          }
        ] : Optional
            { build-dependencies : List { package : Text, bounds : VersionRange }
            , exposed-modules    : List Text
            , hs-source-dirs     : List Text
            , name               : Optional Text
            , other-modules      : List Text
            }
    , package           = { name = "dhall-to-cabal", version = [ +0, +1, +0 ] }
    , source-repos      = [] : List {}
    , sub-libraries     =
        [] : List
             { build-dependencies : List { package : Text, bounds : VersionRange }
             , exposed-modules    : List Text
             , hs-source-dirs     : List Text
             , name               : Optional Text
             , other-modules      : List Text
             }
    , tests             =
        [ { build-dependencies =
              [ { package = "tasty-golden", bounds = majorVersion [ +2, +3 ] }
              , { package = "dhall-to-cabal" , bounds = anyVersion }
              , bytestring
              , { package = "filepath" , bounds = majorVersion [ +1, +4 ] }
              , base
              , { package = "tasty" , bounds = majorVersion [ +0, +11 ] }
              , Cabal
              , text
              ]
          , hs-source-dirs     = [ "golden-tests" ]
          , main-is            = "GoldenTests.hs"
          , name               = "golden-tests"
          , other-modules      = [] : List Text
          }
        ]
    , x-fields          = [] : List { _1 : Text, _2 : Text }
    }