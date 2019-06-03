import 'package:cbt_offline/import.dart';

class ExamBlocClass{

  ExamModelClass _blocClass = ExamModelClass(id:'${randomAlphaNumeric(16)}${DateTime.now().toUtc().millisecondsSinceEpoch}', schoolName:'',class_:'',author: '',subject:'',question: [], );

  final StreamController _examStreamController= new StreamController<ExamModelClass>();

  List<QuestionModelClass> get questionList => _blocClass.question;
  Stream<ExamModelClass> get getQuestionStream => _examStreamController.stream;
  StreamSink<ExamModelClass> get _addQuestionSink => _examStreamController.sink;

  ExamBlocClass(){
    updateExam(_blocClass);
   // getQuestionStream.listen(updateExam);
  }

  updateExam(ExamModelClass e){
  _blocClass = e;
  _addQuestionSink.add(_blocClass);
  }

  addQuestion(QuestionModelClass question){
    final x = <QuestionModelClass>[if(questionList!=null)...questionList,question];
    _blocClass.question = x;
    _addQuestionSink.add(_blocClass);
  }
  updateQuestion(QuestionModelClass que){
   final List<QuestionModelClass> newList = questionList.map((e){
     if(e.id==que.id){
       return que;
     }else{
       return e;
     }
   }).toList();
   _blocClass.question = newList;
    _addQuestionSink.add(_blocClass);
  }
  removeQuestion(String id){
     questionList.removeWhere((que){return que.id==id;});
     _addQuestionSink.add(_blocClass);
  }


  void dispose(){
    _examStreamController.close();
  }
}