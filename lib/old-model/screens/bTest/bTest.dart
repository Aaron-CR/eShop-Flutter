import 'package:eshop/old-model/screens/bTest/ProductModel.dart';
import 'package:eshop/old-model/widgets/product_card.dart';
import 'package:flutter/material.dart';

class Posts extends StatefulWidget {
  Posts({Key key}) : super(key: key);

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  final scrollController = ScrollController();
  PostsModel products;

  @override
  void initState() {
    products = PostsModel();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        products.loadMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('eShop'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: products.stream,
        builder: (BuildContext _context, AsyncSnapshot _snapshot) {
          if (!_snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return RefreshIndicator(
              onRefresh: products.refresh,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                controller: scrollController,
                separatorBuilder: (context, index) => Divider(),
                itemCount: _snapshot.data.length + 1,
                itemBuilder: (BuildContext _context, int index) {
                  if (index < _snapshot.data.length) {
                    //return Post(product: _snapshot.data[index]);
                    return ProductCard(product: _snapshot.data[index]);
                  } else if (products.hasMore) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.0),
                      child: Center(child: Text('nothing more to load!')),
                    );
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}
