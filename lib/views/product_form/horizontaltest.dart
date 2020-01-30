import 'package:eshop/shared/ui_helpers.dart';
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
                  Navigator.of(context).pop();
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
              return Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    currStep == 4 // this is the last step
                        ? RaisedButton.icon(
                            icon: Icon(Icons.create),
                            onPressed: () {},
                            label: Text('CREATE'),
                            color: Colors.green,
                          )
                        : RaisedButton.icon(
                            icon: Icon(Icons.navigate_next),
                            onPressed: onStepContinue,
                            label: Text('CONTINUE'),
                            color: Colors.pink,
                          ),
                    FlatButton.icon(
                      icon: Icon(Icons.delete_forever),
                      label: const Text('CANCEL'),
                      onPressed: onStepCancel,
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
              Step(
                  content: Container(
                    height: screenHeightFraction(context, dividedBy: 1.65),
                    child: Text('conent'),
                  ),
                  title: Text('title'),
                  isActive: currStep == 0),
              Step(
                  content: Container(
                    height: screenHeightFraction(context, dividedBy: 1.65),
                    child: Text('conent'),
                  ),
                  title: Text('title'),
                  isActive: currStep == 1),
              Step(
                  content: Container(
                    height: screenHeightFraction(context, dividedBy: 1.65),
                    child: Text('conent'),
                  ),
                  title: Text('title'),
                  isActive: currStep == 2),
              Step(
                  content: Container(
                    height: screenHeightFraction(context, dividedBy: 1.65),
                    child: Text('conent'),
                  ),
                  title: Text('title'),
                  isActive: currStep == 3),
              Step(
                  content: Container(
                    height: screenHeightFraction(context, dividedBy: 1.65),
                    child: Text('conent'),
                  ),
                  title: Text('title'),
                  isActive: currStep == 4),
            ],
          ),
          /* Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                child: RaisedButton(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'SAVE',
                    ),
                  ),
                  onPressed: _submitDetails,
                ),
              ), */
        ),
      ),
    );
  }
}
