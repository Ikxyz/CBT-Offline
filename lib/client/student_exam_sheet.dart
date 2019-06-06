import 'package:cbt_offline/import.dart';
class StudentExamSheet extends StatefulWidget {
  StudentExamSheet(this._studentSession,this._studentBio);
  UsersProfileClass _studentBio  ;
  StudentExamSession _studentSession ;



  @override
  _StudentExamSheetState createState() => _StudentExamSheetState(studentSession: _studentSession,studentBio: _studentBio);
}

class _StudentExamSheetState extends State<StudentExamSheet> {
  _StudentExamSheetState({@required this.studentSession,@required this.studentBio}){}
  PageController _questionPageController = PageController();
  int questionIndex = 0;
  int _index = 1;
  UsersProfileClass studentBio  ;
  StudentExamSession studentSession ;

  @override
  Widget build(BuildContext context) {


    return Container(
      height: MediaQuery.of(context).size.height,
      child: Wrap(
        children: <Widget>[helpPanel(), questionPanel(), historyPanel()],
      ),
    );
  }



  void _previousQuestion() {
    _questionPageController.previousPage(
        duration: Duration(milliseconds: 300), curve: ElasticOutCurve());
  }

  void _nextQuestion() {
    _questionPageController.nextPage(
        duration: Duration(milliseconds: 300), curve: ElasticOutCurve());
  }





  Widget _questionTemplate(int index, String que, List<String> opt) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    que,
                    style: Theme.of(context).textTheme.headline.copyWith(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: opt.map((e) {
                        return Row(
                          children: <Widget>[
                            Radio(
                              onChanged: (val) {
                                studentSession.examinationSheet.question[index].answer = val;
                                print('click click radio $val');
                              },
                              groupValue:  studentSession.examinationSheet.question[index].answer,
                              value: e,
                              activeColor: Colors.blue,
                            ),
                            Text(e)
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        RaisedButton.icon(
                          onPressed: () {
                            _previousQuestion();
                          },
                          label: Text('Previous Question'),
                          icon: Icon(Icons.navigate_before),
                          textColor: Colors.white,
                          color: Colors.grey,
                          shape: StadiumBorder(),
                        ),
                        RaisedButton.icon(
                          onPressed: () {
                            _nextQuestion();
                          },
                          label: Text('Next Question'),
                          icon: Icon(Icons.navigate_next),
                          textColor: Colors.white,
                          shape: StadiumBorder(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget helpPanel() => Container(
    width: MediaQuery.of(context).size.width * 0.3,
    height: MediaQuery.of(context).size.height * 0.8,
    child: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        elevation: 0,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Center(
                child: Text(
                  'Exam Info',
                  style: Theme.of(context)
                      .textTheme
                      .headline
                      .copyWith(fontWeight: FontWeight.bold),
                )),
            ListTile(
              title: Text('Username: '),
              subtitle:
              Text('${studentBio.username}'),
              leading: Icon(
                Icons.account_circle,
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Full Name: '),
              subtitle:
              Text('${studentBio.firstName} ${studentBio.lastName}'),
              leading: Icon(
                Icons.account_circle,
                color: Colors.blue,
              ),
            ),
//            ListTile(
//              title: Text('Subject: '),
//              subtitle: Text(studentSession.examinationSheet.subject),
//              leading: Icon(
//                Icons.library_books,
//                color: Colors.blue,
//              ),
//            ),
//            ListTile(
//              title: Text('Total Question: '),
//              subtitle: Text(studentSession.examinationSheet.question.length
//                  .toString()),
//              leading: Icon(
//                Icons.border_color,
//                color: Colors.blue,
//              ),
//            ),
//            ListTile(
//              title: Text('Total Question Answerd: '),
//              subtitle: Text('5'),
//              leading: Icon(
//                Icons.border_color,
//                color: Colors.blue,
//              ),
//            ),
//            ListTile(
//              title: Text('Total Question Remaing: '),
//              subtitle: Text('15'),
//              leading: Icon(
//                Icons.border_color,
//                color: Colors.blue,
//              ),
//            ),
          ],
        ),
      ),
    ),
  );
  Widget questionPanel() => Container(
    width: MediaQuery.of(context).size.width * 0.7,
    height: MediaQuery.of(context).size.height * 0.8,
    child: PageView(
      children: studentSession.examinationSheet.question.map((question) {
        return _questionTemplate(
          questionIndex + 1, question.question, question.options,);
      }).toList(),
      controller: _questionPageController,
      onPageChanged: (val) {},
    ),
  );
  Widget historyPanel() => Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.2,
    child: Wrap(
      children: studentSession.examinationSheet.question.map((e) {
        return Chip(
          label: Text((_index++).toString()),
          deleteIcon: null,
          labelStyle: TextStyle(color: Colors.white),
          backgroundColor: Colors.grey,
        );
      }).toList(),
    ),
  );





}
