import 'package:eshop/core/models/product_models.dart';
import 'package:eshop/views/product_details/product_details_view.dart';
import 'package:eshop/views/product_list/product_list_view_model.dart';
import 'package:eshop/widgets/product_list_item.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  final List<Product> list;
  final ProductListViewModel model;

  DataSearch(this.list, this.model);

  @override
  List<Widget> buildActions(BuildContext context) {
    //Actions for app bar
    return [
      IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: transitionAnimation,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    final suggestionList = list;

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Text(list[index].productName),
        subtitle: Text(list[index].price.toString()),
      ),
      itemCount: suggestionList.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something

    final suggestionList = query.isEmpty
        ? list
        : list
            .where((p) => p.productName
                .contains(RegExp(query.trim(), caseSensitive: false)))
            .toList();

    return ListView.builder(
      padding: EdgeInsets.all(12.0),
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProductDetailsView(product: suggestionList[index]),
            ),
          );
        },
        child: ProductListItem(suggestionList[index], model, index),
      ),
    );
  }
}
