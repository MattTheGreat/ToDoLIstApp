import 'package:flutter/material.dart';
import 'package:todo_app/state_widget.dart';
import 'package:todo_app/widgets/stateless/google_sign_in_button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Private methods within build method help us to
    // organize our code and recognize structure of widget
    // that we're building:
    Text _buildText() {
      return Text(
        'Recipes',
        textAlign: TextAlign.center,
      );
    }

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildText(),
            TextField(
              //controller: _titleController,
              decoration: InputDecoration(
                labelText: "Title:"
              ),
            ),
            TextField(
              //controller: _descriptionController,
              decoration: InputDecoration(
                labelText: "Description:"
              ),
            ),

            // Space between "Recipes" and the button:
            SizedBox(height: 50.0),
            GoogleSignInButton(onPressed: () => 
            StateWidget.of(context).signInWithGoogle()
            //Navigator.of(context).pushReplacementNamed('/Home')
            ,)
          ],
        ),
      ),
    );
  }
}
