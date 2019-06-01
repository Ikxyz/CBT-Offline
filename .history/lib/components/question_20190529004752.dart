import 'package:cbt_offline/import.dart';

class QuestionComponents extends StatefulWidget {
  QuestionComponents({Key key}) : super(key: key);

  _QuestionComponentsState createState() => _QuestionComponentsState();
}

class _QuestionComponentsState extends State<QuestionComponents> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(child: Text('Add Question route'),),
    );
  }
}