import 'package:flutter/material.dart';
import 'package:tu_pension/data/model/Favorite.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class FavoriteScreen extends StatelessWidget {
  static String routeName = "/favorite";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      // bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Favoritos",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${demoFavorites.length} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
