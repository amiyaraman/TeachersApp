import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'snglerowview.dart';

class HomeWidget extends StatelessWidget {
  late DatabaseReference _counterRef;
  var user;
  HomeWidget(){

    final auth = FirebaseAuth.instance;
    user = auth.currentUser!.uid;
    _counterRef = FirebaseDatabase.instance.reference().child('StudentsINfo').child(user);
  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        // padding: EdgeInsets.only(left: 0,bottom: 15,right: 0,top: 15),
        child: Column(
          children: <Widget>[
            Flexible(
              child: FirebaseAnimatedList(
                query: _counterRef,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  print("super");
                  print(snapshot.value);
                  return Container(
                    child: Row(
                      children: [
                        Container(
                          child: EachRowView(NameOfStudent: snapshot.value['Name'],
                              Gender: snapshot.value['Gender'],
                              DOB:snapshot.value['Date Of Birth'],
                              RollNumber:snapshot.value['Roll Number'],
                            snapshot: snapshot,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
