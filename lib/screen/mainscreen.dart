import 'package:assigment/widget/addstudentinfowidget.dart';
import 'package:assigment/widget/homewidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {


  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    AddStudentInfoWidget(),  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
            label: 'Add Info',

          )
        ],
        currentIndex: _selectedIndex,
        onTap: (givenindex)
        {
          setState(() {
            _selectedIndex=givenindex;
          });


        },

      ),
    );
  }
}
