import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CategoryModel categoryModelProvider =
        Provider.of<CategoryModel>(context);
    return Stack(
      children: [
        Card(
          elevation: 0,
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(0),
          child: Image.network(categoryModelProvider.image!),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            padding: const EdgeInsets.all(3),
            child: Text(
              categoryModelProvider.name.toString(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
