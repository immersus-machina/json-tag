package jsontag;

public class TransportationVehicle extends Vehicle {

    private double payloadTons;

    public TransportationVehicle() {
    }

    public TransportationVehicle(double payloadTons) {
        this.payloadTons = payloadTons;
    }

    public double getPayloadTons() {
        return payloadTons;
    }

    public void setPayloadTons(double payloadTons) {
        this.payloadTons = payloadTons;
    }
}
