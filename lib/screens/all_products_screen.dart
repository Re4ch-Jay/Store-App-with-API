import 'package:flutter/material.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/screens/product_detail_screen.dart';
import 'package:store_app/services/api_handler.dart';
import 'package:store_app/widgets/loading_widget.dart';
import 'package:store_app/widgets/my_error_widget.dart';
import 'package:store_app/widgets/no_data_widget.dart';
import 'package:store_app/widgets/product_grid.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  int limit = 10;
  bool isLimit = false;
  final ScrollController _scrollController = ScrollController();

  List<ProductsModel> productList = [];

  Future<void> getProducts() async {
    productList = await APIHandler.getAllProducts(limit: limit.toString());
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    getProducts();
    _scrollController.addListener(() async {
      if (limit == 200) {
        isLimit = true;
        setState(() {});
        return;
      }
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        limit += 10;
        await getProducts();
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      body: productList.isNotEmpty
          ? Column(
              children: [
                FutureBuilder<List<ProductsModel>>(
                  future: APIHandler.getAllProducts(limit: limit.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return MyErrorWidget(
                        errorMessage: 'An Error Occured ${snapshot.error}',
                      );
                    } else if (snapshot.data == null) {
                      return const NoData();
                    }
                    return Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: ProductGrid(productList: snapshot.data!),
                      ),
                    );
                  },
                ),
              ],
            )
          : const Loading(),
    );
  }
}
