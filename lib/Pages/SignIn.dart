import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  var email;
  var password;

  // Create storage
  final storage = new FlutterSecureStorage();

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Future<void> loginCheck() async{
    try {
      print("this is the email : - $email");
      print("this is the password : - $password");
      Response response = await post(
        Uri.http('10.0.2.2:3000', '/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password
        }),
      );


        // Write value
      if(response.statusCode == 200) {
        await storage.write(key: 'jwt', value: response.body);

        print("The save is done");
        String value = await storage.read(key: "jwt");
        print("The value is $value");
        Navigator.popAndPushNamed(context, '/home');
      }
      else {
        showAlertDialog(context,response.body);
      }


    }
    catch(e)
    {
      print('caught error: $e');
    }

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: <Widget>[ Stack(
          children: <Widget>[
            Image(image: AssetImage("assets/headerlog.png")),

             Padding(
               padding: const EdgeInsets.fromLTRB(20.0,30.0,20.0,0),
               child: Text("Welcome Back!",style: TextStyle(fontSize: 45.0,color: Colors.white),),
             ),
            SizedBox(height: 10.0,),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0,80.0,20.0,0),
              child: Text("Please login to your account",style: TextStyle(fontSize: 20.0,color: Colors.white38),),
            ),


          ],
        ),
            Container(child: Text("LOGIN HERE",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),margin: EdgeInsets.all(50.0)),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) {
                    email = value;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter email address',

                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) {
                  password= value;

                },
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your secure password'
                ),
              ),
            ),
            SizedBox(child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green[300],shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))),
                child: Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                onPressed: () async{
                    await loginCheck();
                    print("Done with the login action");
                },

            ), width: 300.0,),
            Container(child: FlatButton(
              color: Colors.transparent,
              onPressed:() => Navigator.pushNamed(context, "/register") ,
              child: Text("Register here",style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.underline),),
            ),margin: EdgeInsets.fromLTRB(30, 40, 30, 0),)
            

          ],
        ),
      ),

      ),
    );
  }
}

showAlertDialog(BuildContext context,String text) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () { Navigator.of(context).pop();},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text(text),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
