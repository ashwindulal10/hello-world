import 'dart:async';

import 'package:flutter/material.dart';
import 'package:footsall_booking_app/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'db_helper/database_connection.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}
class _DashboardState extends State<Dashboard> {
  List<Map> list = [];
  MyDb mydb = new MyDb();
  @override
  bool isLoggedIn = false;
  String name = '';
  void initState() {
    autoLogIn().whenComplete(() async {
      Timer(
        const Duration(seconds: 3),
            () {
          if(isLoggedIn==false)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>LoginScreen(),
            ),
          );
        },
      );
    });
    mydb.open();
    getdata();
    super.initState();
  }
    getdata(){
      Future.delayed(Duration(milliseconds: 500),() async {
        list = await mydb.db.rawQuery('SELECT * FROM user');
        setState(() { });
      });
    }
  Future autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');

    if (email != null) {
      setState(() {
        isLoggedIn = true;
        name = email;
      });
      return;
    }
  }
  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email','');

    setState(() {
      name = '';
      isLoggedIn = false;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: list.length == 0?Text("No any booking fiend."):
          Column(
            children: list.map((stuone){
              return Card(
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text(stuone["name"]),
                  subtitle: Text("Phone No:" + stuone["phone"].toString() + ", Add: " + stuone["address"]),
                  trailing: Wrap(children: [
                    IconButton(onPressed: () async {
                      await mydb.db.rawDelete("DELETE FROM user WHERE id = ?", [stuone["id"]]);
                      print("Data Deleted");
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User Data Deleted")));
                      getdata();
                    }, icon: Icon(Icons.delete, color:Colors.red))


                  ],),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}



