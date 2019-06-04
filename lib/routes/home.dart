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
        builder: (context, snapshotDrawerIndex) {
          if (snapshotDrawerIndex.hasData) {
            return Scaffold(
                appBar: AppBar(
                  title: Text('CBT Administrator Portal'),
                  elevation: 0,
                  actions: <Widget>[],
                ),
                body:   Container(
                  child: Center(
                    child: Wrap(
                      runSpacing: 50,
                      crossAxisAlignment: WrapCrossAlignment.center,runAlignment: WrapAlignment.center,alignment: WrapAlignment.center,

                      spacing: 50,
                      children: <Widget>[
                        RawMaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('NewExamSheet');

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
                                  Text('Setup/Add Examination',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                  Icon(
                                    Icons.add_circle_outline,
                                    size: 100,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        RawMaterialButton(
                          onPressed: () { Navigator.of(context).pushNamed('ConductExam');     },
                          elevation: 8,
                          textStyle: TextStyle(color: Colors.white),
                          fillColor: Colors.blue,
                          child: Container(
                            width: 400,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Text('Conduct Examination',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                  Icon(
                                    Icons.play_circle_outline,
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
                ),
         );
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

  void _onDrawerClick(int val) {
    _indexBloc.newCurrentIndexSink.add(val);
    //Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _indexBloc.dispose();
    super.dispose();
  }

  List<Widget> _body = [
    DashboardComponents(),
    NewExamSheetComponents(),
    PerpareResultComponents(),
    WhitePaperComponents(),
    SettingComponents()
  ];

  List<Widget> get _drawer => [
        Container(
          color: Colors.blue.shade800,
          height: 150,
          child: Center(
            child: Text(
              'Computer Base Test',
              style: loginFormTextStyle.copyWith(color:Colors.white),
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.dashboard),
          onTap: () {
            _onDrawerClick(0);
          },
          title: Text('Dashbord'),
        ),
        ListTile(
          leading: Icon(Icons.add_circle),
          onTap: () {
            _onDrawerClick(1);
          },
          title: Text('Add Question'),
        ),
        ListTile(
          leading: Icon(Icons.library_books),
          onTap: () {
            _onDrawerClick(2);
          },
          title: Text('Prepare Result'),
        ),
        ListTile(
          leading: Icon(Icons.library_books),
          onTap: () {
            _onDrawerClick(3);
          },
          title: Text('White Board'),
        ),
        ListTile(
          leading: Icon(Icons.dashboard),
          onTap: () {
            _onDrawerClick(4);
          },
          title: Text('Setting'),
        ),
        ListTile(
          leading: Icon(Icons.close),
          onTap: () {},
          title: Text('Log out'),
        ),
      ];
}
