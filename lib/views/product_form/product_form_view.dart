import 'package:eshop/views/product_form/test.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:eshop/core/models/product_models.dart';
import 'package:eshop/views/product_form/product_form_view_model.dart';
import 'package:eshop/shared/ui_helpers.dart';
import 'package:eshop/widgets/input_field.dart';

class ProductFormView extends StatelessWidget {
  final productNameController = TextEditingController();

  // TODO: only accept . (dot)
  final String price = '120.6';
  final Product edittingProduct;
  ProductFormView({Key key, this.edittingProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ProductFormViewModel>.withConsumer(
      viewModel: ProductFormViewModel(),
      onModelReady: (model) {
        // update the text in the controller
        productNameController.text = edittingProduct?.productName ?? '';

        model.setEdittingPost(edittingProduct);
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Create an Product',
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: !model.busy
              ? Icon(Icons.add)
              : CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
          onPressed: () {
            if (!model.busy) {
              model.addProduct(
                productName: productNameController.text,
                price: double.parse(price),
              );
            }
          },
          backgroundColor:
              !model.busy ? Theme.of(context).primaryColor : Colors.grey[200],
        ),
        body: StepperBody(),
      ),
    );
  }

  Padding buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          verticalSpace(40),
          Text(
            'Create Post',
            style: TextStyle(fontSize: 26),
          ),
          verticalSpaceMedium,
          InputField(
            hintText: 'Product Name',
            controller: productNameController,
          ),
          verticalSpaceMedium,
          Text('Post Image'),
          verticalSpaceSmall,
          Container(
            height: 250,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: Text(
              'Tap to add post image',
              style: TextStyle(color: Colors.grey[400]),
            ),
          )
        ],
      ),
    );
  }
}
