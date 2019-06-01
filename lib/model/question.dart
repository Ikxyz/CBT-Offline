class QuestionModelClass {
  String _schoolName;
  String _class_;
  String _subject;
  String _question;
  String _answer;
  List<String> _options;

  QuestionModelClass([this._question,this._options,this._answer,this._schoolName, this._class_, this._subject,   ]);

  QuestionModelClass.fromJson(Map<String, dynamic> json) {
    this._schoolName = json['schoolName'];
    this._class_ = json['class_'];
    this._subject = json['subject'];
    this._question = json['question'];
    this._answer = json['answer'];

    List<dynamic> optionsList = json['options'];
    this._options = new List();
    this._options.addAll(optionsList.map((o) => o.toString()));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schoolName'] = this._schoolName??'';
    data['class_'] = this._class_ ??"";
    data['subject'] = this._subject ?? '';
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

  String get subject => _subject;

  set subject(String value) {
    _subject = value;
  }

  String get class_ => _class_;

  set class_(String value) {
    _class_ = value;
  }

  String get schoolName => _schoolName;

  set schoolName(String value) {
    _schoolName = value;
  }

}
