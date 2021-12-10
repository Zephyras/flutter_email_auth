import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_email_auth/pages/auth_page.dart';

//프로파이더 안에는 현재페이지를 변수생성 안에 현재 어떤페이지가 들어왔는지 확인해준다.
//미리여기에 스트림을 통해서 훅을 걸어놓는다.
class PageNotifier extends ChangeNotifier {
  String _currentPage = AuthPage.pageName;

  PageNotifier() {
    //파이어베이스 계정에 대한 상태변환
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null)
        //아이디가 없을경우 로그인할수 있는 UI페이지 보여준다.
        showPage(AuthPage.pageName);
      else
        print(user.toString());
      //아이디 잇을경우 메인페이지로 이동
      goToMain();
    });
  }

  String get curPage => _currentPage;

  void goToMain() {
    _currentPage = null;
    notifyListeners();
  }

  void showPage(String page) {
    _currentPage = page;
    notifyListeners();
  }
}
