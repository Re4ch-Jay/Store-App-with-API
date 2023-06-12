import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:store_app/widgets/sale_widget.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.25,
      child: Swiper(
        itemCount: 3,
        autoplay: true,
        pagination: const SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            color: Colors.white,
            activeColor: Colors.red,
          ),
        ),
        itemBuilder: (context, index) => const SaleWidget(),
      ),
    );
  }
}
