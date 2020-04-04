import 'dart:async';
import 'dart:io';
import 'package:meta/meta.dart';
import '../model/user.dart';
import '../model/company.dart';
import '../model/profit.dart';
import '../repository/firebase_repository.dart';
import '../util/global.dart';

class FirebaseBloc {
  final firebaseRepository = new FirebaseRepository();

  StreamController<User> _userController = new StreamController<User>.broadcast();
  Stream<User> get user => _userController.stream;

  getUser() async {
    _userController.sink.add(GlobalValue.getCurrentUser);
  }

  Future<bool> register({@required String name, @required String email, @required String password}) async {
    return await firebaseRepository.register(name: name, email: email, password: password);
  }

  Future<bool> login({@required String email, @required String password}) async {
    return await firebaseRepository.login(email: email, password: password);
  }

  Future<bool> logout() async {
    return await firebaseRepository.logout();
  }

  Future<String> uploadPhoto({@required String uid, File imgFile}) async {
    return await firebaseRepository.uploadPhoto(uid: uid, imgFile: imgFile);
  }

  Future<bool> addUser({@required User user}) async {
    return await firebaseRepository.addUser(user: user);
  }

  Future<bool> updateUser({@required User user}) async {
    bool isSuccess = await firebaseRepository.updateUser(user: user);
    return isSuccess;
  }

  Future<bool> addCompany({@required Company company, @required String userId}) async {
    return await firebaseRepository.addCompany(company: company, userId: userId);
  }

  Future<bool> addNonProfit({@required Profit profit, @required String userId}) async {
    return await firebaseRepository.addNonProfit(profit: profit, userId: userId);
  }

  dispose() {
    _userController.close();
  }

}