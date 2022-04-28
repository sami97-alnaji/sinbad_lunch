import 'package:flutter/material.dart';

/****************************************************/

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ButtonStates(),
    );
  }
}
bool isAnimating = true;
//enum to declare 3 state of button
enum ButtonState { init, submitting, completed }
class ButtonStates extends StatefulWidget {
  const ButtonStates({Key? key}) : super(key: key);
  @override
  _ButtonStatesState createState() => _ButtonStatesState();
}
class _ButtonStatesState extends State<ButtonStates> {
  ButtonState state = ButtonState.init;
  @override
  Widget build(BuildContext context) {
    final buttonWidth = MediaQuery.of(context).size.width;
    // update the UI depending on below variable values
    final isInit = isAnimating || state == ButtonState.init;
    final isDone = state == ButtonState.completed;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(40),
        child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            onEnd: () => setState(() {
              isAnimating = !isAnimating;
            }),
            width: state == ButtonState.init ? buttonWidth : 70,
            height: 60,
            // If Button State is Submiting or Completed  show 'buttonCircular' widget as below
            child: isInit ? buildButton() : circularContainer(isDone)),
      ),
    );
  }
  // If Button State is init : show Normal submit button
  Widget buildButton() => ElevatedButton(
    style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
    onPressed: () async {
      // here when button is pressed
      // we are changing the state
      // therefore depending on state our button UI changed.
      setState(() {
        state = ButtonState.submitting;
      });
      //await 2 sec // you need to implement your server response here.
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        state = ButtonState.completed;
      });
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        state = ButtonState.init;
      });
    },
    child: const Text('SUBMIT'),
  );
  // this is custom Widget to show rounded container
  // here is state is submitting, we are showing loading indicator on container then.
  // if it completed then showing a Icon.
  Widget circularContainer(bool done) {
    final color = done ? Colors.green : Colors.blue;
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Center(
        child: done
            ? const Icon(Icons.done, size: 50, color: Colors.white)
            : const CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
/****************************************************/