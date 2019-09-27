import 'package:flutter/material.dart';

import 'main.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm>
    with SingleTickerProviderStateMixin {
  Animation fadeAnimation;
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    fadeAnimation = new ColorTween(
            begin: Color.fromRGBO(124, 0, 255, 1.0),
            end: Color.fromRGBO(124, 0, 256, 0.0))
        .animate(
            CurvedAnimation(parent: _animationController, curve: Curves.ease));
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "fade",
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(124, 0, 255, 0.6),
          title: Text("Registration Form"),
        ),
        body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => Container(
            color: fadeAnimation.value,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[_selectGender(), _fillFields(), _submit()],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _submit() => Padding(
        padding: const EdgeInsets.all(30.0),
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
          elevation: 10.0,
          onPressed: () {
            debugPrint("Submitted");
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => FormWidget()));
          },
          color: Color.fromRGBO(124, 0, 255, 0.6),
          splashColor: Colors.white,
          height: 55.0,
          child: Text("REGISTER",
              style:
                  TextStyle(fontWeight: FontWeight.w900, color: Colors.white)),
        ),
      );

  Container _fillFields() => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration:
                    InputDecoration(hintText: "Name", labelText: "Name"),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    hintText: "Contact No", labelText: "Contact No"),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: TextField(
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                    hintText: "Github Link", labelText: "Github Link"),
              ),
            )
          ],
        ),
      );

  Container _selectGender() => Container(
        child: Row(
          children: <Widget>[
            _getGender("assets/images/male.png", "Male"),
            _getGender("assets/images/female.png", "Female"),
          ],
        ),
      );

  Card _getGender(String imageIcon, String gender) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: EdgeInsets.fromLTRB(25, 25, 12, 20),
      child: InkWell(
        splashColor: Color.fromRGBO(124, 0, 255, 0.6),
        onTap: () {},
        child: Container(
          width: 130.0,
          height: 130.0,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20.0),
                child: Image.asset(imageIcon),
                alignment: Alignment.center,
              ),
              Text(gender,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
            ],
          ),
        ),
      ),
    );
  }
}
