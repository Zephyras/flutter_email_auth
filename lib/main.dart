import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_email_auth/pages/auth_page.dart';
import 'package:flutter_email_auth/pages/my_home.dart';
import 'package:flutter_email_auth/provider/page_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        //future: Firebase.initializeApp(),
        builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Container(
          child: Center(
            child: Text("Something went wrong, plase try again later!"),
          ),
        );
      }
      if (snapshot.connectionState == ConnectionState.done) {
        return App();
      }

      return CircularProgressIndicator();
      return Container();
    });
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PageNotifier())],
      child: MaterialApp(
        home: Consumer<PageNotifier>(
          builder: (context, pageNotifier, child) {
            //네비게이터 2.0 위젯
            return Navigator(
              //페이지들
              pages: [
                MaterialPage(
                    //마이홈페이지
                    key: ValueKey(MyHome.pageName),
                    child: MyHome(
                        title: 'Flutter Demo Home Page')), // main home page
                //로그인페이지
                //페이지노티파이어안에 로그인페이지값이 들어가면 화면전환 해준다.
                if (pageNotifier.curPage == AuthPage.pageName) AuthPage()
              ],
              onPopPage: (route, result) {
                if (!route.didPop(result)) {
                  return false;
                }

                pageNotifier.goToMain();
                return true;
              },
            );
          },
        ),
      ),
    );
  }
}
