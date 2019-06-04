import 'package:cbt_offline/import.dart';
import 'package:http/http.dart' as server;
class ConductExamComponent extends StatefulWidget {
  @override
  _ConductExamComponentState createState() => _ConductExamComponentState();
}

class _ConductExamComponentState extends State<ConductExamComponent> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  String _username;

  _ConductExamComponentState()  {
    _getUser();
  }
  _getUser()async{
    _username = await getUser()['username'];
  }
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    String _url = 'https://us-central1-computerbasetesting.cloudfunctions.net/getExamByAuthor?author=${_username}';
    return Scaffold(appBar: AppBar(title: Text('Condust Examination'),),body: FutureBuilder(
      future:server.get(_url),
      builder: (context,AsyncSnapshot<dynamic> snapshot){
      if(snapshot.hasData){
        if(snapshot.data.isEmpty){
          return Container(child: Center(child: Text('No Examination Sheet Found'),),);
        }
        else{
          return ListView(physics: BouncingScrollPhysics(),children: snapshot.data.map((rExamSheet){
            final examSheet= ExamSheetModelClass.fromJson(rExamSheet);
            return ListTile(title: Text(examSheet.schoolName),
              subtitle: Text("Class: ${examSheet.class_}\nSubject: ${examSheet.subject}\nNote: ${examSheet.note}"),trailing: Expanded(child: IconButton(icon: Icon(Icons.navigate_next),onPressed: (){},),),);
          }).toList(),);
        }
      }

      return Container(child: Center(child: CircularProgressIndicator(strokeWidth: 2,),),);
    }

    ,),);
  }
}
