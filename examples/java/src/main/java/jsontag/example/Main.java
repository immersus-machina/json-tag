package jsontag.example;

import io.javalin.Javalin;
import io.javalin.json.JavalinJackson;


public class Main {

    public static void main(String[] args) {
        ShapeService shapeService = new ShapeService();

        Javalin application = Javalin.create(config -> {
            config.jsonMapper(new JavalinJackson());
            config.bundledPlugins.enableCors(cors -> cors.addRule(rule -> rule.anyHost()));
        });

        application.get("/shape", context -> {
            Shape shape = shapeService.generateRandomShape();
            context.json(new ShapeResponse(shape, "Java"));
        });

        System.out.println("JSON# Java backend listening on port 57660");
        application.start(57660);
    }
}
