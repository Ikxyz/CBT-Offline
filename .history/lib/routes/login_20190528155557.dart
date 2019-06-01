import 'package:cbt_offline/import.dart';

class LoginRoute extends StatelessWidget {
  const LoginRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Stack(
          children: <Widget>[
            Container(
              child: Card(
                child: Center(
                  child: Text('Secure Admin Login'),
                ),
              ),
              height: 50,
            )
          ],
        ),
      ),height: MediaQ,
    );
  }
}
