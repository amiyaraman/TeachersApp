import 'package:assigment/firebasemodelclass/uploadtofIrebase.dart';
import 'package:assigment/screen/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class AddStudentInfoWidget extends StatefulWidget {
  const AddStudentInfoWidget({Key? key}) : super(key: key);

  @override
  _AddStudentInfoWidgetState createState() => _AddStudentInfoWidgetState();
}

class _AddStudentInfoWidgetState extends State<AddStudentInfoWidget> {
  var date1 = DateFormat('d-MM-yyyy');
  var picked;
  var _chossevalue;
  final field_one = TextEditingController();
  final field_two = TextEditingController();
  UploadToFirebase uploadToFirebase = new UploadToFirebase();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: 0,
                  top: MediaQuery.of(context).size.height / 7,
                  right: 0,
                  bottom: 0),
              // height: ,
              // width: double.infinity,

              color: Colors.white,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(4),
                  child: Card(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          TextField(
                            decoration:
                                InputDecoration(labelText: "Student Name"),
                            controller: field_one,
                            // onChanged: (value){
                            //   titleInput = value;
                            // },
                          ),
                          TextField(
                            decoration: InputDecoration(
                                labelText: "Student RollNumber"),
                            controller: field_two,
                            keyboardType: TextInputType.number,
                            // onChanged: (value){
                            //   AmountInput = value;
                            // },
                          ),
                          Row(children: [
                            Text('DOB'),
                            Container(
                              padding: EdgeInsets.all(10),
                              width:
                                  4 * (MediaQuery.of(context).size.width / 5),
                              child: DateTimeField(
                                format: DateFormat("yyyy-MM-dd"),
                                onShowPicker: (context, currentValue) async {
                                  picked = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1900),
                                      initialDate:
                                          currentValue ?? DateTime.now(),
                                      lastDate: DateTime(2100));

                                  return picked;
                                },
                              ),
                            ),
                          ]),
                          Row(children: [
                            Text('Gender:'),
                            Container(
                              padding: EdgeInsets.only(
                                  bottom: 0, top: 0, left: 10, right: 10),
                              child: DropdownButton<String>(
                                value: _chossevalue,
                                style: TextStyle(color: Colors.blueAccent),
                                items: <String>[
                                  'Male',
                                  'Female',
                                  'Other'
                                ].map<DropdownMenuItem<String>>((String value) {
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
                          ]),
                          ElevatedButton(
                              onPressed: () {
                                if (picked == null ||
                                    field_one.text.isEmpty ||
                                    field_two.text.isEmpty ||
                                    _chossevalue == null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Please Fill the value"),
                                  ));
                                } else {
                                  picked = date1.format(picked);
                                  uploadToFirebase.addtofirebase(
                                      name: field_one.text,
                                      dob: picked.toString(),
                                      gender: _chossevalue,
                                      rollnumber: field_two.text);
                                  field_one.clear();
                                  field_two.clear();
                                }
                              },
                              child: Text("Submit")),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: 0,
                  top: MediaQuery.of(context).size.height / 7,
                  right: 0,
                  bottom: 0),
              child: ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text("Log Out")),
            ),
          ],
        ),
      ),
    );
  }
}
