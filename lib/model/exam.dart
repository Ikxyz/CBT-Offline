import 'package:cbt_offline/import.dart';
class ExamModelClass {
  String school;
  String class_;
  String subject;
  String time;
  String author;
  String created;
  List<String> answer;
  List<QuestionModelClass> questions;

  ExamModelClass({this.school, this.class_, this.subject, this.time, this.author, this.created, this.answer, this.questions});

  ExamModelClass.fromJson(Map<String, dynamic> json) {
    this.school = json['school'];
    this.class_ = json['class'];
    this.subject = json['subject'];
    this.time = json['time'];
    this.author = json['author'];
    this.created = json['created'];

    List<dynamic> answerList = json['answer'];
    this.answer = new List();
    this.answer.addAll(answerList.map((o) => o.toString()));

    List<dynamic> questionsList = json['questions'];
    this.questions = new List();
    this.questions.addAll(questionsList.map((o) => o));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['school'] = this.school ?? '';
    data['class'] = this.class_ ?? '';
    data['subject'] = this.subject ?? '';
    data['time'] = this.time ?? DateTime.now().toUtc().toString();
    data['author'] = this.author ?? '';
    data['created'] = this.created ?? '';
    data['answer'] = this.answer ?? [];
    data['questions'] = this.questions==null? []:this.questions.map((e){return e.toJson();}).toList();
    return data;
  }

}
