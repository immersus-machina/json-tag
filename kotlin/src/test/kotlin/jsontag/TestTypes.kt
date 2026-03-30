package jsontag

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
sealed class Shape

@Serializable
@SerialName("Circle")
data class Circle(val radius: Double) : Shape()

@Serializable
@SerialName("Rectangle")
data class Rectangle(val width: Double, val height: Double) : Shape()

@Serializable
sealed class Vehicle

@Serializable
@SerialName("Car")
data class PersonalVehicle(val make: String) : Vehicle()

@Serializable
@SerialName("Truck")
data class TransportationVehicle(val payloadTons: Double) : Vehicle()
