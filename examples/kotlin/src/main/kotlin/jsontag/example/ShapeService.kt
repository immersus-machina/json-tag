package jsontag.example

import kotlin.random.Random

object ShapeService {

    fun generateRandomShape(): Shape {
        return when (Random.nextInt(3)) {
            0 -> Circle(radius = getRandomShapeEdge())
            1 -> Rectangle(width = getRandomShapeEdge(), height = getRandomShapeEdge())
            else -> Triangle(edgeA = getRandomShapeEdge(), edgeB = getRandomShapeEdge(), edgeC = getRandomShapeEdge())
        }
    }

    private fun getRandomShapeEdge(): Int = Random.nextInt(80, 121)
}
