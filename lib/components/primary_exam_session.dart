import 'package:cbt_offline/import.dart';
import 'package:cbt_offline/model/primary_exam_session.dart';
import 'package:http/http.dart' as server;
// ignore: must_be_immutable
class PrimaryExamSessionComponent extends StatefulWidget {
   String examDocId;

  PrimaryExamSessionComponent(examDocId);
  @override
  _PrimaryExamSessionComponentState createState() => _PrimaryExamSessionComponentState();
}

class _PrimaryExamSessionComponentState extends State<PrimaryExamSessionComponent> {



  PrimaryExamSessionModel _examSessionModel = PrimaryExamSessionModel(id:'${randomString(4)}-${randomAlphaNumeric(4)}-${randomAlphaNumeric(4)}');





  @override
  Widget build(BuildContext context) {
    String _url =
        'https://us-central1-computerbasetesting.cloudfunctions.net/getCreateExamSession?id=${widget.examDocId}&sessionId=${_examSessionModel.id}';

      return Scaffold(
        appBar: AppBar(
          title: Text('Examination Session'),
        ),
      body: FutureBuilder
        (
        future:server.get(_url) ,
        builder: (context, AsyncSnapshot<server.Response> snapshot) {
          if(snapshot.hasError){
            print(snapshot.error);
                 return Container(
              child: Center(
                child: Text('Error loading records'),
              ),
            );
          }
          if (snapshot.hasData) {
            // Initilaize
            final _result =  jsonDecode(snapshot.data.body);
            final _examSheet = ExamSheetModelClass.fromJson(_result['data']);
            final _sessionId = _result['sessionId'];
            _examSessionModel.examinationId =_sessionId;


          return Container(height: MediaQuery.of(context).size.height,
            child: ListView(children: <Widget>[

              Card(child: ListTile(title: Text('Examination Session Id:',),subtitle: Text(_examSessionModel.id),),),
            Container(child: FlatButton.icon(onPressed: (){},label: Text('Refresh'),icon: Icon(Icons.refresh),),),
              Card(child: ListTile(title: Text('Log On Student:',),subtitle: Text(_examSessionModel.id),),),

              // Loading current Logon Student
              ..._examSessionModel.student.map((student){
                return     Card(child: ListTile(title: Text('Name: ${student.firstName} ${student.lastName}',),subtitle: Text('Join time: 2:30'),),);
          }).toList()



            ],),
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
    );
  }

 Future<PrimaryExamSessionModel> _generateExamSession()async{
    String url = "";

            return null;
  }


}


