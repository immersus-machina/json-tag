lazy val root = (project in file("."))
  .settings(
    name := "json-tag-scala",
    organization := "io.github.immersus-machina",
    version := "0.1.0",
    scalaVersion := "3.3.3",
    description := "Scala uPickle wrapper for JSON# — the #type convention for cross-language type tagging in JSON.",
    homepage := Some(url("https://github.com/immersus-machina/json-tag")),
    licenses := Seq("MIT" -> url("https://opensource.org/licenses/MIT")),
    developers := List(
      Developer("immersus-machina", "immersus-machina", "innovate@immersus-machina.com", url("https://github.com/immersus-machina"))
    ),
    scmInfo := Some(ScmInfo(url("https://github.com/immersus-machina/json-tag"), "scm:git:https://github.com/immersus-machina/json-tag.git")),
    libraryDependencies ++= Seq(
      "com.lihaoyi" %% "upickle" % "4.0.2",
      "org.scalameta" %% "munit" % "1.0.0" % Test
    ),
    testFrameworks += new TestFramework("munit.Framework"),
    versionScheme := Some("semver-spec"),
    publishMavenStyle := true
  )
