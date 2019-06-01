import 'package:flutter_web/material.dart';

import 'import.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CBT 1.0.0',
      color: Colors.blue.shade700,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue.shade700,
        buttonColor: Colors.blue.shade700,
        iconTheme: Theme.of(context).iconTheme.copyWith(
              color: Colors.blue,
            ),
        textTheme: Theme.of(context).textTheme.copyWith(
            headline: Theme.of(context)
                .textTheme
                .headline
                .copyWith(color: Colors.blue)),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (setting) {
        if (setting.name == 'Home') {
          return MaterialPageRoute(builder: (context) {
            return HomeRoute();
          });
        } else if (setting.name == "Login") {
         // return CustomNavigate.slideUp(LoginRoute());
        }
      },
    );
  }
}
