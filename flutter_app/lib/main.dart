import 'package:flutter/material.dart';

import 'Stepper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Stepper Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentStep = 1;
  int stepLength = 5;
  bool complete;

  next() {
    if (currentStep <= stepLength) {
      goTo(currentStep + 1);
    }
  }

  back() {
    if (currentStep > 1) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
    if (currentStep > stepLength) {
      setState(() => complete = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          NumberStepper(
            totalSteps: stepLength,
            width: MediaQuery.of(context).size.width,
            curStep: currentStep,
            stepCompleteColor: Colors.blue,
            currentStepColor: Color(0xffdbecff),
            inactiveColor: Color(0xffbababa),
            lineWidth: 3.5,
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: currentStep <= stepLength
                ? Text(
                    "Step $currentStep",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.blue,
                    ),
                  )
                : Text(
                    "Completed!",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.blue,
                    ),
                  ),
          )
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: RaisedButton(
              disabledColor: Colors.grey[50],
              onPressed: currentStep == 1
                  ? null
                  : () {
                      back();
                    },
              child: Text('Back'),
            ),
          ),
          Expanded(
            child: RaisedButton(
              onPressed: () {
                next();
              },
              child: Text(
                currentStep == stepLength ? 'Finish' : 'Next',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}
