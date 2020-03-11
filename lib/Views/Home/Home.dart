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
      body: SafeArea(
        bottom: false,
        top: false,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: new AssetImage(
                    'pictures/images/logo.png'
                    ),
              fit: BoxFit.cover,
              ),
            ),
            child: Container(

              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
                  CustomButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Welcome()));
                    },
                    text: "Skip",
                    color: Color(0x44000000),
                    width: 80.0,
                  ),
                SizedBox(
                height: 370.0,
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

            // Boton Sign Up -> lleva a vista sign up
                      CustomButton(
                        onPressed: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Signup()));
                        },
                        text: "Sign Up",
                        color: Color(0xffff0000),
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
                      SizedBox(
                       height: 20.0,
                      ),
                  ],
              ),
            )
            ]
        ),
      )

      )
      )
    );
  }
}
