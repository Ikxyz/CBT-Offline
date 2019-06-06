import 'package:cbt_offline/import.dart';
import 'package:http/http.dart' as http;

class LoginRoute extends StatefulWidget {
  const LoginRoute({Key key}) : super(key: key);
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute>
    with SingleTickerProviderStateMixin {
  String email, pwd;
  final _loginKey = GlobalKey<FormState>();
  final _scaffoldState = GlobalKey<ScaffoldState>();
  bool _isWorking = false;

  @override
  void initState() {
    super.initState();
  }

  _isWorkingFun(bool e) {
    setState(() {
      _isWorking = e;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onLogin() async {
    storage['user'] = json.encode({"username":"ikben"});
    await Navigator.of(context).pushNamedAndRemoveUntil('Home', (Route<dynamic> route)=>false);

    _isWorkingFun(true);
    if (!_loginKey.currentState.validate()) {
      _isWorkingFun(false);
      return;
    }
    ;
    _loginKey.currentState.save();

    final output = await http.post(
        'https://us-central1-computerbasetesting.cloudfunctions.net/login',
        body: {'username': email, 'pwd': pwd});
    final Map<String, dynamic> res = json.decode(output.body);
    if (output.statusCode == 200 && res['message'] == "success") {
      print(output.body);
      storage['user'] = json.encode(res['data']);
      print('${storage['user']}');
      await Navigator.of(context).pushNamedAndRemoveUntil('Home', (Route<dynamic> route)=>false);
    } else {
      showSnackBar(_scaffoldState, res['message']);
    }
    _isWorkingFun(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: Container(
        child: Center(
            child: ListView(
          padding: EdgeInsets.only(
            left: 30,
          ),
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Text(
                      'Computer Base Test',
                      style: TextStyle(color: Colors.blue, fontSize: 40),
                    ),
                    Text(
                      ' v1.0.0',
                      style: TextStyle(
                          color: Colors.teal,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Welcome',
              style: TextStyle(
                color: Colors.black,
                fontSize: 50,
              ),
            ),
            Text(
              'sign in to continue',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 40,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Form(
                key: _loginKey,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      style: TextStyle(fontSize: 20),
                      textInputAction: TextInputAction.done,
                      maxLines: 1,
                      obscureText: false,
                      validator: isEmail,
                      onSaved: (val) {
                        email = val;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      style: loginFormTextStyle,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      maxLines: 1,
                      validator: isPassword,
                      onSaved: (val) {
                        pwd = val;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(hintText: 'Password'),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: RaisedButton(
                            onPressed: () {
                              _onLogin();
                            },
                            elevation: 0,
                            color: Colors.grey.shade200,
                            padding: EdgeInsets.all(20),
                            child: Visibility(
                              child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation(
                                        Theme.of(context).indicatorColor,
                                      ))),
                              visible: _isWorking,
                              replacement: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Get Started',
                                    style: loginFormTextStyle,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.arrow_forward)
                                ],
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
