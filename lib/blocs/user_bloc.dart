import 'dart:async';
import 'dart:io';
import 'package:meta/meta.dart';
import '../model/user.dart';
import '../model/company.dart';
import '../model/profit.dart';
import '../repository/user_repository.dart';
import '../util/global.dart';

class UserBloc {
  final userRepository = new UserRepository();

  StreamController<User> _userController = new StreamController<User>.broadcast();
  Stream<User> get user => _userController.stream;

  getUser() async {
    _userController.sink.add(GlobalValue.getCurrentUser);
  }

  Future<bool> register({@required String username, @required String email, @required String password, @required confirmed_password}) async {
    return await userRepository.register(username: username, email: email, password: password, confirmed_password: confirmed_password);
  }

  // Future<bool> login({@required String email, @required String password}) async {
  //   return await userRepository.login(email: email, password: password);
  // }

  // Future<bool> logout() async {
  //   return await userRepository.logout();
  // }

  // Future<String> uploadPhoto({@required String uid, File imgFile}) async {
  //   return await userRepository.uploadPhoto(uid: uid, imgFile: imgFile);
  // }

  // Future<bool> addUser({@required User user}) async {
  //   return await userRepository.addUser(user: user);
  // }

  // Future<bool> updateUser({@required User user}) async {
  //   bool isSuccess = await userRepository.updateUser(user: user);
  //   return isSuccess;
  // }

  // Future<bool> addCompany({@required Company company, @required String userId}) async {
  //   return await userRepository.addCompany(company: company, userId: userId);
  // }

  // Future<bool> addNonProfit({@required Profit profit, @required String userId}) async {
  //   return await userRepository.addNonProfit(profit: profit, userId: userId);
  // }

  dispose() {
    _userController.close();
  }

}