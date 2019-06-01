import 'package:cbt_offline/import.dart';

class HomeRoute extends StatefulWidget {
  HomeRoute({Key key}) : super(key: key);

  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  DrawerIndexBloc _indexBloc = DrawerIndexBloc();
  BuildContext context;
  @override
  Widget build(BuildContext context) {
    context = context;
    return StreamBuilder<int>(
        stream: _indexBloc.newCurrentIndexStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  title: Text('CBT Administrator Portal'),
                  elevation: 0,
                  actions: <Widget>[],
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
                      children: _drawer,
                    ),
                  ),
                  elevation: 0,
                ));
          }
          return Container(
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          );
        });
  }

  void onDrawerClick(int val) {
    _indexBloc.newCurrentIndexSink.add(val);
  }

  List<Widget> _body = [
    DashboardComponents(),
    QuestionComponents(),
    PerpareResultComponents(),
    WhitePaperComponents(),
    SettingComponents()
  ];

  List<Widget> _drawer = [
    Container(
      color: Colors.blue.shade800,
      height: 150,
      child: Center(
        child: Text(
          'Computer Base Test',
          style: loginFormTextStyle,
        ),
      ),
    ),
    ListTile(
      leading: Icon(Icons.dashboard),
      onTap: () {},
      title: Text('Dashbord'),
    ),
    ListTile(
      leading: Icon(Icons.add_circle),
      onTap: () {},
      title: Text('Add Question'),
    ),
    ListTile(
      leading: Icon(Icons.library_books),
      onTap: () {},
      title: Text('Prepare Result'),
    ),
    ListTile(
      leading: Icon(Icons.library_books),
      onTap: () {},
      title: Text('White Board'),
    ),
    ListTile(
      leading: Icon(Icons.dashboard),
      onTap: () {},
      title: Text('Setting'),
    ),
    ListTile(
      leading: Icon(Icons.close),
      onTap: () {},
      title: Text('Log out'),
    ),
  ];
}
