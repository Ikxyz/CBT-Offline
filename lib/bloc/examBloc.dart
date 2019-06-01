import 'package:cbt_offline/import.dart';

class ExamBlocClass{

  ExamModelClass _blocClass = ExamModelClass(school:'',class_:'',author: '',created: DateTime.now().toUtc().toString(),subject:'',time: '',answer: [],questions: []);

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
  final x = <QuestionModelClass>[if(_blocClass.questions!=null)..._blocClass.questions,e];
  _blocClass.questions = x;
  _addQuestionSink.add(_blocClass);
}
  }
  _removeQuestion(QuestionModelClass e){

  }


  void dispose(){
    _examStreamController.close();
  }
}