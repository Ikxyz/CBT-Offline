import 'package:cbt_offline/import.dart';
import 'package:flutter_web/widgets.dart';

class ClientHome extends StatefulWidget {
  @override
  _ClientHomeState createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  String _selectedValue = "";
  PageController _pageController = PageController();
  PageController _questionPageController = PageController();
  List<QuestionModelClass> _question = [
    QuestionModelClass('gfgf',
        'Anything that occupies space and has mass is ______ ', [' atom', 'molecule ', ' living', ' matter'],'molecule'),


  ];
  ExamSheetModelClass _examSheetModelClass;
  _ClientHomeState() {
    _examSheetModelClass = ExamSheetModelClass(

        author: '',
        question: _question,

        subject: 'English',
        schoolName: 'Faith Group of Schools',
        class_: '');
  }
  int _currentPage = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = new PageController(initialPage: 0);
    _pageController = new PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Computer Base Testing 1.0.0',
        ),
        primary: true,
      ),
      body: PageView(
        children: _pages,
        controller: _pageController,
        onPageChanged: (val) {},
      ),
    );
  }

  List<Widget> get _pages =>
      [_enterExamIdWidget(), _enterStudentInfoWidget(), _mainPage()];
  void _nextPage() {
    _pageController.nextPage(
        duration: Duration(milliseconds: 300), curve: ElasticOutCurve());
  }
  void _previousQuestion(){
    _questionPageController.previousPage(
        duration: Duration(milliseconds: 300), curve: ElasticOutCurve());
  }
  void _nextQuestion(){
    _questionPageController.nextPage(
        duration: Duration(milliseconds: 300), curve: ElasticOutCurve());
  }


  Widget _enterExamIdWidget() {
    return ListView(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.grey.shade200,
          child: Center(
            child: Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Student Exam Info',
                      style: Theme.of(context).textTheme.headline.copyWith(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //School Name
                    Container(
                      width: 400,
                      child: TextFormField(
                        style: TextStyle(fontSize: 16),
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.characters,
                        maxLines: 1,
                        obscureText: false,
                        onSaved: (val) {
                          //  _examModelClass.school= val;
                        },
                        validator: isNotNull,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Examination ID:',
                        ),
                      ),
                    ),

                    RaisedButton.icon(
                      onPressed: () {
                        _nextPage();
                      },
                      label: Text('Proceed'),
                      icon: Icon(Icons.navigate_next),
                      textColor: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _enterStudentInfoWidget() {
    return ListView(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.grey.shade200,
          child: Center(
            child: Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Examination Setup',
                      style: Theme.of(context).textTheme.headline.copyWith(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //Student Name
                    Container(
                      width: 400,
                      child: TextFormField(
                        style: TextStyle(fontSize: 16),
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.characters,
                        maxLines: 1,
                        obscureText: false,
                        onSaved: (val) {
                          //  _examModelClass.school= val;
                        },
                        validator: isNotNull,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Full Name:',
                        ),
                      ),
                    ),
                    //Student Seat Number
                    Container(
                      width: 400,
                      child: TextFormField(
                        style: TextStyle(fontSize: 16),
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.characters,
                        maxLines: 1,
                        maxLength: 3,
                        obscureText: false,
                        onSaved: (val) {
                          //  _examModelClass.school= val;
                        },
                        validator: isNotNull,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Seat Number:',
                        ),
                      ),
                    ),

                    RaisedButton.icon(
                      onPressed: () {
                        _nextPage();
                      },
                      label: Text('Proceed'),
                      icon: Icon(Icons.navigate_next),
                      textColor: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _questionTemplate(int index, String que, List<String> opt) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,

      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left:20.0 ,right: 20),
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
                      mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                      children: opt.map((e) {
                        return Row(children: <Widget>[Radio(onChanged: (val){print('click click radio $val');},groupValue: index,value: e,activeColor: Colors.blue,),Text(e)],);

                      }).toList(),
                    ),
                  ),
                  Container(

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.center,mainAxisSize: MainAxisSize.max,
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
                        ),     RaisedButton.icon(
                          onPressed: () {
                            _nextQuestion();
                          },
                          label: Text('Next Question'),
                          icon: Icon(Icons.navigate_next),
                          textColor: Colors.white,   shape: StadiumBorder(),
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

  Widget _mainPage() {
    Size _size = MediaQuery.of(context).size;
    int questionIndex = 0;      int _index = 1;
    Widget helpPanel = Container(
      width: _size.width * 0.3,
      height: _size.height * 0.8,

      child: Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: Card(elevation: 0,
          child: ListView(physics: BouncingScrollPhysics(),children: <Widget>[
            Center(child: Text('Exam Info',style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.bold),)),
            ListTile(title:  Text('Full Name: '),subtitle:Text('Peter Ade') ,leading: Icon(Icons.account_circle,color: Colors.blue,),),
            ListTile(title: Text('Subject: '),subtitle: Text('24') ,leading: Icon(Icons.library_books,color: Colors.blue,),),
            ListTile(title: Text('Seat Number: '),subtitle: Text('24') ,leading: Icon(Icons.accessible,color: Colors.blue,),),

            ListTile(title: Text('Total Question: '),subtitle: Text('20') ,leading: Icon(Icons.border_color,color: Colors.blue,),),
            ListTile(title: Text('Total Question Answerd: '),subtitle: Text('5') ,leading: Icon(Icons.border_color,color: Colors.blue,),),
            ListTile(title: Text('Total Question Remaing: '),subtitle: Text('15') ,leading: Icon(Icons.border_color,color: Colors.blue,),),


          ],),
        ),
      ),
    );
    Widget questionPanel = Container(
      width: _size.width * 0.7,
      height: _size.height * 0.8,

      child: PageView(
        children: _examSheetModelClass.question.map((question) {
          return _questionTemplate(
              questionIndex + 1, question.question, question.options);
        }).toList(),
        controller: _questionPageController,
        onPageChanged: (val) {},
      ),
    );
    Widget historyPanel = Container(
      width: _size.width,
      height: _size.height * 0.2,

      child:Wrap(children: _examSheetModelClass.question.map((e){
        return Chip(label: Text((_index++).toString()),deleteIcon: null,labelStyle: TextStyle(color: Colors.white),backgroundColor: Colors.grey,);
      }).toList(),) ,
    );

    return Container(
      height: _size.height,
      child: Wrap(
        children: <Widget>[helpPanel, questionPanel, historyPanel],
      ),
    );
  }
}
