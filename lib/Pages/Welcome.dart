import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
               padding: const EdgeInsets.fromLTRB(30.0,50.0,30.0,0),
               child: Image(image: AssetImage("assets/logo.png"),
            height: 80.0,
                width: 400.0,
            ),
             ),
            SizedBox(height: 40.0,),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,0),
              child: Text(
                "Excited?",style: TextStyle(fontSize: 30.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child: Text(
                "You should be",style: TextStyle(fontSize: 30.0),
              ),
            ),
            SizedBox(height: 40.0,),
            Center(child:Text("Sign in if you already have an account",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),)
            ),
            SizedBox(height: 20.0,),
            Center(
              child: SizedBox(child: RaisedButton(
                  color: Colors.green[600],
                  child: Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                  onPressed: () {
                    Navigator.pushNamed(context, "/login");
                  },
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
              ), width: 300.0,),
            ),
            SizedBox(height: 40.0,),
            Center(child:Text("Or Sign up if you are new!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),)
            ),
            SizedBox(height: 20.0,),
            Center(
              child: SizedBox(child: RaisedButton(
                  color: Colors.green[600],
                  child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                  onPressed: () {
                    Navigator.pushNamed(context, "/register");
                  },
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
              ), width: 300.0,),
            )


          ],
        ),
      ),
    );
  }
}
