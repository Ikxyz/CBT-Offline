import 'package:cbt_offline/import.dart';

class HomeRoute extends StatefulWidget {
  HomeRoute({Key key}) : super(key: key);

  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  DrawerIndexBloc _indexBloc = DrawerIndexBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: _indexBloc.newCurrentIndexStream,
        builder: (context, snapshot) {
         if(snapshot.hasData){ return Scaffold(
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
                    children: <Widget>,
                  ),
                ),elevation: 0,
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

  List<Widget> _body = [];


  List<Widget> _drawer = 
}
