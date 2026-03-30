package jsontag;

public class PersonalVehicle extends Vehicle {

    private String make;

    public PersonalVehicle() {
    }

    public PersonalVehicle(String make) {
        this.make = make;
    }

    public String getMake() {
        return make;
    }

    public void setMake(String make) {
        this.make = make;
    }
}
