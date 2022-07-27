import 'package:flash_card/screens/login_screen.dart';
import 'package:flash_card/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_card/services/Button_Properties.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id='welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}
class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller=AnimationController(
        vsync: this,
      duration: Duration(seconds: 3),
    );
    controller.forward();

    controller.addListener(() {
      setState(() {
      });
    });

  }

  @override
  void dispose() {
   controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                DefaultTextStyle(
                  child: AnimatedTextKit(
                    animatedTexts: [TypewriterAnimatedText('Flash Chat')],
                    isRepeatingAnimation: false,

                    ),
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            ButtonProperties(
              colour: Colors.lightBlueAccent,
              label: 'Log In',
              onpressed: (){
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            ButtonProperties(
              colour: Colors.blueAccent,
                onpressed: (){
              Navigator.pushNamed(context, RegistrationScreen.id);
            },
                label: 'Register'
            )
        ]
    )
    )
    );
  }
}

