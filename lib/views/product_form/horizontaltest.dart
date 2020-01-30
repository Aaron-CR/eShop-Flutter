import 'package:eshop/shared/ui_helpers.dart';
import 'package:eshop/theme/theme.dart';
import 'package:flutter/material.dart';

class HorizontalStepperBody extends StatefulWidget {
  @override
  _HorizontalStepperBodyState createState() => _HorizontalStepperBodyState();
}

class _HorizontalStepperBodyState extends State<HorizontalStepperBody> {
  int currStep = 0;
  static var _focusNode = FocusNode();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
      print('Has focus: $_focusNode.hasFocus');
    });
  }

  List<Step> steps = [
    /// Product Name & Brand
    Step(
      title: Text('Product Name'),
      subtitle: Text('Brand'),
      isActive: true,
      state: StepState.indexed,
      content: TextFormField(
        focusNode: _focusNode,
        keyboardType: TextInputType.text,
        autocorrect: false,
        onSaved: (String value) {
          //data.name = value;
        },
        maxLines: 1,
        validator: (value) {
          if (value.isEmpty || value.length < 1) {
            return 'Please enter name';
          }
        },
        decoration: InputDecoration(
          labelText: 'Enter your name',
          hintText: 'Enter a name',
          //filled: true,
          labelStyle: TextStyle(decorationStyle: TextDecorationStyle.solid),
        ),
      ),
    ),

    /// Price
    Step(
      title: Text('Price'),
      //isActive: true,
      state: StepState.indexed,
      content: TextFormField(
        keyboardType: TextInputType.phone,
        autocorrect: false,
        validator: (value) {
          if (value.isEmpty || value.length < 10) {
            return 'Please enter valid number';
          }
        },
        onSaved: (String value) {
          //data.phone = value;
        },
        maxLines: 1,
        decoration: InputDecoration(
          labelText: 'Enter your number',
          hintText: 'Enter a number',
          labelStyle: TextStyle(decorationStyle: TextDecorationStyle.solid),
        ),
      ),
    ),

    /// PhotoURL & AmazonURL
    Step(
      title: Text('PhotoURL'),
      subtitle: Text('AmazonURL'),
      //isActive: true,
      state: StepState.indexed,
      content: TextFormField(
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        validator: (value) {
          if (value.isEmpty || !value.contains('@')) {
            return 'Please enter valid email';
          }
        },
        onSaved: (String value) {
          //data.email = value;
        },
        maxLines: 1,
        decoration: InputDecoration(
          labelText: 'Enter your email',
          hintText: 'Enter a email address',
          labelStyle: TextStyle(decorationStyle: TextDecorationStyle.solid),
        ),
      ),
    ),

    /// Descrption
    Step(
      title: Text('Descrption'),
      //isActive: true,
      state: StepState.indexed,
      content: TextFormField(
        keyboardType: TextInputType.number,
        autocorrect: false,
        validator: (value) {
          if (value.isEmpty || value.length > 2) {
            return 'Please enter valid age';
          }
        },
        maxLines: 1,
        onSaved: (String value) {
          //data.age = value;
        },
        decoration: InputDecoration(
          labelText: 'Enter your age',
          hintText: 'Enter age',
          labelStyle: TextStyle(decorationStyle: TextDecorationStyle.solid),
        ),
      ),
    ),

    /// Features
    Step(
      title: Text('Features'),
      //isActive: true,
      state: StepState.indexed,
      content: TextFormField(
        keyboardType: TextInputType.number,
        autocorrect: false,
        validator: (value) {
          if (value.isEmpty || value.length > 2) {
            return 'Please enter valid age';
          }
        },
        maxLines: 1,
        onSaved: (String value) {
          //data.age = value;
        },
        decoration: InputDecoration(
          labelText: 'Enter your age',
          hintText: 'Enter age',
          labelStyle: TextStyle(decorationStyle: TextDecorationStyle.solid),
        ),
      ),
    ),

    /// Discount & Stock
    Step(
      title: Text('Discount'),
      subtitle: Text('Stock'),
      //isActive: true,
      state: StepState.indexed,
      content: TextFormField(
        keyboardType: TextInputType.number,
        autocorrect: false,
        validator: (value) {
          if (value.isEmpty || value.length > 2) {
            return 'Please enter valid age';
          }
        },
        maxLines: 1,
        onSaved: (String value) {
          // data.age = value;
        },
        decoration: InputDecoration(
          labelText: 'Enter your age',
          hintText: 'Enter age',
          labelStyle: TextStyle(decorationStyle: TextDecorationStyle.solid),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    void showSnackBarMessage(String message,
        [MaterialColor color = Colors.red]) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
    }

    void _submitDetails() {
      final FormState formState = _formKey.currentState;

      if (!formState.validate()) {
        showSnackBarMessage('Please enter correct data');
      } else {
        formState.save();
        // print("Name: ${data.name}");
        // print("Phone: ${data.phone}");
        // print("Email: ${data.email}");
        // print("Age: ${data.age}");

        showDialog(
          context: context,
          child: AlertDialog(
            title: Text("Details"),
            //content:  Text("Hello World"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  // Text("Name : " + data.name),
                  // Text("Phone : " + data.phone),
                  // Text("Email : " + data.email),
                  // Text("Age : " + data.age),
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

    return Container(
      child: Form(
        key: _formKey,
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stepper(
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
                    currStep != 4
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
            type: StepperType.horizontal,
            currentStep: currStep,
            onStepContinue: () {
              setState(
                () {
                  if (currStep < steps.length - 1) {
                    currStep = currStep + 1;
                  } else {
                    currStep = 0;
                  }
                },
              );
            },
            onStepCancel: () {
              setState(() {
                if (currStep > 0) {
                  currStep = currStep - 1;
                } else {
                  currStep = 0;
                }
              });
            },
            onStepTapped: (step) {
              setState(() {
                currStep = step;
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
                    onSaved: (String value) {
                      //data.name = value;
                    },
                    maxLines: 2,
                    validator: (value) => (value.isEmpty || value.length < 1)
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
                    onSaved: (String value) {
                      //data.name = value;
                    },
                    maxLines: 2,
                    validator: (value) => (value.isEmpty || value.length < 1)
                        ? 'Please enter product brand'
                        : null,
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
                    onSaved: (String value) {
                      //data.name = value;
                    },
                    maxLines: 2,
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
                    onSaved: (String value) {
                      //data.name = value;
                    },
                    maxLines: 2,
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
                    onSaved: (String value) {
                      //data.name = value;
                    },
                    maxLines: 5,
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
                    onSaved: (String value) {
                      //data.name = value;
                    },
                    maxLines: 5,
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
                    onSaved: (String value) {
                      //data.name = value;
                    },
                    maxLines: 2,
                    validator: (value) =>
                        (value.isEmpty || double.parse(value) < 0)
                            ? 'Please enter a price'
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
        ),
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
            },
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: children,
            ),
          ),
        ),
        title: currStep == index ? Text(title) : SizedBox.shrink(),
        isActive: currStep == index);
  }
}
