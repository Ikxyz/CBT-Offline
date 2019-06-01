import 'import.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Column(
        children: <Widget>[
          Text('Computer Base Testing 1.0.0'),
        ],
      ),),
    );
  }
}