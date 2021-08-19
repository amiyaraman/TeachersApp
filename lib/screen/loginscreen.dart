import 'package:assigment/screen/mainscreen.dart';
import 'package:assigment/screen/registerscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: GradientColors.blue)),
            child: Center(
              child: Text("Teacher's App"),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.6,
              margin: EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: const Offset(0, 3))
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: TextField(
                      controller: emailController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email),
                          hintStyle:
                              TextStyle(fontSize: 20, color: Colors.grey)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () async {
                      try {
                        int count = 0;
                        await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)
                            .whenComplete(() => {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MainScreen()))
                                });
                      } catch (e) {
                        print(e);
                        var snackBar = SnackBar(
                            content: Text(
                          e.toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 45,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: GradientColors.beautifulGreen),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "SIGN IN",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegisterScreen()))
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 30,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: GradientColors.red),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          "Register Page",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () => changepassword(),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 30,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: GradientColors.red),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  TextEditingController emailchange = TextEditingController();

  changepassword() async {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 200,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      controller: emailchange,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email),
                          hintStyle:
                              TextStyle(fontSize: 20, color: Colors.grey)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () => linksender(),
                    child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 40,
                        decoration: BoxDecoration(
                            gradient:
                                LinearGradient(colors: GradientColors.red),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            "Get Link",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }

  linksender() async {
    bool error = false;
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailchange.text);
      Navigator.of(context).pop();
    } catch (e) {
      var snackBar = SnackBar(
          content: Text(
        e.toString(),
        style: TextStyle(
          fontSize: 20,
        ),
      ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      error = true;
    }
    if (!error) {
      var snackBar = SnackBar(
          content: Text(
        "Password Reset Link sent to email",
        style: TextStyle(
          fontSize: 18,
        ),
      ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      emailchange = TextEditingController();
    }
  }
}
