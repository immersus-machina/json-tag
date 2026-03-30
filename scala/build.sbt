lazy val root = (project in file("."))
  .settings(
    name := "json-tag",
    version := "0.1.0",
    scalaVersion := "3.3.3",
    libraryDependencies ++= Seq(
      "com.lihaoyi" %% "upickle" % "4.0.2",
      "org.scalameta" %% "munit" % "1.0.0" % Test
    ),
    testFrameworks += new TestFramework("munit.Framework")
  )
