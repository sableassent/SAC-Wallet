import 'dart:io';
import 'package:meta/meta.dart';
import '../client/user_client.dart';
import '../model/user.dart';
import '../model/company.dart';
import '../model/profit.dart';

class UserRepository {
  final UserClient userClient = new UserClient();

  Future<bool> register({@required String username, @required String email, @required String password, @required confirmed_password}) async => await userClient.register(username: username, email: email, password: password, confirmed_password: confirmed_password);

  // Future<bool> login({@required String email, @required String password}) async => await userClient.login(email: email, password: password);

  // Future<bool> logout() async => await userClient.logout();

  // Future<String> uploadPhoto({@required String uid, File imgFile}) async => await userClient.uploadPhoto(uid: uid, imgFile: imgFile);

  // Future<bool> addUser({@required User user}) async => await userClient.addUser(user: user);

  // Future<bool> updateUser({@required User user}) async => await userClient.updateUser(user: user);

  // Future<bool> addCompany({@required Company company, @required String userId}) async => await userClient.addCompany(company: company, userId: userId);


  // Future<bool> addNonProfit({@required Profit profit, @required String userId}) async => await userClient.addNonProfit(profit: profit, userId: userId);

}