

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
              children: <Widget>[
                Dr
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
