import 'import.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: Future.delayed(Duration(seconds: 1), () {
        return true;
      }),
      builder: (context, data) {
        if (data.hasData) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text('Computer Base Testing 1.0.0',
                      style: Theme.of(context)
                          .textTheme
                          .headline
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 40)),
                  Container(
                    child: Wrap(
                      runSpacing: 50,
                      spacing: 50,
                      children: <Widget>[
                        RawMaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('Login');

                          },
                          elevation: 8,
                          textStyle: TextStyle(color: Colors.white),
                          fillColor: Colors.blue,
                          child: Container(
                            width: 400,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Text('Conduct/Setup  Examination',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                  Icon(
                                    Icons.settings_applications,
                                    size: 100,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        RawMaterialButton(
                          onPressed: () {   Navigator.of(context).pushNamed('StartExam');},
                          elevation: 8,
                          textStyle: TextStyle(color: Colors.white),
                          fillColor: Colors.blue,
                          child: Container(
                            width: 400,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Text('Start Examination',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                  Icon(
                                    Icons.border_color,
                                    size: 100,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container(
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
              ],
            ),
          ),
        );
      },
    ));
  }
}
