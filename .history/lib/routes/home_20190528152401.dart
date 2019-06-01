import 'package:cbt_offline/import.dart';

class HomeRoute extends StatefulWidget {
  HomeRoute({Key key}) : super(key: key);

  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CBT Administrator Portal'),
        ),
        body: Container(
          child: Text('Home'),
        ),
        drawer: Drawer(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  color: Colors.blue.shade800,
                  height: 150,
                  child: Center(child: Text('Computer Base Test',style: Theme.of(context).textTheme.headline,),
                ),
                ListTile(
                  leading: Icon(Icons.dashboard),
                  title: Text('Dashbord'),
                )
              ],
            ),
          ),
        ));
  }
}
