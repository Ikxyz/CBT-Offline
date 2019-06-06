import 'package:cbt_offline/import.dart';

class PrimaryExamSessionModel {
  String id;
  String finished;
  String startTime;
  String endTime;
  String examinationId;
  String overSite;
  bool hasEnded,hasStarted;

  //List<String> pausedTime ;
 // List<UsersProfileClass> student;

  PrimaryExamSessionModel({this.id, this.finished, this.startTime, this.endTime, this.examinationId,this.overSite,this.hasStarted,this.hasEnded});

  PrimaryExamSessionModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.finished = json['finished'];
    this.startTime = json['startTime'];
    this.endTime = json['endTime'];
    this.examinationId = json['examinationId'];
    this.overSite = json['overSite'];
   // this.pausedTime = (json['pausedTime'] as List<String>).map((f)=>f.toString()).toList();

    this.hasStarted = json['hasStarted'];this.hasEnded = json['hasStarted'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['finished'] = this.finished;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['examinationId'] = this.examinationId;
    data['overSite'] =this.overSite;
  //  data['pausedTime'] = this.pausedTime;
    data['hasStarted'] = this.hasStarted;
    data['hasEnded'] = this.hasEnded??false;
    return data;
  }









}
