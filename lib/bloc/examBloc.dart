import 'package:cbt_offline/import.dart';

class ExamBlocClass{

  ExamModelClass _blocClass = ExamModelClass(schoolName:'',class_:'',author: '',subject:'',answer: [],question: []);

  final StreamController _examStreamController= new StreamController<ExamModelClass>();

  Stream<ExamModelClass> get getQuestionStream => _examStreamController.stream;
  StreamSink<ExamModelClass> get _addQuestionSink => _examStreamController.sink;

  ExamBlocClass(){
    updateExam(_blocClass);
   // getQuestionStream.listen(updateExam);
  }

  updateExam(e){
if(e.runtimeType==ExamModelClass){
  _blocClass = e;
  _addQuestionSink.add(_blocClass);
}
if(e.runtimeType== QuestionModelClass){
  final x = <QuestionModelClass>[if(_blocClass.question!=null)..._blocClass.question,e];
  _blocClass.question = x;
  _addQuestionSink.add(_blocClass);
}
  }
  _removeQuestion(QuestionModelClass e){

  }


  void dispose(){
    _examStreamController.close();
  }
}