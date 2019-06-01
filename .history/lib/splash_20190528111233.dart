import 'import.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue,
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Computer Base Testing 1.0.0',
                style: Theme.of(context).textTheme.headline.copyWith(color: Colors.white,)
              ),
              CircularProgressIndicator(
                strokeWidth: 2,valueColor: Alya,
              )
            ],
          ),
        ),
      ),
    );
  }
}
