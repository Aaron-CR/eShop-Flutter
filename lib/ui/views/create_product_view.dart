import 'package:eshop/models/product_models.dart';
import 'package:eshop/ui/shared/ui_helpers.dart';
import 'package:eshop/ui/widgets/input_field.dart';
import 'package:eshop/viewmodels/create_product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/viewmodel_provider.dart';

class CreateProductView extends StatelessWidget {
  final productNameController = TextEditingController();
  final Product edittingProduct;
  CreateProductView({Key key, this.edittingProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CreateProductViewModel>.withConsumer(
      viewModel: CreateProductViewModel(),
      onModelReady: (model) {
        // update the text in the controller
        productNameController.text = edittingProduct?.productName ?? '';

        model.setEdittingPost(edittingProduct);
      },
      builder: (context, model, child) => Scaffold(
          floatingActionButton: FloatingActionButton(
            child: !model.busy
                ? Icon(Icons.add)
                : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
            onPressed: () {
              if (!model.busy) {
                model.addProduct(productName: productNameController.text);
              }
            },
            backgroundColor:
                !model.busy ? Theme.of(context).primaryColor : Colors.grey[600],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  child: Text(
                    'Tap to add post image',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
