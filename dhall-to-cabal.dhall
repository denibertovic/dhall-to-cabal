    let empty-package = ./dhall/empty-package.dhall 

in  let licenses = constructors ./dhall/types/License 

in  let extensions = constructors ./dhall/types/Extension 

in  let package =
            λ(package : Text)
          → λ(version-range : VersionRange)
          → { bounds = version-range, package = package }

in  let common-deps =
          { Cabal          = package "Cabal" (majorBoundVersion [ +2, +0 ])
          , base           = package "base" (majorBoundVersion [ +4, +10 ])
          , bytestring     =
              package "bytestring" (majorBoundVersion [ +0, +10 ])
          , dhall          = package "dhall" (majorBoundVersion [ +1, +9 ])
          , dhall-to-cabal = package "dhall-to-cabal" anyVersion
          , text           = package "text" (majorBoundVersion [ +1, +2 ])
          }

in  let gitHub-project = ./dhall/gitHubProject.dhall 

in    gitHub-project { owner = "ocharles", repo = "dhall-to-cabal" }
    ⫽ { executables =
          [   ./dhall/defaults/Executable.dhall 
            ⫽ { build-dependencies =
                  [ common-deps.base
                  , common-deps.dhall-to-cabal
                  , package
                    "optparse-applicative"
                    ( unionVersionRanges
                      (majorBoundVersion [ +0, +13, +2 ])
                      (majorBoundVersion [ +0, +14 ])
                    )
                  , common-deps.text
                  , common-deps.dhall
                  , common-deps.Cabal
                  ]
              , hs-source-dirs     = [ "exe" ]
              , main-is            = "Main.hs"
              , name               = "dhall-to-cabal"
              , other-extensions   = [ extensions.NamedFieldPuns {=} ]
              }
          ]
      , library     =
          [   ./dhall/defaults/Library.dhall 
            ⫽ { build-dependencies =
                  [ common-deps.base
                  , common-deps.Cabal
                  , common-deps.dhall
                  , common-deps.text
                  , common-deps.bytestring
                  , package "containers" (majorBoundVersion [ +0, +5 ])
                  , package "vector" (majorBoundVersion [ +0, +12 ])
                  , package "trifecta" (majorBoundVersion [ +1, +7 ])
                  , package "text-format" (majorBoundVersion [ +0, +3 ])
                  , package "transformers" (majorBoundVersion [ +0, +5, +2 ])
                  ]
              , compiler-options   =
                    ./dhall/defaults/CompilerOptions 
                  ⫽ { GHC =
                        { build-options =
                            [ "-Wall", "-fno-warn-name-shadowing" ]
                        }
                    }
              , exposed-modules    = [ "Distribution.Package.Dhall" ]
              , hs-source-dirs     = [ "lib" ]
              , other-extensions   =
                  [ extensions.ApplicativeDo {=}
                  , extensions.GADTs {=}
                  , extensions.GeneralizedNewtypeDeriving {=}
                  , extensions.LambdaCase {=}
                  , extensions.OverloadedStrings {=}
                  , extensions.RecordWildCards {=}
                  , extensions.TypeApplications {=}
                  ]
              , other-modules      = [ "Dhall.Extra" ]
              }
          ] : Optional ./dhall/types/Library 
      , license     = licenses.MIT {=}
      , package     = { name = "dhall-to-cabal", version = [ +0, +1, +0 ] }
      , tests       =
          [   ./dhall/defaults/TestSuite.dhall 
            ⫽ { build-dependencies =
                  [ common-deps.bytestring
                  , common-deps.base
                  , common-deps.Cabal
                  , common-deps.text
                  , package "tasty" (majorBoundVersion [ +0, +11 ])
                  , package "filepath" (majorBoundVersion [ +1, +4 ])
                  , common-deps.dhall-to-cabal
                  , package "tasty-golden" (majorBoundVersion [ +2, +3 ])
                  , package "Diff" (majorBoundVersion [ +0, +3, +4 ])
                  ]
              , hs-source-dirs     = [ "golden-tests" ]
              , main-is            = "GoldenTests.hs"
              , name               = "golden-tests"
              }
          ]
      }
