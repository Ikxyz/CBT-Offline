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
  ExamBlocClass _examBlocClass = ExamBlocClass();
  ExamModelClass _examModelClass = ExamModelClass();
  QuestionModelClass _questionModelClass = QuestionModelClass();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          child: _stepper(),
        ),
      ],
    );
  }

  _onAddQuestion() {
    if (!_addQuestionFormKey.currentState.validate()) {
      return;
    }
    _addQuestionFormKey.currentState.save();
    _examBlocClass.updateExam(_questionModelClass);
    _questionModelClass = new QuestionModelClass();
  }

  _onUpdateExamGenralInfo(){
    if(!_examinationGeneralInfoFormKey.currentState.validate())return;
    _examinationGeneralInfoFormKey.currentState.save();
    _examBlocClass.updateExam(_examModelClass);
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

  Widget _questionTile(String question, List<dynamic> options) {
    return Card(
      elevation: 1,
      child: Column(
        children: <Widget>[
          Text(
            question,
            style: Theme.of(context).textTheme.subtitle,
          ),
          Wrap(
            children: options.map((opt) {
              if (opt != null) {
                if (opt.toString().trim().isNotEmpty) {
                  return Chip(
                    label: Text(opt.trim()),
                  );
                }
              }
            }).toList(),
          )
        ],
      ),
    );
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
                  obscureText: false,
                  onSaved: (val) {
                   _examModelClass.schoolName= val;
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
                // Subject
                TextFormField(
                  style: TextStyle(fontSize: 16),
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.characters,
                  maxLines: 1,
                  obscureText: false,
                  onSaved: (val) {
                    _examModelClass.subject = val;
                  }, validator: isNotNull,
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
                  obscureText: false,
                  onSaved: (val) {
                  _examModelClass.class_ = val;
                  }, validator: isNotNull,
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
                  obscureText: false,
                  onSaved: (val) {
                    _examModelClass.class_ = val;
                  }, validator: isNotNull,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Time in minitues',
                  ),
                ),
                RaisedButton.icon(
                  onPressed: _onUpdateExamGenralInfo,
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
                  keyboardType: TextInputType.emailAddress,
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
                    _questionModelClass.options = val.trim().split(',');
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
    return StreamBuilder<ExamModelClass>(stream: _examBlocClass.getQuestionStream,builder: (BuildContext context, data){

      if(data.hasData){
        print(data.data.toJson());
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Exam questions preview',
                  style: Theme.of(context)
                      .textTheme
                      .headline
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: data.data.question==null?Offstage():ListView(
                    children:data.data.question.map((que) {
                      print(que.toJson());
                      return _questionTile(que.question, que.options);
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      }
      return Container(child: Center(child: CircularProgressIndicator(strokeWidth: 2,),),);
    },);
  }

  Widget _stepper() {
    return Stepper(
      currentStep: _currentStep,

      onStepTapped: (index){
        setState(() {
          _currentStep= index;
        });
      },
//controlsBuilder: co(context,(){},(){}),
      steps: _steps,
      type: StepperType.vertical,
    );
  }
 co(context,vo,ve){
    return Text('Hello');
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

  @override
  void dispose() {
    _examBlocClass.dispose();
    super.dispose();
  }


}
