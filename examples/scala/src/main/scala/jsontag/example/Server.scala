package jsontag.example

import jsontag.JsonTag

object Server extends cask.MainRoutes:

  override def host = "0.0.0.0"
  override def port = 57660

  @cask.get("/shape")
  def shape() =
    val randomShape = ShapeService.generateRandomShape()
    val shapeJson = JsonTag.writeJs(randomShape)
    val responseBody = ujson.Obj("shape" -> shapeJson, "sender" -> "Scala")
    cask.Response(
      data = ujson.write(responseBody),
      headers = Seq("Content-Type" -> "application/json", "Access-Control-Allow-Origin" -> "*")
    )

  println("JSON# Scala backend listening on port 57660")
  initialize()

  override def main(args: Array[String]): Unit =
    super.main(args)
    Thread.currentThread().join()
