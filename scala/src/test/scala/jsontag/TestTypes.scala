package jsontag

sealed trait Shape derives JsonTag.ReadWriter
case class Circle(radius: Double) extends Shape
case class Rectangle(width: Double, height: Double) extends Shape

sealed trait Vehicle derives JsonTag.ReadWriter

@upickle.implicits.key("Car")
case class PersonalVehicle(make: String) extends Vehicle

@upickle.implicits.key("Truck")
case class TransportationVehicle(payloadTons: Double) extends Vehicle
