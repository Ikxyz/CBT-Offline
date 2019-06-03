import 'package:cbt_offline/import.dart';
import 'package:cbt_offline/model/question.dart';
import 'package:flutter_web/widgets.dart';

class QuestionComponents extends StatefulWidget {
  QuestionComponents({Key key}) : super(key: key);

  _QuestionComponentsState createState() => _QuestionComponentsState();
}

class _QuestionComponentsState extends State<QuestionComponents> {
  int _currentStep = 0;

  final _addQuestionFormKey = GlobalKey<FormState>();
  final _examinationGeneralInfoFormKey = GlobalKey<FormState>();
  final _scaffoldState = GlobalKey<ScaffoldState>();

  ExamBlocClass _examBlocClass = ExamBlocClass();
  ExamModelClass _examModelClass = ExamModelClass();
  QuestionModelClass _questionModelClass = QuestionModelClass(
      '${randomAlphaNumeric(16)}${DateTime.now().toUtc().millisecondsSinceEpoch}');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text('Setup New Examination'),
        backgroundColor: Colors.blue,
        centerTitle: true,actions: <Widget>[
        FlatButton.icon(
          onPressed: () {},
          label: Text('Save Draft'),
          icon: Icon(Icons.save),
          textColor: Colors.white,
        ),
        FlatButton.icon(
          onPressed: () {},
          label: Text('Finish'),
          icon: Icon(Icons.check),
          textColor: Colors.white,
        ),
      ],

      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: _stepper(),
          ),
        ],
      ),
    );
  }

  //#region Logic
  _onAddQuestion() {
    if (!_addQuestionFormKey.currentState.validate()) {
      return;
    }
    _addQuestionFormKey.currentState.save();

    if (_questionModelClass.answer == null) {
      showSnackBar(_scaffoldState, 'valid answer not found');
      return;
    }
    if (_questionModelClass.answer.toString().trim().length == 0) {
      showSnackBar(_scaffoldState, 'valid answer not found');
      return;
    }

    _examBlocClass.addQuestion(_questionModelClass);
    _questionModelClass = new QuestionModelClass(
        '${randomAlphaNumeric(16)}${DateTime.now().toUtc().millisecondsSinceEpoch}');
    showSnackBar(_scaffoldState, 'Question Added');
  }

  _onUpdateExamGeneralInfo() {
    if (!_examinationGeneralInfoFormKey.currentState.validate()) return;
    _examinationGeneralInfoFormKey.currentState.save();
    _examBlocClass.updateExam(_examModelClass);

    showSnackBar(_scaffoldState, 'Saved');
  }

  _onUpdateQuestion(QuestionModelClass que) {
    _examBlocClass.updateQuestion(que);
    Navigator.of(context).pop();
    showSnackBar(_scaffoldState, 'Question Updated');
  }

  _onRemoveQuestion(String id) {
    _examBlocClass.removeQuestion(id);
    showSnackBar(_scaffoldState, 'Question Deleted');
  }

//#endregion

//#region UI
  Widget _questionTile(QuestionModelClass mQue) {
    return ListTile(
        leading: FlatButton.icon(
          label: Text('Edit'),
          icon: Icon(Icons.mode_edit),
          onPressed: () {
            showBottomSheet(
                context: context,
                builder: (context) {
                  final _formKey = GlobalKey<FormState>();
                  final queController =
                      TextEditingController(text: mQue.question);
                  final ansController = TextEditingController(
                      text: mQue.options.map((f) {
                    if (f == mQue.answer) {
                      return '***${f}';
                    } else {
                      return f;
                    }
                  }).join());
                  return Container(
                    child: Card(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                'Edit question',
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                              ),
                              TextFormField(
                                controller: queController,
                                style: TextStyle(fontSize: 16),
                                textInputAction: TextInputAction.done,
                                maxLines: 5,
                                obscureText: false,
                                onSaved: (val) {
                                  mQue.question = val.trim();
                                  print(val);
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Enter Question',
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: ansController,
                                style: TextStyle(fontSize: 16),
                                textInputAction: TextInputAction.done,
                                maxLines: 3,
                                obscureText: false,
                                onSaved: (val) {
                                  mQue.options =
                                      val.trim().split(',').map((que_) {
                                    String cleanStr = que_.trim().toLowerCase();
                                    if (cleanStr.startsWith('***')) {
                                      cleanStr =
                                          cleanStr.replaceAll("***", '').trim();
                                      mQue.answer = cleanStr;
                                      return cleanStr;
                                    } else {
                                      return cleanStr;
                                    }
                                  }).toList();
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Enter options saparate by ,',
                                ),
                              ),
                              RaisedButton.icon(
                                onPressed: () {
                                  if (!_formKey.currentState.validate()) return;
                                  _formKey.currentState.save();
                                  if (mQue.answer == null) {
                                    showSnackBar(_scaffoldState,
                                        'valid answer not found');
                                    return;
                                  }
                                  if (mQue.answer.toString().trim().length ==
                                      0) {
                                    showSnackBar(_scaffoldState,
                                        'valid answer not found');
                                    return;
                                  }
                                  _onUpdateQuestion(mQue);
                                },
                                icon: Icon(Icons.update),
                                label: Text('Update Question'),
                                textColor: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
          textColor: Colors.white,
          color: Colors.green,
        ),
        title: Text(
          mQue.question,
          style: Theme.of(context).textTheme.subtitle,
        ),
        subtitle: Wrap(
          children: mQue.options.map((opt) {
            if (opt != null) {
              if (opt.toString().trim().isNotEmpty) {
                return Chip(
                  label: Text(opt.trim()),
                  backgroundColor: mQue.answer == opt
                      ? Colors.green.shade200
                      : Colors.grey.shade300,
                );
              }
            }
          }).toList(),
        ),
        trailing: FlatButton.icon(
          label: Text('remove'),
          icon: Icon(Icons.delete_forever),
          onPressed: () {
            _onRemoveQuestion(mQue.id);
          },
          color: Colors.red,
          textColor: Colors.white,
        ));
  }

  Widget _examInfoWidget() {
    return Container(
      child: Card(
        child: Form(
          key: _examinationGeneralInfoFormKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'General Examination Infomation',
                  style: Theme.of(context).textTheme.subhead.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                //School Name
                TextFormField(
                  style: TextStyle(fontSize: 16),
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.characters,
                  maxLines: 1,
                  maxLength: 60,
                  obscureText: false,
                  onSaved: (val) {
                    _examModelClass.schoolName = val.toString().trim();
                  },
                  validator: isNotNull,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Enter School Name',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Class
                TextFormField(
                  style: TextStyle(fontSize: 16),
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.characters,
                  maxLines: 1,
                  maxLength: 30,
                  obscureText: false,
                  onSaved: (val) {
                    _examModelClass.subject = val.toString().trim();
                  },
                  validator: isNotNull,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Subject',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Class
                TextFormField(
                  style: TextStyle(fontSize: 16),
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.characters,
                  maxLines: 1,
                  maxLength: 15,
                  obscureText: false,
                  onSaved: (val) {
                    _examModelClass.class_ = val.toString().trim();
                  },
                  validator: isNotNull,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Class',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Time
                TextFormField(
                  style: TextStyle(fontSize: 16),
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.characters,
                  maxLines: 1,
                  maxLength: 3,
                  obscureText: false,
                  onSaved: (val) {
                    _examModelClass.timeAllocated = val.toString().trim();
                  },
                  validator: isNotNull,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Time in minitues',
                  ),
                ),
                //Note
                TextFormField(
                  style: TextStyle(fontSize: 16),
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.characters,
                  maxLines: 5,
                  maxLength: 5000,
                  obscureText: false,
                  onSaved: (val) {
                    _examModelClass.note = val.toString().trim();
                  },
                  validator: isNotNull,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                RaisedButton.icon(
                  onPressed: _onUpdateExamGeneralInfo,
                  icon: Icon(Icons.add_circle),
                  label: Text('Save'),
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _addQuestionWidget() {
    return Container(
      child: Card(
        child: Form(
          key: _addQuestionFormKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Add question',
                  style: Theme.of(context).textTheme.subhead.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                TextFormField(
                  style: TextStyle(fontSize: 16),
                  textInputAction: TextInputAction.done,
                  maxLines: 5,
                  obscureText: false,
                  onSaved: (val) {
                    _questionModelClass.question = val.trim();
                    print(val);
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Enter Question',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: TextStyle(fontSize: 16),
                  textInputAction: TextInputAction.done,
                  maxLines: 3,
                  obscureText: false,
                  onSaved: (val) {
                    _questionModelClass.options =
                        val.trim().split(',').map((que_) {
                      String cleanStr = que_.trim().toLowerCase();
                      if (cleanStr.startsWith('***')) {
                        cleanStr = cleanStr.replaceAll("***", '').trim();
                        _questionModelClass.answer = cleanStr;
                        return cleanStr;
                      } else {
                        return cleanStr;
                      }
                    }).toList();
                    print(val);
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Enter options saparate by ,',
                  ),
                ),
                RaisedButton.icon(
                  onPressed: _onAddQuestion,
                  icon: Icon(Icons.add_circle),
                  label: Text('Add'),
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _examPreviewWidget() {
    return StreamBuilder<ExamModelClass>(
      stream: _examBlocClass.getQuestionStream,
      builder: (BuildContext context, data) {
        if (data.hasData) {
          print(data.data.toJson());
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'School:  ${data.data.schoolName}',
                    style: Theme.of(context).textTheme.headline.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Subject: ${data.data.subject}',
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Class: ${data.data.class_}',
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Time: ${data.data.timeAllocated} min',
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Note: ${data.data.note}',
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: data.data.question == null
                        ? Offstage()
                        : ListView(
                            children: data.data.question.map((que) {
                              print(que.toJson());
                              return _questionTile(que);
                            }).toList(),
                          ),
                  ),
                ),
              ],
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
    );
  }

  Widget _stepper() {
    return Stepper(
      currentStep: _currentStep,

      onStepTapped: (index) {
        if (!_examinationGeneralInfoFormKey.currentState.validate()) return;
        setState(() {
          _currentStep = index;
        });
      },
//controlsBuilder: co(context,(){},(){}),
      steps: _steps,
      type: StepperType.vertical,
    );
  }

  List<Step> get _steps => [
        new Step(
            title: Text('Genera Examination Info'),
            isActive: _currentStep == 0,
            content: _examInfoWidget()),
        new Step(
            title: Text('Add Question'),
            isActive: _currentStep == 1,
            content: _addQuestionWidget()),
        new Step(
            title: Text('Preview Exam Question'),
            isActive: _currentStep == 2,
            state: StepState.editing,
            content: _examPreviewWidget())
      ];
//#endregion
  @override
  void dispose() {
    _examBlocClass.dispose();
    super.dispose();
  }
}

//  _onImport() async {
////    if(!_questionImportFormKey.currentState.validate()){
////      return ;
////    }
//    //   _questionImportFormKey.currentState.save();
//
//setState(() {
//  var a = _cleanList(_questionImport.split('///'));
//
//  a = _cleanList(a);
//
//  a.map((e){
//    if(e!=null){
//      if(e.toString().trim().isNotEmpty){
//        var que = e.split('[[');
//
//        try{
//          _questionList.add(QuestionModelClass(que[1],_cleanList(<dynamic>[...que[2].split('//')])));
//        }catch(err){
//          print(err);
//        }
//      }
//    }
//
//  }).toList();
//
//  print(_questionList);
//  _questionList.forEach((e){
//    print(e.toJson());
//  });
//
//});
//
//    // print('Export \n $_questionImport');
//  }
//
//  _cleanList(List list){
//    if(list==null)return [];
//    final x = list.map((e){
//      if(e!=null){
//        if(e.toString().trim().isNotEmpty){
//          return e;
//        }
//      }
//    }).toList();
// return x;
//  }
