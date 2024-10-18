import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/data_nutrisi.dart';

class DataNutrisiBloc {
  static Future<List<DataNutrisi>> getNutrisi() async {
    String apiUrl = ApiUrl.listNutrisi;
    var response = await Api().get(apiUrl);

    var jsonObj = json.decode(response.body);
    List<dynamic> listNutrisi = (jsonObj as Map<String, dynamic>)['data'];
    List<DataNutrisi> dataNutrisi = [];
    for (int i = 0; i < listNutrisi.length; i++) {
      dataNutrisi.add(DataNutrisi.fromJson(listNutrisi[i]));
    }
    return dataNutrisi;
  }

  static Future addNutrisi({DataNutrisi? dataNutrisi}) async {
    String apiUrl = ApiUrl.createNutrisi;

    var body = {
      "food_item": dataNutrisi!.foodItem,
      "calories": dataNutrisi.calories.toString(),
      "fat_content": dataNutrisi.fatContent.toString()
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateNutrisi({required DataNutrisi dataNutrisi }) async {
    String apiUrl = ApiUrl.updateNutrisi(dataNutrisi.id!);
    print(apiUrl);

    var body = {
      "food_item": dataNutrisi.foodItem,
      "calories": dataNutrisi.calories.toString(),
      "fat_content": dataNutrisi.fatContent.toString(),
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteNutrisi({int? id}) async {
    String apiUrl = ApiUrl.deleteNutrisi(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
