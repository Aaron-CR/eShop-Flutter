import 'package:eshop/core/models/product_models.dart';
import 'package:eshop/shared/string_to_bool.dart';
import 'package:eshop/shared/ui_helpers.dart';
import 'package:eshop/views/product_form/product_form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/viewmodel_provider.dart';

class ProductFormView extends StatefulWidget {
  final Product edittingProduct;

  ProductFormView({Key key, this.edittingProduct}) : super(key: key);

  @override
  _ProductFormViewState createState() => _ProductFormViewState();
}

class _ProductFormViewState extends State<ProductFormView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ProductFormViewModel>.withConsumer(
      viewModel: ProductFormViewModel(),
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          child: !model.busy
              ? !model.edditting ? Icon(Icons.library_add) : Icon(Icons.sync)
              : CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white)),
          onPressed: () {
            FocusScope.of(context).unfocus();
            final form = _formKey.currentState;
            if (form.validate()) {
              form.save();
              if (!model.busy) {
                model.addProduct(
                  product: Product(
                    productName: widget.edittingProduct.productName,
                    brand: widget.edittingProduct.brand,
                    amazonURL: widget.edittingProduct.amazonURL,
                    photoURL: widget.edittingProduct.photoURL,
                    description: widget.edittingProduct.description,
                    features: widget.edittingProduct.features,
                    price: double.parse('2'),
                    deal: '0',
                    stock: '0,',
                  ),
                );
              }
            }
          },
          backgroundColor:
              // TODO: change all colorscheme. for Theme.of(context)
              // TODO: learn more about ThemeData
              !model.busy
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColorDark,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: ListView(
            children: <Widget>[
              verticalSpace(40),
              !model.edditting
                  ? Text(
                      'Create Product',
                      style: TextStyle(fontSize: 26),
                    )
                  : Text(
                      'Update Product',
                      style: TextStyle(fontSize: 26),
                    ),
              verticalSpaceMedium,
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      maxLines: 2,
                      initialValue: widget.edittingProduct?.productName ?? '',
                      decoration: InputDecoration(labelText: 'Product Name'),
                      validator: (value) => (value.isEmpty)
                          ? 'Please enter a product name.'
                          : null,
                      onChanged: (value) => setState(() {
                        widget.edittingProduct.productName = value;
                        print(widget.edittingProduct.productName);
                      }),
                    ),
                    TextFormField(
                      initialValue: widget.edittingProduct?.brand ?? '',
                      decoration: InputDecoration(labelText: 'Brand'),
                      validator: (value) =>
                          (value.isEmpty) ? 'Please enter a brand.' : null,
                      onSaved: (value) =>
                          setState(() => widget.edittingProduct.brand = value),
                    ),
                    TextFormField(
                      maxLines: 2,
                      initialValue: widget.edittingProduct?.amazonURL ?? '',
                      decoration: InputDecoration(labelText: 'Amazon URL'),
                      validator: (value) => (value.isEmpty)
                          ? 'Please enter an Amazon URL.'
                          : null,
                      onSaved: (value) => setState(
                          () => widget.edittingProduct.amazonURL = value),
                    ),
                    TextFormField(
                      maxLines: 2,
                      initialValue: widget.edittingProduct?.photoURL ?? '',
                      decoration: InputDecoration(labelText: 'Photo URL'),
                      validator: (value) =>
                          (value.isEmpty) ? 'Please enter an Photo URL.' : null,
                      onSaved: (value) => setState(
                          () => widget.edittingProduct.photoURL = value),
                    ),
                    TextFormField(
                      maxLines: 6,
                      initialValue: widget.edittingProduct?.description ?? '',
                      decoration: InputDecoration(labelText: 'Description'),
                      validator: (value) => (value.isEmpty)
                          ? 'Please enter an description.'
                          : null,
                      onSaved: (value) => setState(
                          () => widget.edittingProduct.description = value),
                    ),
                    TextFormField(
                      maxLines: 6,
                      initialValue: widget.edittingProduct?.features ?? '',
                      decoration: InputDecoration(labelText: 'Features'),
                      validator: (value) =>
                          (value.isEmpty) ? 'Please enter an features.' : null,
                      onSaved: (value) => setState(
                          () => widget.edittingProduct.features = value),
                    ),
                    SwitchListTile(
                        title: const Text('Offer of -10%'),
                        value: false,
                        onChanged: (value) {
                          //setState(() => widget.edittingProduct.deal = value)},
                        }),
                    SwitchListTile(
                        title: const Text('Is the product in stock?'),
                        //value: stringToBoolean(widget.edittingProduct.stock),
                        value: false,
                        onChanged: (val) {
                          // setState(() => _user.newsletter = val)}
                        }),
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
            ],
          ),
        ),
      ),
    );
  }
}

/* import 'package:eshop/core/models/product_models.dart';
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
} */
