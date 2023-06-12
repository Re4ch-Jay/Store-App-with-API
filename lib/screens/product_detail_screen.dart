import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/api_handler.dart';
import 'package:store_app/widgets/loading_widget.dart';
import 'package:store_app/widgets/my_error_widget.dart';
import 'package:store_app/widgets/no_data_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  final String id;
  const ProductDetailScreen({super.key, required this.id});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductsModel? product;

  Future<void> getProduct() async {
    product = await APIHandler.getProductById(id: widget.id);
    setState(() {});
  }

  @override
  void initState() {
    getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
      ),
      body: FutureBuilder(
        future: APIHandler.getProductById(id: widget.id),
        builder: (context, snapshot) {
          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          }
          // no data
          if (snapshot.data == null) {
            return const NoData();
          }
          // error
          if (snapshot.hasError) {
            return MyErrorWidget(
                errorMessage: 'An Error Occured ${snapshot.error}');
          }
          // success
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: FittedBox(
                          child: Text(
                            product!.title.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                          child: FittedBox(
                              child: Text(
                        '\$${product!.price.toString()}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ))),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.4,
                    child: Swiper(
                      itemCount: product!.images!.length,
                      autoplay: true,
                      pagination: const SwiperPagination(
                        builder: DotSwiperPaginationBuilder(
                          color: Colors.black,
                          activeColor: Colors.red,
                        ),
                      ),
                      itemBuilder: (context, index) => ClipRRect(
                          child: Image.network(product!.images![index])),
                    ),
                  ),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    product!.description.toString(),
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
