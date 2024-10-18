class DataNutrisi {
  int? id;
  String? foodItem;
  int? calories;
  int? fatContent;
  DataNutrisi({this.id, this.foodItem, this.calories, this.fatContent});
  factory DataNutrisi.fromJson(Map<String, dynamic> obj) {
    return DataNutrisi(
        id: obj['id'],
        foodItem: obj['food_item'],
        calories: obj['calories'],
        fatContent: obj['fat_content']);
  }
  static addNutrisi({required DataNutrisi dataNutrisi}){}

  static updateNutrisi({required DataNutrisi DataNutrisi}){}
}
