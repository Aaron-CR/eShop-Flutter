import 'package:eshop/core/models/product_models.dart';
import 'package:eshop/shared/ui_helpers.dart';
import 'package:eshop/theme/theme.dart';
import 'package:flutter/material.dart';

class HorizontalStepperBody extends StatefulWidget {
  @override
  _HorizontalStepperBodyState createState() => _HorizontalStepperBodyState();
}

class _HorizontalStepperBodyState extends State<HorizontalStepperBody> {
  int currentStep = 0;
  static var _focusNode = FocusNode();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final productNameController = TextEditingController();
  Product product = new Product();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
      print('Has focus: $_focusNode.hasFocus');
    });
  }

  @override
  Widget build(BuildContext context) {
    void _submitDetails() {
      if (!_formKey.currentState.validate()) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Please enter correct data')));
      } else {
        _formKey.currentState.save();
        showDialog(
          context: context,
          child: AlertDialog(
            title: Text("Details"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("amazonURL: ${product.amazonURL}"),
                  Text("brand: ${product.brand}"),
                  Text("deal: ${product.deal}"),
                  Text("description: ${product.description}"),
                  Text("features: ${product.features}"),
                  Text("id: ${product.id}"),
                  Text("photoURL: ${product.photoURL}"),
                  Text("price: ${product.price}"),
                  Text("productName: ${product.productName}"),
                  Text("stock: ${product.stock}"),
                  Text("userId: ${product.userId}"),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  // Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    }

    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stepper(
        type: StepperType.horizontal,
        controlsBuilder: (BuildContext context,
            {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
          return Container(
            constraints: BoxConstraints.tightFor(height: 56.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  onPressed: onStepCancel,
                  textTheme: ButtonTextTheme.normal,
                  child: Row(children: <Widget>[
                    Icon(Icons.chevron_left),
                    Text('BACK')
                  ]),
                ),
                currentStep != 4
                    ? FlatButton(
                        onPressed: onStepContinue,
                        child: Row(
                          children: <Widget>[
                            Text('NEXT'),
                            Icon(Icons.chevron_right)
                          ],
                        ),
                      )
                    : FlatButton(
                        onPressed: _submitDetails,
                        color: colorScheme.primary,
                        textColor: colorScheme.surface,
                        textTheme: ButtonTextTheme.normal,
                        child: Row(
                          children: <Widget>[
                            Text('SAVE'),
                            Icon(Icons.chevron_right)
                          ],
                        ),
                      )
              ],
            ),
          );
        },
        currentStep: currentStep,
        onStepCancel: () {
          setState(() {
            if (currentStep > 0) {
              currentStep = currentStep - 1;
            } else {
              currentStep = 0;
            }
          });
        },
        onStepContinue: () {
          setState(() {
            currentStep = currentStep + 1;
          });
        },
        onStepTapped: (step) {
          setState(() {
            currentStep = step;
          });
        },
        steps: <Step>[
          buildStep(
            context,
            index: 0,
            title: 'Step 1',
            children: <Widget>[
              Text(
                'Primero escribí el nombre y la marca del producto',
                style: textTheme.headline,
                textAlign: TextAlign.center,
              ),
              verticalSpaceMedium,

              /// Product Name
              TextFormField(
                maxLines: 2,
                controller: productNameController,
                validator: (value) => (value.isEmpty || value.length < 10)
                    ? 'Please enter product name'
                    : null,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  // TODO: Translate hint text
                  hintText: 'Indicá el nombre del producto.',
                ),
              ),
              verticalSpaceSmall,

              /// Brand
              TextFormField(
                maxLines: 2,
                onSaved: (value) {
                  product.brand = value;
                },
                validator: (value) =>
                    value.isEmpty ? 'Please enter product brand' : null,
                decoration: InputDecoration(
                  labelText: 'Brand',
                  // TODO: Translate hint text
                  hintText: 'Indicá la marca del producto.',
                ),
              ),
            ],
          ),
          buildStep(
            context,
            index: 1,
            title: 'Step 2',
            children: <Widget>[
              Text(
                'Indica la foto y el URL de Amazon',
                style: textTheme.headline,
                textAlign: TextAlign.center,
              ),
              verticalSpaceMedium,

              /// Photo URL
              TextFormField(
                maxLines: 2,
                onSaved: (value) {
                  product.photoURL = value;
                },
                // TODO: add url validator
                validator: (value) => (value.isEmpty || value.length < 1)
                    ? 'Please enter photo URL'
                    : null,
                decoration: InputDecoration(
                  labelText: 'Photo URL',
                  // TODO: Translate hint text
                  hintText: 'Indicá la url de la foto.',
                ),
              ),
              verticalSpaceSmall,

              /// Amazon URL
              TextFormField(
                maxLines: 2,
                onSaved: (value) {
                  product.amazonURL = value;
                },
                // TODO: add url validator
                validator: (value) => (value.isEmpty || value.length < 1)
                    ? 'Please enter amazon URL'
                    : null,
                decoration: InputDecoration(
                  labelText: 'Amazon URL',
                  // TODO: Translate hint text
                  hintText: 'Indicá la url de Amazon.',
                ),
              ),

              // TODO: Add image preview
            ],
          ),
          buildStep(
            context,
            index: 2,
            title: 'Step 3',
            children: <Widget>[
              Text(
                'Describí tu producto',
                style: textTheme.headline,
                textAlign: TextAlign.center,
              ),
              verticalSpaceMedium,

              /// Description
              TextFormField(
                maxLines: 5,
                onSaved: (value) {
                  product.description = value;
                },
                validator: (value) =>
                    value.isEmpty ? 'Please enter description' : null,
                decoration: InputDecoration(
                  labelText: 'Description',
                  // TODO: Translate hint text
                  hintText: 'Indicá la descripcion.',
                ),
              ),
              verticalSpaceSmall,

              /// Features
              TextFormField(
                maxLines: 5,
                onSaved: (value) {
                  product.features = value;
                },
                validator: (value) =>
                    value.isEmpty ? 'Please enter features' : null,
                decoration: InputDecoration(
                  labelText: 'Features',
                  // TODO: Translate hint text
                  hintText: 'Indicá las caracteristicas.',
                ),
              ),
            ],
          ),
          buildStep(
            context,
            index: 3,
            title: 'Step 4',
            children: <Widget>[
              Text(
                'Ultimos detalles!',
                style: textTheme.headline,
                textAlign: TextAlign.center,
              ),
              verticalSpaceMedium,

              /// Product Price
              TextFormField(
                maxLines: 2,
                onSaved: (value) {
                  product.price = double.parse(value);
                },
                validator: (value) => (value.isEmpty || double.parse(value) < 0)
                    ? 'Please enter a valid price'
                    : null,
                decoration: InputDecoration(
                  labelText: 'Price',
                  // TODO: Translate hint text
                  hintText: 'Indicá el precio del producto.',
                ),
              ),
              verticalSpaceSmall,
            ],
          ),
          buildStep(
            context,
            state: StepState.complete,
            index: 4,
            title: 'Finish',
            children: <Widget>[
              Text(
                'Revisa los detalles y guarda tu producto',
                style: textTheme.headline,
                textAlign: TextAlign.center,
              ),
              verticalSpaceMedium,
            ],
          ),
        ],
      ),
    );
  }

  Step buildStep(
    BuildContext context, {
    @required int index,
    @required String title,
    @required List<Widget> children,
    StepState state = StepState.indexed,
  }) {
    return Step(
        state: state,
        content: Container(
          height: screenHeightFraction(context, dividedBy: 1.6),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
              //return true;
            },
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: children,
            ),
          ),
        ),
        title: currentStep == index ? Text(title) : SizedBox.shrink(),
        isActive: currentStep == index);
  }
}
