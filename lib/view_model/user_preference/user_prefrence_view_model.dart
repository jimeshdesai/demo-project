import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants.dart';

class UserPreference {
  Future<bool> saveUser(UserModel responseModel, dynamic value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    // sp.setString(Constants.token, responseModel.token.toString());
    // sp.setBool(Constants.isLogin, responseModel.isLogin!);
    print(responseModel.token.toString());
    if (value['user']['first_name'] != null &&
        value['user']['last_name'] != null) {
      // sp.setString(Constants.firstname, value['user']['first_name']);
      // sp.setString(Constants.lastname, value['user']['last_name']);
    }
    return true;
  }

  static Future<UserModel> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    //String? token = sp.getString(Constants.token);
    //bool? isLogin = sp.getBool(Constants.isLogin);
    return UserModel(token: token, isLogin: isLogin);
  }

  Future<bool> removeUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return true;
  }

  void cleanData(context) {
  }
}
