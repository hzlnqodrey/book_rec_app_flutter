import 'package:hive_flutter/hive_flutter.dart';
import 'package:book_recomendation_hazlan/models/shared_preference.dart';
import 'package:book_recomendation_hazlan/models/user.dart';
import 'package:bcrypt/bcrypt.dart';

class HiveDatabase {
  Box<DataModel> _localDB = Hive.box<DataModel>("data");

  void addData(DataModel data) {
    _localDB.add(data);
  }

  int getLength() {
    return _localDB.length;
  }

  bool checkLogin(String username, String password) {
    bool found = false;
    for (int i = 0; i < getLength(); i++) {
      if (username == _localDB.getAt(i)!.username && password == _localDB.getAt(i)!.password) {
        SharedPreference().setLogin(username);
        print("Login Success");
        found = true;
        break;
      } else {
        found = false;
      }
    }

    return found;
  }

  String? getHashedPassword(String username) {
    for (int i = 0; i < getLength(); i++) {
      if (username == _localDB.getAt(i)!.username) {
        return _localDB.getAt(i)!.password;
      }
    }
    return null; // Return null if the username is not found
  }

  Future<bool> comparePassword(String password, String hashedPassword) async {
    return await BCrypt.checkpw(password, hashedPassword);
  }
}
