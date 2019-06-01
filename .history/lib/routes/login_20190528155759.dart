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
                color: Colors.blue.shade800,
                child: Center(
                  child: Text('Secure Admin Login',style: Theme.of(context).textTheme.he,),
                ),
              ),
              height: 50,
            )
          ],
        ),
      ),
      height: MediaQuery.of(context).size.height,
    );
  }
}
