import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/models/category_model.dart';
import 'package:store_app/widgets/category_card.dart';

class CategoryGrid extends StatelessWidget {
  final List<CategoryModel> categoryList;
  const CategoryGrid({
    super.key,
    required this.categoryList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: categoryList.length,
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: categoryList[index],
              child: const CategoryCard(),
            ),
          ),
        )
      ]),
    );
  }
}
