import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store_app/models/category_model.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/models/user_model.dart';

import '../consts/api_const.dart';

class APIHandler {
  static Future<List<dynamic>> getData(
      {required String target, String? limit}) async {
    Uri url = Uri.https(
      BASE_URL,
      'api/v1/$target/',
      target == 'products'
          ? {
              'offset': '0',
              'limit': limit,
            }
          : {},
    );
    var response = await http.get(url);

    // print(jsonDecode(response.body));
    var data = jsonDecode(response.body);
    List tempList = [];
    for (var eachData in data) {
      tempList.add(eachData);
    }

    return tempList;
  }

  static Future<List<ProductsModel>> getAllProducts(
      {required String limit}) async {
    List tempList = await getData(target: 'products', limit: limit);
    return ProductsModel.productsFromSnapshot(tempList);
  }

  static Future<List<CategoryModel>> getAllCategories() async {
    List tempList = await getData(target: 'categories');
    return CategoryModel.categoryFromSnapShot(tempList);
  }

  static Future<List<UserModel>> getAllUsers() async {
    List tempList = await getData(target: 'users');
    return UserModel.userFromSnapShot(tempList);
  }

  static Future<ProductsModel> getProductById({required String id}) async {
    Uri url = Uri.https(BASE_URL, 'api/v1/products/$id');
    var response = await http.get(url);
    var data = jsonDecode(response.body);

    return ProductsModel.fromJson(data);
  }
}
