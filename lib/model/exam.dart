import 'package:cbt_offline/import.dart';
class ExamModelClass {
  String id,year,timeStamp,lastModified;
  String schoolName;
  String class_;
  String subject;
  String author;
  List<String> answer;
  List<QuestionModelClass> question;

  ExamModelClass({this.id,this.schoolName, this.class_, this.subject, this.timeStamp, this.author, this.lastModified, this.answer, this.question,this.year});

  ExamModelClass.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.year = json['year'];
    this.schoolName = json['schoolName'];
    this.class_ = json['class_'];
    this.subject = json['subject'];
    this.timeStamp = json['timeStamp'];
    this.author = json['author'];
    this.lastModified = json['lastModified'];

    List<dynamic> answerList = json['answer'];
    this.answer = new List();
    this.answer.addAll(answerList.map((o) => o.toString()));

    List<dynamic> questionsList = json['question'];
    this.question = new List();
    this.question.addAll(questionsList.map((o) => o));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? '$randomString(16)${DateTime.now().toUtc().toIso8601String()}';
    data['year'] = this.year ?? '${DateTime.now().year}/${DateTime.now().add(Duration(days: 365)).year}';
    data['schoolName'] = this.schoolName ?? '';
    data['class_'] = this.class_ ?? '';
    data['subject'] = this.subject ?? '';
    data['timeStamp'] = this.timeStamp ?? DateTime.now().toUtc();
    data['author'] = this.author ?? '';
    data['lastModified'] = this.lastModified ??  DateTime.now().toUtc();
    data['answer'] = this.answer ?? [];
    data['question'] = this.question==null? []:this.question.map((e){return e.toJson();}).toList();
    return data;
  }

}
