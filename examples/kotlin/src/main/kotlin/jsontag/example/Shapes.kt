package jsontag.example

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
sealed class Shape

@Serializable
@SerialName("Circle")
data class Circle(val radius: Int) : Shape()

@Serializable
@SerialName("Rectangle")
data class Rectangle(val width: Int, val height: Int) : Shape()

@Serializable
@SerialName("Triangle")
data class Triangle(val edgeA: Int, val edgeB: Int, val edgeC: Int) : Shape()
