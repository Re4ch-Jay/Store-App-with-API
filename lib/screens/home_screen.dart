import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/screens/all_products_screen.dart';
import 'package:store_app/screens/category_screen.dart';
import 'package:store_app/screens/product_detail_screen.dart';
import 'package:store_app/screens/users_screen.dart';
import 'package:store_app/services/api_handler.dart';
import 'package:store_app/widgets/app_bar_icon.dart';
import 'package:store_app/widgets/banner_widget.dart';
import 'package:store_app/widgets/loading_widget.dart';
import 'package:store_app/widgets/my_error_widget.dart';
import 'package:store_app/widgets/no_data_widget.dart';
import 'package:store_app/widgets/product_card.dart';
import 'package:store_app/widgets/product_grid.dart';
import 'package:store_app/widgets/search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _textEditingController;

  // List<ProductsModel> productList = [];

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   getProducts();
  //   super.didChangeDependencies();
  // }

  // Future<void> getProducts() async {
  //   productList = await APIHandler.getAllProducts();
  //   setState(() {});
  // }

  void navigateToAllProductsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AllProductsScreen(),
      ),
    );
  }

  // void navigateToProductDetail() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => const ProductDetailScreen(),
  //     ),
  //   );
  // }

  void navigateToCategoryScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CategoryScreen(),
      ),
    );
  }

  void navigateToUsersScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UsersScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: AppBarIcon(
            icon: IconlyLight.category,
            onTap: navigateToCategoryScreen,
          ),
          title: const Text('Home'),
          actions: [
            AppBarIcon(
              icon: IconlyLight.user3,
              onTap: navigateToUsersScreen,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 18,
              ),
              SearchWidget(textEditingController: _textEditingController),
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const BannerWidget(),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'All Products',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          IconButton(
                            onPressed: navigateToAllProductsScreen,
                            icon: const Icon(IconlyLight.arrowRight),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // productList.isEmpty
                      //     ? const Center(
                      //         child: CircularProgressIndicator(),
                      //       )
                      //     : ProductGrid(
                      //         navigateToProductDetail: navigateToProductDetail,
                      //         productList: productList,
                      //       ),
                      FutureBuilder<List<ProductsModel>>(
                        future: APIHandler.getAllProducts(limit: '4'),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Loading();
                          } else if (snapshot.hasError) {
                            return MyErrorWidget(
                              errorMessage:
                                  'An Error Occured ${snapshot.error}',
                            );
                          } else if (snapshot.data == null) {
                            return const NoData();
                          }
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 4,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) =>
                                ChangeNotifierProvider.value(
                              value: snapshot.data![index],
                              child: const ProductCard(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
