import 'package:filo/Views/Welcome/Welcome.dart';
import 'package:flutter/material.dart';
import '../../Widgets/CustomButton.dart';
import '../Login/Login.dart';
import '../Signup/Signup.dart';

// Pantalla inicial Sign up, Log in, Skip
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: Column(
        children: <Widget>[
          // imagen corrientazo
          Expanded(
            child: Image.asset(
              "pictures/images/corrientazo1.jpg",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  ("Fi-Lo"),
                  style: TextStyle(fontSize: 50.0),
                ),
                SizedBox(
                  height: 15.0,
                ),
                // Boton Sign Up -> lleva a vista sign up
                CustomButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signup()));
                  },
                  text: "Sign Up",
                  color: Colors.red,
                  width: 250.0,
                ),
                SizedBox(
                  height: 5.0,
                ),
                // Boton Log In -> lleva a vista Log In
                CustomButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  text: "Log In",
                  color: Colors.black,
                  width: 250.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                // Boton Skip, salta a Welcome (cambiar por ingreso anonimo)
                CustomButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Welcome()));
                  },
                  text: "Skip",
                  color: Colors.blue,
                  width: 250.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
