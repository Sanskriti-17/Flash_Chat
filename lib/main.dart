import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'package:flash_card/screens/login_screen.dart';
import 'package:flash_card/screens/registration_screen.dart';
import 'package:flash_card/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute : WelcomeScreen.id,
      routes: {
        WelcomeScreen.id : (context)=> WelcomeScreen(),
        RegistrationScreen.id :(context)=> RegistrationScreen(),
        LoginScreen.id : (context)=> LoginScreen(),
        ChatScreen.id : (context)=> ChatScreen()
      },
    );
  }
}
