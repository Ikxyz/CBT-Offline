import 'package:cbt_offline/import.dart';

class PrimaryExamSessionModel {
  String id;
  String author;
  String finished;
  String startTime;
  String endTime;
  String examinationId;
  List<UsersProfileClass> student;

  PrimaryExamSessionModel({this.id, this.author, this.finished, this.startTime, this.endTime, this.examinationId, this.student});

  PrimaryExamSessionModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.author = json['author'];
    this.finished = json['finished'];
    this.startTime = json['startTime'];
    this.endTime = json['endTime'];
    this.examinationId = json['examinationId'];
    this.student  = json['student'].map((e)=>UsersProfileClass.fromJson(e)).toList();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['author'] = this.author;
    data['finished'] = this.finished;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['examinationId'] = this.examinationId;
    data['student'] = this.student.map((e)=> e.toJson(e)).toList();
    return data;
  }

}
