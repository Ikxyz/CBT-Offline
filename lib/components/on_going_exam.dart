import 'package:cbt_offline/import.dart';
import 'package:http/http.dart' as server;

class OnGoingExamComponents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _url =
        'https://us-central1-computerbasetesting.cloudfunctions.net/getExamByAuthor?author=${getUser()['username']}';

    return Scaffold(
      appBar: AppBar(
        title: Text('Condust Examination'),
      ),
      body: FutureBuilder(
        future: server.get(_url),
        builder: (context, AsyncSnapshot<server.Response> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Container(
              child: Center(
                child: Text('Error loading records'),
              ),
            );
          }
          if (snapshot.hasData) {
            final Map<String, dynamic> filter = json.decode(snapshot.data.body);

            final List<dynamic> data = filter['data'];

            if (data.isEmpty) {
              return Container(
                child: Center(
                  child: Text('No Examination Sheet Found'),
                ),
              );
            } else {
              return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding:
                    const EdgeInsets.only(left: 100, right: 100, top: 50),
                    child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.blue.shade700,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextFormField(
                          style:
                          TextStyle(fontSize: 20, color: Colors.white),
                          textInputAction: TextInputAction.done,
                          maxLines: 1,
                          obscureText: false,
                          validator: isEmail,
                          onSaved: (val) {},
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Example: Subject: English',
                              labelStyle: TextStyle(color: Colors.white),
                              hintStyle: TextStyle(color: Colors.white),
                              labelText:
                              "Search by school name, year, subject",
                              prefixIcon: Icon(Icons.search)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ...data.map((rExamSheet) {

                final examSheet = ExamSheetModelClass.fromJson(
                    Map<String, dynamic>.from(rExamSheet));
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.blue.shade700,
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          examSheet.schoolName,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Class: ${examSheet.class_}\nSubject: ${examSheet.subject}\nYear: ${examSheet.year}\nNote: ${examSheet.note}",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      trailing: FlatButton.icon(
                        label: Text(
                          'Proceed',
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: Icon(
                          Icons.navigate_next,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              'PrimaryExamSession/${examSheet.id}');
                        },
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                );
              }).toList()
          ],
          ),
          ),
          );
          }
          }

          return Container(
          child: Center(
          child: CircularProgressIndicator(
          strokeWidth: 2,
          ),
          ),
          );
        },
      ),
    );
  }
}
