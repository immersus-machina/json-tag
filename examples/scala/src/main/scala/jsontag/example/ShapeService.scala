package jsontag.example

import scala.util.Random

object ShapeService:

  def generateRandomShape(): Shape =
    val variant = Random.nextInt(3)
    variant match
      case 0 => Circle(diameter = getRandomShapeEdge())
      case 1 => Rectangle(width = getRandomShapeEdge(), height = getRandomShapeEdge())
      case _ => Triangle(edgeA = getRandomShapeEdge(), edgeB = getRandomShapeEdge(), edgeC = getRandomShapeEdge())

  def getRandomShapeEdge(): Int =
    Random.between(80, 121)
