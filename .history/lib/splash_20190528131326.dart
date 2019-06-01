import 'import.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Computer Base Testing 1.0.0',
                  style: Theme.of(context)
                      .textTheme
                      .headline
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 40)),
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(
                strokeWidth: 2,
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: Future.delayed(Duration(seconds: 3), () {
                  return true;
                }),
                builder: (context, data) {
                  if (data.hasData) {
                    return RaisedButton(
                      onPressed: () {},
                      child: Text('Continue',
                          style: TextStyle(color: Colors.white)),
                    );
                  }
                  return Offstage();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
