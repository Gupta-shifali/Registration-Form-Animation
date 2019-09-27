import 'package:flutter/material.dart';

import 'RegistrationForm.dart';

void main() => runApp(FormApp());

class FormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FormWidget(),
    );
  }
}

class FormWidget extends StatefulWidget {
  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget>
    with SingleTickerProviderStateMixin {
  Animation buttonSqueezeAnimation;
  Animation buttonZoomOutAnimation;
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    buttonSqueezeAnimation = new Tween(begin: 300.0, end: 100.0).animate(
        CurvedAnimation(
            parent: _animationController, curve: Interval(0.0, 0.150)));
    buttonZoomOutAnimation = new Tween(begin: 70.0, end: 1000.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.250, 0.500, curve: Curves.bounceOut)));
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => RegistrationForm()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: buttonZoomOutAnimation.value < 400 ? 5.0 : 0.0,
        backgroundColor: Color.fromRGBO(124, 0, 255, 0.7),
        title: Text("Registration Form"),
      ),
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => _buildLoginForm()),
    );
  }

  Widget _buildLoginForm() {
    return Hero(
      tag: "fade",
      child: Center(
        child: Container(
          height: buttonZoomOutAnimation.value == 70.0
              ? 70.0
              : buttonZoomOutAnimation.value,
          width: buttonZoomOutAnimation.value == 70.0
              ? buttonSqueezeAnimation.value
              : buttonZoomOutAnimation.value,
          child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: buttonZoomOutAnimation.value < 400
                      ? BorderRadius.circular(40)
                      : BorderRadius.circular(0)),
              elevation: 5.0,
              color: Color.fromRGBO(124, 0, 255, 0.6),
              child: buttonSqueezeAnimation.value > 100.0
                  ? _buildButton()
                  : buttonZoomOutAnimation.value < 300.0
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : null,
              onPressed: () {
                _animationController.forward();
//                await _animationController.reverse();
              }),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Center(
          child: CircleAvatar(
            backgroundColor: Colors.amberAccent,
            child: Icon(
              Icons.face,
              color: Colors.black,
            ),
          ),
        ),
        Text(
          "Welcome!!",
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
