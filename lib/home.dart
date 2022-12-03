import 'package:flutter/material.dart';

import 'db_helper/database_connection.dart';
import 'login.dart';
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
   TextEditingController Name=TextEditingController();
   TextEditingController Phone=TextEditingController();
   TextEditingController Address=TextEditingController();
   TextEditingController From=TextEditingController();
   TextEditingController To=TextEditingController();
  MyDb mydb = new MyDb();
  @override
  void initState() {
    mydb.open(); //initilization database
    super.initState();
  }


  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 1,
            ),
            Center(
              child: Text('Please fill the form for your footsall book time',
                style: TextStyle(
                    height: 10,
                    color: Colors.green),
              ),
            ),
            Container(
              child: TextField(
                controller: Name,
                decoration: InputDecoration(
                    hintText: 'name',
                    labelText: 'Name'
                ),
              ),
            ),
            Container(
              child: TextField(
                controller: Phone,
                decoration: InputDecoration(
                    hintText: 'Phone',
                    labelText: 'Phone'
                ),
              ),
            ),
            Container(
              child: TextField(
                controller: Address,
                decoration: InputDecoration(
                    hintText: 'Address',
                    labelText: 'Address'
                ),
              ),
            ),
            Container(
              child: TextField(
                controller: From,
                decoration: InputDecoration(
                    hintText: 'From',
                    labelText: 'From'
                ),
              ),
            ),
            Container(
              child: TextField(
                controller: To,
                decoration: InputDecoration(
                    hintText: 'To',
                    labelText: 'To'
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  // Save new data
                  mydb.db.rawInsert("INSERT INTO user (name, phone, address, time_from, time_to) VALUES (?, ?, ?, ?, ?);",
                      [Name.text, Phone.text, Address.text,From.text,To.text]);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Form Submitted")));
                  //show snackbar message after adding user
                  // Clear the text fields
                  Name.text ='';
                  Phone.text ='';
                  Address.text ='';
                  From.text ='';
                  To.text = '';
                },
                child: Text('Submit')),
            SizedBox(
              height: 50,
            ),
            InkWell(
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              ),
              child: Center(
                child: Container(
                  child:Text("Admin Panel",style: TextStyle(color: Colors.green),) ,
                ),
              ),
            )
          ],

        ),


      ),

    );



  }
}