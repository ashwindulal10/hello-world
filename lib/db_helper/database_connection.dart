import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDb{
  late Database db;

  Future open() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'footsall.db');
    //join is from path package
    print(path); //output /data/user/0/com.testapp.flutter.testapp/databases/demo.db

     db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute('''

                  CREATE TABLE IF NOT EXISTS user( 
                        id primary key,
                        name varchar(255) not null,
                        phone int not null,
                        address varchar(255) not null,
                        time_from varchar(255) not null,
                        time_to varchar(255) not null
                    );
                
                ''');
          print("Table Created");
        });
  }

  Future<Map<dynamic, dynamic>?> getStudent() async {
    List<Map> maps = await db.query('user');
    //getting user
    if (maps.length > 0) {
      return maps.first;
    }
    return null;
  }
}