import 'package:cbt_offline/import.dart';

class QuestionModelClass {
  String id;
  String _question;
  String _answer;
  List<String> _options;

  QuestionModelClass([this.id,this._question,this._options,this._answer,  ]);

  QuestionModelClass.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];

    this._question = json['question'];
    this._answer = json['answer'];

    List<dynamic> optionsList = json['options'];
    this._options = new List();
    this._options.addAll(optionsList.map((o) => o.toString()));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? '${randomAlphaNumeric(16)}${DateTime.now().toUtc().toIso8601String()}';

    data['question'] = this._question ?? [];
    data['answer'] = this._answer ?? [];
    data['options'] = this._options ?? [];
    return data;
  }

  List<dynamic> get options => _options;

  set options(List<dynamic> value) {
    _options = value;
  }

  String get answer => _answer;

  set answer(String value) {
    _answer = value;
  }

  String get question => _question;

  set question(String value) {
    _question = value;
  }


}
