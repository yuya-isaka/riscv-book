// See README.md for license details.
// Scala用のビルドツール
// ビルド時にchiseltestのライブラリを読み込む

ThisBuild / scalaVersion     := "2.12.13"
ThisBuild / version          := "0.1.0"
ThisBuild / organization     := "%ORGANIZATION%"

lazy val root = (project in file("."))
  .settings(
    name := "%NAME%",
    libraryDependencies ++= Seq(
      "edu.berkeley.cs" %% "chisel3" % "3.4.3", // Chisel3ライブラリ
      "edu.berkeley.cs" %% "chiseltest" % "0.3.3" % "test" // ChiselTestライブラリ
      // edu.berkeley.csという組織のchiseltestというモジュールの0.3.2バージョンを指定
      // testライブラリがテストコードのみで利用されるように設定
    ),
    scalacOptions ++= Seq(
      "-Xsource:2.11",
      "-language:reflectiveCalls",
      "-deprecation",
      "-feature",
      "-Xcheckinit",
      // Enables autoclonetype2 in 3.4.x (on by default in 3.5)
      "-P:chiselplugin:useBundlePlugin"
    ),
    addCompilerPlugin("edu.berkeley.cs" % "chisel3-plugin" % "3.4.3" cross CrossVersion.full),
    addCompilerPlugin("org.scalamacros" % "paradise" % "2.1.1" cross CrossVersion.full)
  )

