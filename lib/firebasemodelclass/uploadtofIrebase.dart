import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UploadToFirebase {
  late DatabaseReference _counterRef;
  var user;
  final auth = FirebaseAuth.instance;

  UploadToFirebase() {
    user = auth.currentUser!.uid;
    _counterRef = FirebaseDatabase.instance.reference().child('StudentsINfo').child(user);
    _counterRef.keepSynced(true);

  }

  Future<void> addtofirebase({required String name, required String dob , required String gender , required String rollnumber}) async {
    await _counterRef.push().set(<String, String>{
      "Name": name,
      "Date Of Birth": dob,
      "Gender" : gender,
      "Roll Number":rollnumber,
    });}

    void DeleteData(DataSnapshot snapshot){
             _counterRef.child(snapshot.key!).remove();
  }
  void UpdateValue({required String Infochild , required String ChildKey,required String UpdatedValue}){
    _counterRef.child(ChildKey).child(Infochild).set(UpdatedValue).whenComplete(() {
      print("Success hogya");
    });

  }
}