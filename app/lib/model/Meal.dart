class Meal {
  final int id;
  final String name;
  final String category;
  final String instructions;
  final List<String> ingredients;
  final List<String> measures;
  final String thumbnail;

  const Meal({
    required this.id,
    required this.name,
    required this.category,
    required this.instructions,
    required this.ingredients,
    required this.measures,
    required this.thumbnail,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    List<String> measures = [];
    int counter = 1;
    while (json.containsKey("strIngredient$counter") && json.containsKey("strMeasure$counter")) {
      String ingredient = json["strIngredient$counter"];
      String measure = json["strMeasure$counter"];
      if (ingredient.isEmpty || measure.isEmpty) {
        break;
      }
      ingredients.add(ingredient);
      measures.add(measure);
      counter++;
    }

    return Meal(
      id: int.parse(json["idMeal"]),
      name: json["strMeal"],
      category: json["strCategory"],
      instructions: json["strInstructions"],
      ingredients: ingredients,
      measures: measures,
      thumbnail: json["strMealThumb"],
    );
  }
}