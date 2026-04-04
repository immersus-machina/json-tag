package jsontag.example

import jsontag.JsonTag

sealed trait Shape derives JsonTag.ReadWriter
case class Circle(diameter: Int) extends Shape
case class Rectangle(width: Int, height: Int) extends Shape
case class Triangle(edgeA: Int, edgeB: Int, edgeC: Int) extends Shape
