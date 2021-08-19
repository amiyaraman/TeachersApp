import 'package:assigment/screen/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import './verify.dart';


class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
              child: Text("Teacher's App"
              ),
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
                      style: TextStyle(fontSize: 18,
                          color:Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email),
                          hintStyle:TextStyle(fontSize: 20,
                              color: Colors.grey),
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: TextField(
                      obscureText: true,
                      style: TextStyle(fontSize: 18,
                          color:Colors.black),
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          hintStyle: TextStyle(fontSize: 20,
                              color: Colors.grey
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text).whenComplete(() {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => verify()));
                            });

                      } catch (e) {
                        print(e);
                        if (passwordController.text.length <= 6) {
                          var snackBar= SnackBar(content: Text(e.toString(),style: TextStyle(fontSize: 20,
                          ),));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }

                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 45,
                      decoration: BoxDecoration(
                          gradient:
                          LinearGradient(colors: GradientColors.royalBlue),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(fontSize: 25,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  InkWell(
                    onTap:()=>{
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()))},
                    child: Container(
                      width:MediaQuery.of(context).size.width/2,
                      height: 30,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: GradientColors.red),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(
                        child: Text("LOGIN Page",style: TextStyle(
                            fontSize: 10,
                            color: Colors.white
                        ),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
