import 'package:eshop/views/product_form/experimental_product_form/experimental_product_form_view_model.dart';
import 'package:eshop/views/product_form/experimental_product_form/horizontaltest.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:eshop/core/models/product_models.dart';

class ExperimentalProductFormView extends StatelessWidget {
  final productNameController = TextEditingController();

  // TODO: only accept . (dot)
  final String price = '120.6';
  final Product edittingProduct;
  ExperimentalProductFormView({Key key, this.edittingProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ExperimentalProductFormViewModel>.withConsumer(
      viewModel: ExperimentalProductFormViewModel(),
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
        /* floatingActionButton: FloatingActionButton(
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
        ), */
        body: HorizontalStepperBody(),
      ),
    );
  }
}
