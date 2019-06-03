import 'package:cbt_offline/import.dart';



class ExamModelClass {
  String id,year,timeStamp,lastModified,timeAllocated,note;
  String schoolName;
  String class_;
  String subject;
  String author;
  List<QuestionModelClass> question;
  ExamModelClass({@required this.id,this.schoolName, this.class_, this.subject,this.note, this.timeStamp, this.author, this.lastModified,  this.question,this.year,this.timeAllocated});

  factory ExamModelClass.fromJson(Map<String, dynamic> json) {
  return ExamModelClass(
  id: json['id'] as String,
  schoolName: json['schoolName'] as String,
  class_: json['class_'] as String,
  subject: json['subject'] as String,
  note: json['note'] as String,
  timeStamp: json['timeStamp'] as String,
  author: json['author'] as String,
  lastModified: json['lastModified'] as String,
  question: (json['question'] as List)
      ?.map((e) => e == null
  ? null
      : QuestionModelClass.fromJson(e as Map<String, dynamic>))
      ?.toList(),
  year: json['year'] as String,
  timeAllocated: json['timeAllocated'] as String);
  }

//  {
//    this.id = json['id'];
//    this.year = json['year'];
//    this.schoolName = json['schoolName'];
//    this.note = json['note'];
//    this.class_ = json['class_'];
//    this.subject = json['subject'];
//    this.timeStamp = json['timeStamp'];
//    this.author = json['author'];
//    this.lastModified = json['lastModified'];
//    this.timeAllocated = json['timeAllocated'];
//
//    List<dynamic> questionsList = json['question'];
//    this.question = new List();
//    this.question.addAll(questionsList.map((o) => o));
//  }

  Map<String, dynamic> toJson() =>  <String, dynamic>{
    'id': this.id,
    'year': this.year,
    'timeStamp': this.timeStamp,
    'lastModified': this.lastModified,
    'timeAllocated': this.timeAllocated,
    'note': this.note,
    'schoolName': this.schoolName,
    'class_': this.class_,
    'subject': this.subject,
    'author': this.author,
    'question': this.question
  };

//  {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['id'] = this.id ?? '${randomAlphaNumeric(16)}${DateTime.now().toUtc().toIso8601String()}';
//    data['year'] = this.year ?? '${DateTime.now().year}/${DateTime.now().add(Duration(days: 365)).year}';
//    data['schoolName'] = this.schoolName ?? '';
//    data['note'] = this.note ?? '';
//    data['class_'] = this.class_ ?? '';
//    data['subject'] = this.subject ?? '';
//    data['timeStamp'] = this.timeStamp ?? DateTime.now().toUtc();
//    data['author'] = this.author ?? '';
//    data['lastModified'] = this.lastModified ??  DateTime.now().toUtc();
//
//    data['question'] = this.question==null? []:this.question.map((e){return e.toJson();}).toList();
//    data['timeAllocated']= this.timeAllocated ?? '90';
//    return data;
//  }

}
