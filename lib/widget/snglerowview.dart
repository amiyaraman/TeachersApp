import 'dart:math';

import 'package:assigment/firebasemodelclass/uploadtofIrebase.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EachRowView extends StatefulWidget {
  String NameOfStudent;
  String RollNumber;
  String Gender;
  String DOB;
  DataSnapshot snapshot;

  EachRowView({
    required this.NameOfStudent,
    required this.RollNumber,
    required this.Gender,
    required this.DOB,
    required this.snapshot,
  });

  @override
  _EachRowViewState createState() => _EachRowViewState();
}

class _EachRowViewState extends State<EachRowView> {
  UploadToFirebase Upload = new UploadToFirebase();
  var _chossevalue;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new InkWell(
        onTap: () {
          EditStudentInfo(context);
          print("tapped");
        },
        child: Card(
          elevation: 5,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      width: 2 * MediaQuery.of(context).size.width / 3,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              widget.NameOfStudent.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ]),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: 2 * MediaQuery.of(context).size.width / 3,
                      child: Row(children: [
                        Text(
                          'Roll Number: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          widget.RollNumber.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ]),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width / 3,
                            child: Row(children: [
                              Text(
                                'Gender: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                widget.Gender.toString(),
                                style: TextStyle(fontSize: 16),
                              ),
                            ]),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Row(children: [
                              Text(
                                'DOB: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                widget.DOB.toString(),
                                style: TextStyle(fontSize: 16),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 8,
                      ),
                      IconButton(
                          onPressed: () {
                            Upload.DeleteData(widget.snapshot);
                          },
                          icon: Icon(Icons.clear)),
                    ]),
              ),
            ],
          ),
        ),
      ),
      width: MediaQuery.of(context).size.width,
    );
  }

  void EditStudentInfo(context) {
    var namecontroller = TextEditingController();
    var rollNumbercontroller = TextEditingController();
    var picked;
    var date1 = DateFormat('d-MM-yyyy');
    showBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: Container(
                width: 3 * MediaQuery.of(context).size.width / 4,
                child: Column(
                  children: [
                    Row(children: [
                      Container(
                        width: 4 * MediaQuery.of(context).size.width / 5,
                        child: TextField(
                          controller: namecontroller,
                          decoration: InputDecoration(
                            labelText: "Update Student Name",
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            if (!namecontroller.text.isEmpty) {
                              Upload.UpdateValue(
                                  Infochild: "Update Student Name",
                                  ChildKey: widget.snapshot.key.toString(),
                                  UpdatedValue: namecontroller.text);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Please Fill the value"),
                              ));
                            }
                          },
                          icon: Icon(Icons.done)),
                    ]),
                    Row(children: [
                      Container(
                        width: 4 * MediaQuery.of(context).size.width / 5,
                        child: TextField(
                          controller: rollNumbercontroller,
                          decoration: InputDecoration(
                            labelText: "Update RollNumber",
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            if (!rollNumbercontroller.text.isEmpty) {
                              Upload.UpdateValue(
                                  Infochild: "Roll Number",
                                  ChildKey: widget.snapshot.key.toString(),
                                  UpdatedValue: rollNumbercontroller.text);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Please Fill the value"),
                              ));
                            }
                          },
                          icon: Icon(Icons.done)),
                    ]),
                    Row(children: [
                      Text('Update DOB'),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 3 * MediaQuery.of(context).size.width / 5,
                        child: DateTimeField(
                          format: DateFormat("yyyy-MM-dd"),
                          onShowPicker: (context, currentValue) async {
                            picked = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));

                            return picked;
                          },
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            if (picked == null || picked.toString().isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Please Fill the value"),
                              ));
                            } else {
                              picked = date1.format(picked);
                              Upload.UpdateValue(
                                  Infochild: "Date Of Birth",
                                  ChildKey: widget.snapshot.key.toString(),
                                  UpdatedValue: picked.toString());
                            }
                          },
                          icon: Icon(Icons.done)),
                    ]),
                    Row(children: [
                      Text('Update Gender '),
                      Container(
                        padding: EdgeInsets.only(
                            bottom: 0, top: 0, left: 10, right: 10),
                        child: DropdownButton<String>(
                          value: _chossevalue,
                          style: TextStyle(color: Colors.blueAccent),
                          items: <String>['Male', 'Female', 'Other']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _chossevalue = value;
                            });
                          },
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            if (_chossevalue == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Please Fill the value"),
                              ));
                            } else {
                              Upload.UpdateValue(
                                  Infochild: "Gender",
                                  ChildKey: widget.snapshot.key.toString(),
                                  UpdatedValue: _chossevalue);
                            }
                          },
                          icon: Icon(Icons.done)),
                    ]),
                  ],
                ),
              ));
        });
  }
}
