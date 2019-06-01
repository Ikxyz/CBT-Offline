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
                  child: Column(
                    crossAxisAlignment: Cro,
                    children: <Widget>[
                      Text('Secure Admin Login',style: Theme.of(context).textTheme.headline.copyWith(color: Colors.white),),
                         Text('Enter your login credencials here',style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.white),),
                    ],
                  ),
                ),
              ),
              height: 100,
            )
          ],
        ),
      ),
      height: MediaQuery.of(context).size.height,
    );
  }
}
