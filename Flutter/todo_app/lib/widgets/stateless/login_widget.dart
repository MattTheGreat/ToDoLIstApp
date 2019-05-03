import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/state_widget.dart';
//import 'package:todo_app/widgets/stateless/google_sign_in_button.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, //or set color with: Color(0xFF0000FF)
    ));
    // Private methods within build method help us to
    // organize our code and recognize structure of widget
    // that we're building:
    Text _buildText() {
      return Text(
        'Todo App',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 60, fontFamily: 'Nadia'),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 100.0),
            _buildText(),
            // TextField(
            //   //controller: _titleController,
            //   decoration: InputDecoration(
            //     labelText: "Title:"
            //   ),
            // ),
            // TextField(
            //   //controller: _descriptionController,
            //   decoration: InputDecoration(
            //     labelText: "Description:"
            //   ),
            // ),

            // Space between "Recipes" and the button:
            SizedBox(height: 200.0),
            GoogleSignInButton(onPressed: () => 
            StateWidget.of(context).signInWithGoogle(),
            darkMode: true
            //Navigator.of(context).pushReplacementNamed('/Home')
            ,),
            SizedBox(height: 200.0),
            Text("Powered By #Codelife")
          ],
        ),
      ),
    );
  }
}
