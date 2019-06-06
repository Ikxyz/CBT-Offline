import 'package:cbt_offline/import.dart';

import 'package:http/http.dart' as server;

typedef onComplete = Function(
    StudentExamSession _studentSession, UsersProfileClass _studentBio);

class ContinueStudentExaminationComponent extends StatefulWidget {

  GlobalKey<ScaffoldState> _scaffoldState;
  onComplete _onComplete;
  ContinueStudentExaminationComponent(
      this._scaffoldState, this._onComplete) {}
  @override
  _ContinueStudentExaminationComponentState createState() =>
      _ContinueStudentExaminationComponentState();
}







class _ContinueStudentExaminationComponentState
    extends State<ContinueStudentExaminationComponent> {

  bool _isWorking = false;


  final _studentUsernameFormKey = GlobalKey<FormState>();


  StudentExamSession _studentSession = StudentExamSession();
  UsersProfileClass _studentBio = UsersProfileClass(username: '');



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(        height: MediaQuery.of(context).size.height * 0.7,

        child: ListView(
          children: <Widget>[
            Container(


              child: Center(
                child: Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _studentUsernameFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Enter Username and Exam Session to Continue',
                            style: Theme.of(context).textTheme.headline.copyWith(
                                color: Colors.blue, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //UserName

                          Container(
                            width: 400,
                            child: TextFormField(
                              style: TextStyle(fontSize: 16),
                              textInputAction: TextInputAction.done,
                              textCapitalization: TextCapitalization.characters,
                              maxLines: 1,
                              maxLength: 30,
                              obscureText: false,
                              onSaved: (val) {
                                _studentBio.username = val;
                              },
                              validator: isNotNull,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: 'Username:',
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          //Exam session
                          Container(
                            width: 400,
                            child: TextFormField(
                              style: TextStyle(fontSize: 16),
                              textInputAction: TextInputAction.done,
                              textCapitalization: TextCapitalization.characters,
                              maxLines: 1,
                              maxLength: 30,
                              obscureText: false,
                              onSaved: (val) {
                                _studentSession.sessionId = val;
                              },
                              validator: isNotNull,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: 'Session:',
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                RaisedButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  label: Text('Back'),
                                  icon: Icon(Icons.navigate_before),
                                  textColor: Colors.white,
                                  color: Colors.red.shade400,
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Visibility(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                  replacement: RaisedButton.icon(
                                    onPressed: _onRejoinExam,
                                    label: Text('Continue'),
                                    icon: Icon(Icons.navigate_next),
                                    textColor: Colors.white,
                                  ),
                                  visible: _isWorking,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onRejoinExam() async {
    working(true);

    if (!_studentUsernameFormKey.currentState.validate()) {
      working(false);
      return;
    }


    _studentUsernameFormKey.currentState.save();

    final _url =
        "https://us-central1-computerbasetesting.cloudfunctions.net/reJoinExamSession";
    final _uploadData = jsonEncode({
      "username":  _studentBio.username.toString(),
      "sessionId":  _studentSession.sessionId.toString()
    });

    final request = await server.post(_url, body: _uploadData).catchError((e) {
      print(e);
      showSnackBar(
        this.widget._scaffoldState,
        "Error Connecting make sure you have a working internet",
      );

      working(false);
      return;
    });

    final response = jsonDecode(request.body);


    if (request.statusCode != 200) {
      showSnackBar(this.widget._scaffoldState, response['message']);
      working(false);
      return;
    }

    setState(() {
     _studentBio =
          UsersProfileClass.fromJson(response['data']['student']);

      //  _examSheetModelClass = ExamSheetModelClass.fromJson(response['data']['examinationSheet']);
     _studentSession =
          StudentExamSession.fromJson(response['data']['session']['session']);

    });

    working(false);
    widget._onComplete( _studentSession,  _studentBio);

  }

  working(val) {
    setState(() {
      _isWorking = val;
    });
  }
}
