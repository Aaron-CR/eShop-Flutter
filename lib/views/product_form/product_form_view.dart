import 'package:eshop/core/models/product_models.dart';
import 'package:eshop/shared/ui_helpers.dart';
import 'package:eshop/views/product_form/product_form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/viewmodel_provider.dart';

import 'input_field.dart';

class ProductFormView extends StatelessWidget {
  final Product edittingProduct;

  final productNameController = TextEditingController();
  final brandController = TextEditingController();
  final amazonURLController = TextEditingController();
  final photoURLController = TextEditingController();
  final descriptionController = TextEditingController();
  final featuresController = TextEditingController();

  ProductFormView({Key key, this.edittingProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ProductFormViewModel>.withConsumer(
      viewModel: ProductFormViewModel(),
      onModelReady: (model) {
        // update the text in the controller
        productNameController.text = edittingProduct?.productName ?? '';
        brandController.text = edittingProduct?.brand ?? '';
        amazonURLController.text = edittingProduct?.amazonURL ?? '';
        photoURLController.text = edittingProduct?.photoURL ?? '';
        descriptionController.text = edittingProduct?.description ?? '';
        featuresController.text = edittingProduct?.features ?? '';

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
              model.addProduct(
                product: Product(
                  productName: productNameController.text,
                  brand: brandController.text,
                  amazonURL: amazonURLController.text,
                  photoURL: photoURLController.text,
                  description: descriptionController.text,
                  features: featuresController.text,
                  price: double.parse('2'),
                  deal: '0',
                  stock: '0,',
                ),
              );
            }
          },
          backgroundColor:
              !model.busy ? Theme.of(context).primaryColor : Colors.grey[600],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: ListView(
            children: <Widget>[
              verticalSpace(40),
              Text(
                'Create Product',
                style: TextStyle(fontSize: 26),
              ),
              verticalSpaceMedium,
              InputField(
                placeholder: 'Product Name',
                controller: productNameController,
              ),
              InputField(
                placeholder: 'Brand',
                controller: brandController,
              ),
              InputField(
                placeholder: 'Amazon URL',
                controller: amazonURLController,
              ),
              InputField(
                placeholder: 'Photo URL',
                controller: photoURLController,
              ),
              InputField(
                placeholder: 'Description',
                controller: descriptionController,
              ),
              InputField(
                placeholder: 'Features',
                controller: featuresController,
              ),
              verticalSpaceMedium,
              Text('Product preview'),
              verticalSpaceSmall,
              Container(
                height: 250,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                child: Text(
                  'Product preview',
                  style: TextStyle(color: Colors.grey[400]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
