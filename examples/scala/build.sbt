lazy val jsonTag = RootProject(file("../../scala"))

lazy val root = (project in file("."))
  .dependsOn(jsonTag)
  .settings(
    name := "json-tag-example",
    version := "0.1.0",
    scalaVersion := "3.3.3",
    libraryDependencies ++= Seq(
      "com.lihaoyi" %% "cask" % "0.9.4",
      "com.lihaoyi" %% "upickle" % "4.0.2"
    ),
    libraryDependencySchemes ++= Seq(
      "com.lihaoyi" %% "upickle" % VersionScheme.Always
    )
  )
