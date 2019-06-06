import 'package:cbt_offline/import.dart';

class StudentExamSession {
  String examinationId;
  String sessionId;
  String studentId;
  ExamSheetModelClass examinationSheet;
  dynamic joinTime;
  String endTime;
  String startTime;
  String publicIp;
  String privateIp;
  bool  hasStarted,hasEnded;
  dynamic timeStamp;

  StudentExamSession({this.examinationId, this.sessionId, this.studentId, this.examinationSheet, this.joinTime, this.endTime, this.startTime, this.publicIp, this.privateIp, this.hasEnded,this.hasStarted,this.timeStamp});

  StudentExamSession.fromJson(Map<String, dynamic> json) {    
    this.examinationId = json['examinationId'] ?? '';
    this.sessionId = json['sessionId'] ?? '';
    this.studentId = json['studentId'] ?? '';
    this.examinationSheet = json['examinationSheet'].isEmpty?ExamSheetModelClass(id: ''):ExamSheetModelClass.fromJson(json['examinationSheet']);
    this.joinTime = json['joinTime'] ?? '';
    this.endTime = json['endTime'] ?? '';
    this.startTime = json['startTime'] ?? '';
    this.publicIp = json['publicIp'] ?? '';
    this.privateIp = json['privateIp'] ?? '';
    this.hasEnded = json['hasEnded']?? false;
    this.hasStarted = json['hasStarted'] ?? true;
    this.timeStamp = json['timeStamp']??DateTime.now().toUtc();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['examinationId'] = this.examinationId;
    data['sessionId'] = this.sessionId;
    data['studentId'] = this.studentId;
    data['examinationSheet'] = this.examinationSheet==null?null:this.examinationSheet.toJson();
    data['joinTime'] = this.joinTime;
    data['endTime'] = this.endTime;
    data['startTime'] = this.startTime;
    data['publicIp'] = this.publicIp;
    data['privateIp'] = this.privateIp;
    data['hasStarted'] = this.hasStarted;
    data['hasEnded'] = this.hasEnded;
    data['timeStamp'] = this.timeStamp ?? DateTime.now().toUtc();
    return data;
  }

}
