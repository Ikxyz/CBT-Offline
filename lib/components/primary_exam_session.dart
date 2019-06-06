import 'package:cbt_offline/import.dart';
import 'package:http/http.dart' as server;

// ignore: must_be_immutable
class PrimaryExamSessionComponent extends StatefulWidget {
  String examDocId;

  PrimaryExamSessionComponent(this.examDocId);
  @override
  _PrimaryExamSessionComponentState createState() =>
      _PrimaryExamSessionComponentState();
}

class _PrimaryExamSessionComponentState
    extends State<PrimaryExamSessionComponent> {
  var _primaryExamSessionModel = PrimaryExamSessionModel(
      id: '${randomAlphaNumeric(4)}-${randomAlphaNumeric(4)}-${randomNumeric(4)}');

  @override
  Widget build(BuildContext context) {
    String _url =
        'https://us-central1-computerbasetesting.cloudfunctions.net/createExamSession';
    _primaryExamSessionModel.examinationId = widget.examDocId;
    final uploadData = jsonEncode({"session":_primaryExamSessionModel.toJson(),});
    print(_url);
    return Scaffold(
      appBar: AppBar(
        title: Text('Examination Session'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder(
          future: server.post(_url,body: uploadData),
          builder: (context, AsyncSnapshot<server.Response> snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Container(
                child: Center(
                  child: Text('Error loading records'),
                ),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data.statusCode != 200) {
                return Container(
                  child: Center(
                    child: Text('Error loading records'),
                  ),
                );
              }
              // Initilaize
              final Map<String, dynamic> _result =
                  jsonDecode(snapshot.data.body)['data'];

              final _examSheet =
                  ExamSheetModelClass.fromJson(_result['examSheet']);
              _primaryExamSessionModel =
                  PrimaryExamSessionModel.fromJson(_result['session']);

              return Container(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(100),
                  child: ListView(
                    children: <Widget>[
                      Card(
                        child: ListTile(
                          title: Text(
                            'Examination Session Id:',style: Theme.of(context).textTheme.headline.copyWith(fontSize: 30),
                          ),
                          subtitle: Text(_primaryExamSessionModel.id,style: Theme.of(context).textTheme.headline.copyWith(fontSize: 25)),
                        ),
                      ),
SizedBox(height: 50,),
                      Container(
                        child: ListTile(leading: FlatButton.icon(
                          onPressed: () {},color: Colors.blue,textColor: Colors.white,
                          label: Text('Refresh'),
                          icon: Icon(Icons.refresh),
                        ),
                          title: Text(
                            'Log On Student:',style: Theme.of(context).textTheme.headline.copyWith(fontSize: 25)
                          ),
                          subtitle: Text(_primaryExamSessionModel.id),
                        ),
                      ),

                      // Loading current Logon Student
//                    ..._primaryExamSessionModel.student.map((student) {
//                      return Card(
//                        child: ListTile(
//                          title: Text(
//                            'Name: ${student.firstName} ${student.lastName}',
//                          ),
//                          subtitle: Text('Join time: 2:30'),
//                        ),
//                      );
//                    }).toList()
                    ],
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
          },
        ),
      ),
    );
  }

  Future<PrimaryExamSessionModel> _generateExamSession() async {
    String url = "";

    return null;
  }
}
