import 'package:flutter/material.dart';
import 'package:tu_pension/constants.dart';
import 'package:tu_pension/data/model/Favorite.dart';
import 'package:tu_pension/data/model/Product.dart';
import 'package:tu_pension/size_config.dart';
import 'package:tu_pension/ui/screens/details/details_screen.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({
    Key? key,
    required this.favorite,
    required this.product,
  }) : super(key: key);

  final Favorite favorite;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        DetailsScreen.routeName,
        arguments: ProductDetailsArguments(product: product),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset(favorite.product.images[0]),
              ),
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                favorite.product.title,
                style: TextStyle(color: Colors.black, fontSize: 16),
                maxLines: 2,
              ),
              SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: "\$${favorite.product.price}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
