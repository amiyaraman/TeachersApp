import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SaveDataView extends StatefulWidget {
  SaveDataView({required this.app});

  final FirebaseApp app;

  @override
  _SaveDataViewState createState() => _SaveDataViewState();
}

class _SaveDataViewState extends State<SaveDataView> {
  late DatabaseReference _counterRef;
  late DatabaseReference _messagesRef;
  late StreamSubscription<Event> _counterSubscription;
  late StreamSubscription<Event> _messagesSubscription;
  final field_one = TextEditingController();
  final field_two = TextEditingController();

  String _kTestKey = 'Hello';
  String _kTestValue = 'world!';
  DatabaseError? _error;

  @override
  void initState() {
    super.initState();
    _counterRef = FirebaseDatabase.instance
        .reference()
        .child("something")
        .child('StudentsINfo');
    _counterRef.once().then((DataSnapshot snapshot) {
      print("this is something ");
      print(snapshot.value);
    });
    final FirebaseDatabase database = FirebaseDatabase();
    _messagesRef = database.reference().child('StudentsINfo');
    database
        .reference()
        .child('StudentsINfo')
        .get()
        .then((DataSnapshot? snapshot) {
      print(
          'Connected to directly configured database and read ${snapshot!.value}');
    });
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _counterRef.keepSynced(true);
    _counterSubscription = _counterRef.onValue.listen((Event event) {
      setState(() {
        _error = null;
      });
    }, onError: (Object o) {
      final DatabaseError error = o as DatabaseError;
      setState(() {
        _error = error;
      });
    });
    _messagesSubscription =
        _messagesRef.limitToLast(10).onChildChanged.listen((Event event) {
      print('Child added: ${event.snapshot.value}');
    }, onError: (Object o) {
      final DatabaseError error = o as DatabaseError;
      print('Error: ${error.code} ${error.message}');
    });
  }

  @override
  void dispose() {
    super.dispose();
    _messagesSubscription.cancel();
    _counterSubscription.cancel();
  }

  Future<void> _addtofirebase(
      {required String Keydata, required String Value}) async {
    await _counterRef.push().set(<String, String>{
      "Name": Value,
      "class": Keydata,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Card(
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(labelText: "Title"),
                          controller: field_one,
                        ),
                        TextField(
                          decoration: InputDecoration(labelText: "Amount"),
                          controller: field_two,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              String name = field_one.text;
                              String Class = field_two.text;
                              _addtofirebase(Keydata: name, Value: Class);
                            },
                            child: Text("Submit")),
                        Flexible(
                          child: FirebaseAnimatedList(
                              query: _counterRef,
                              itemBuilder: (BuildContext context,
                                  DataSnapshot snapshot,
                                  Animation<double> animation,
                                  int index) {
                                print("super");
                                print(snapshot.value);
                                return Container(
                                    child: Row(children: [
                                  ElevatedButton(
                                      onPressed: () {},
                                      child: Text('To Remove')),
                                  SizeTransition(
                                    sizeFactor: animation,
                                    child: ListTile(
                                      trailing: IconButton(
                                        onPressed: () => _messagesRef
                                            .child(snapshot.key!)
                                            .remove(),
                                        icon: const Icon(Icons.delete),
                                      ),
                                      title: Text(
                                        '${snapshot.value['Name'].toString()}',
                                      ),
                                    ),
                                  )
                                ]));
                              }),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
