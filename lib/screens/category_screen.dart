import 'package:flutter/material.dart';
import 'package:store_app/models/category_model.dart';
import 'package:store_app/services/api_handler.dart';
import 'package:store_app/widgets/loading_widget.dart';
import 'package:store_app/widgets/my_error_widget.dart';
import 'package:store_app/widgets/no_data_widget.dart';

import '../widgets/category_grid.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: FutureBuilder<List<CategoryModel>>(
        future: APIHandler.getAllCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            return MyErrorWidget(
              errorMessage: 'An Error Occured ${snapshot.error}',
            );
          } else if (snapshot.data == null) {
            return const NoData();
          }
          return CategoryGrid(
            categoryList: snapshot.data!,
          );
        },
      ),
    );
  }
}
