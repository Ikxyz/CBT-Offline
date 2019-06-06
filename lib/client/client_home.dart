import 'package:cbt_offline/classes/classes.dart';
import 'package:cbt_offline/import.dart';
import 'package:flutter_web/widgets.dart';
import 'package:http/http.dart' as server;

class ClientHome extends StatefulWidget {
  @override
  _ClientHomeState createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  String _selectedValue = "";
  PageController _pageController = PageController(initialPage: 0);

  UsersProfileClass _studentBio = UsersProfileClass(username: '');
  StudentExamSession _studentSession = StudentExamSession();
//  ExamSheetModelClass _examSheetModelClass;

  final _examInfoFormKey = GlobalKey<FormState>();
  final _studentBioSetupFormKey = GlobalKey<FormState>();
  final _scafoldState = GlobalKey<ScaffoldState>();
  bool _isWorking = false;

  List<Widget> get _pages => [
        _enterExamIdWidget(),
        _enterStudentInfoWidget(),
      ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = new PageController(initialPage: 0);
    _pageController = new PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldState,
      appBar: AppBar(
        title: Text(
          'Computer Base Testing 1.0.0',
        ),
        primary: true,
      ),
      body: PageView(
        children: _pages,
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
        duration: Duration(milliseconds: 300), curve: ElasticOutCurve());
  }

  void _previousPage() {
    _pageController.previousPage(
        duration: Duration(milliseconds: 300), curve: ElasticOutCurve());
  }

  _working(val) {
    setState(() {
      _isWorking = val;
    });
  }

  _onSubmitExaminationId() {
    if (!_examInfoFormKey.currentState.validate()) return;

    _examInfoFormKey.currentState.save();

    _nextPage();
  }

  _onSubmitStudentInfo() async {
    _working(true);
    if (!_studentBioSetupFormKey.currentState.validate()) {
      _working(false);
      return;
    }
    ;
    print('Numbers of pages ${_studentSession.sessionId}');
    _studentBioSetupFormKey.currentState.save();

    final _url =
        "https://us-central1-computerbasetesting.cloudfunctions.net/joinExamSession";

    final _uploadData = jsonEncode({
      "sessionId": _studentSession.sessionId,
      "student": _studentBio.toJson(),
      "studentSession": _studentSession.toJson()
    }).toString();

    final request = await server.post(_url, body: _uploadData).catchError((e) {
      print(e);
      showSnackBar(
        _scafoldState,
        "Error Connecting make sure you have a working internet",
      );

      _working(false);
      return;
    });

    final response = jsonDecode(request.body);
    print(response);

    if (request.statusCode != 200) {
      _working(false);
      showSnackBar(_scafoldState, "Error Connecting");
      _working(false);
      return;
    }

    setState(() {
      _studentBio = UsersProfileClass.fromJson(response['data']['student']);

      //  _examSheetModelClass = ExamSheetModelClass.fromJson(response['data']['examinationSheet']);
      _studentSession =
          StudentExamSession.fromJson(response['data']['session']);
    });

    _working(false);
    _gotoExamSheet(_studentSession,_studentBio);
  }

  Widget _enterExamIdWidget() {
    return ListView(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.grey.shade200,
          child: Center(
            child: Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _examInfoFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Student Exam Info',
                        style: Theme.of(context).textTheme.headline.copyWith(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      //School Name
                      Container(
                        width: 400,
                        child: TextFormField(
                          style: TextStyle(fontSize: 16),
                          textInputAction: TextInputAction.done,
                          textCapitalization: TextCapitalization.characters,
                          maxLines: 1,
                          obscureText: false,
                          onSaved: (val) {
                            _studentSession.sessionId = val;
                          },
                          validator: isNotNull,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Examination ID:',
                          ),
                        ),
                      ),

                      RaisedButton.icon(
                        onPressed: _onSubmitExaminationId,
                        label: Text('Proceed'),
                        icon: Icon(Icons.navigate_next),
                        textColor: Colors.white,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RaisedButton.icon(
                        onPressed: () {
                          _scafoldState.currentState.showBottomSheet((context) {
                            return ContinueStudentExaminationComponent(_scafoldState, (recoveredSession, recoveredStudentData) {

                              _gotoExamSheet(recoveredSession,recoveredStudentData);


                            });
                          });
                        },
                        label: Text(' Click to Resume Exam'),
                        icon: Icon(Icons.play_circle_outline),
                        textColor: Colors.white,
                        color: Colors.teal,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _enterStudentInfoWidget() => ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.grey.shade200,
            child: Center(
              child: Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _studentBioSetupFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Student Account Setup',
                          style: Theme.of(context).textTheme.headline.copyWith(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        //First Name
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
                              _studentBio.firstName = val;
                            },
                            validator: isNotNull,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'First Name:',
                            ),
                          ),
                        ),
                        //Last Name
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
                              _studentBio.lastName = val;
                            },
                            validator: isNotNull,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Last Name:',
                            ),
                          ),
                        ),
//                      //Student Seat Number
//                      Container(
//                        width: 400,
//                        child: TextFormField(
//                          style: TextStyle(fontSize: 16),
//                          textInputAction: TextInputAction.done,
//                          textCapitalization: TextCapitalization.characters,
//                          maxLines: 1,
//                          maxLength: 3,
//                          obscureText: false,
//                          onSaved: (val) {
//                            //  _examModelClass.school= val;
//                          },
//                          validator: isNotNull,
//                          keyboardType: TextInputType.text,
//                          decoration: InputDecoration(
//                            labelText: 'Seat Number:',
//                          ),
//                        ),
//                      ),
                        //Student Email
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
                              _studentBio.email = val;
                            },
                            validator: null,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Email (Optional):',
                            ),
                          ),
                        ),
                        //Student Email
                        Container(
                          width: 400,
                          child: TextFormField(
                            style: TextStyle(fontSize: 16),
                            textInputAction: TextInputAction.done,
                            textCapitalization: TextCapitalization.characters,
                            maxLines: 1,
                            maxLength: 10,
                            obscureText: false,
                            onSaved: (val) {
                              _studentBio.tel = val;
                            },
                            validator: null,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                labelText: 'Phone Number (Optional):',
                                prefixText: "+234"),
                          ),
                        ),

                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              RaisedButton.icon(
                                onPressed: _previousPage,
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
                                  onPressed: _onSubmitStudentInfo,
                                  label: Text('Proceed'),
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
      );


  _gotoExamSheet(session,student){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
      return StudentExamSheet(_studentSession,_studentBio);
    },), (Route<dynamic> route)=>false);
  }
}
