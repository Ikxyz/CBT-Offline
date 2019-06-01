import 'package:cbt_offline/import.dart';
import 'package:path/path.dart' as $path;


String getID({length: 28}) {
  const chars =
      "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
  String result = "";
  for (var i = 0; i < length; i++) {
    result += chars[rnd.nextInt(chars.length)];
  }
  return result;
}

/// return an error message if value does not pass the validation
///validation requires val: not equal null
String isNotNull(val) {
  return val.toString().isNotEmpty ? null : 'Can\'t be left empty ';
}

/// return an error message if value does not pass the validation
///validation requires val: not equal null, must contain @ char, must contain dot('.') and length must be more than 4 characters
String isEmail(val) {
  return val.toString().isNotEmpty &&
          val.toString().contains('@') &&
          val.toString().contains('.') &&
          val.toString().length > 4
      ? null
      : 'enter a valid email ';
}

/// return an error message if value does not pass the validation
///validation requires val: not equal null and length must be more or equal to 10 characters
String isNumber(val) {
  try {
    val = int.parse(val.toString());
  } on Exception catch (e) {
    val = 0;
  }

  return val > 100 && val.toString().isNotEmpty
      ? null
      : 'Telepnone number mush be 10 digit';
}

/// return an error message if value does not pass the validation
///validation requires val: not equal null and length must be more than 7 characters
String isPassword(val) {
  return val.toString().isNotEmpty && val.toString().length > 7
      ? null
      : 'Password must be up to 8 characters';
}

/// return a double of current width
double getWidth(context, {val}) {
  if (val == null) return MediaQuery.of(context).size.width;
  return ((val / 100) * MediaQuery.of(context).size.width);
}

/// return a double of screen height.
double getHeight(context, {val}) {
  if (val == null) return MediaQuery.of(context).size.height;
  return ((val / 100) * MediaQuery.of(context).size.height);
}

/// Get default image from avatar API
String getDefaultImageUrl(email) =>
    'https://www.gravatar.com/avatar/${getHash(email.toString().trim().toLowerCase())}?s=200&d=identicon';

// Get hash values
String getHash(data) {
  if (data == null) return null;
  var bytes = utf8.encode(data); // data being hashed
  var hash = sha1.convert(bytes);

  // print("Digest as bytes: ${hash.bytes}");
  // print("Digest as hex string: $hash");
  return hash.toString();
}

/// Navigate to a new route by passing a route widget with a fade animation
/// animation duration is 1 seconds
void navigate(
  context,
  to,
) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) {
        return to;
      },
      transitionsBuilder: (context, animation1, animation2, child) {
        return FadeTransition(
          opacity: animation1,
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 1000),
    ),
  );
}

 

/// Signin with federated account
//dynamic signInWith({GlobalKey<ScaffoldState> state}) async {
//  GoogleSignIn _googleSignIn = GoogleSignIn();
//  FirebaseAuth _auth = FirebaseAuth.instance;
//  // GoogleSignInAccount _userAccount = await _googleSignIn.signIn();
//  // GoogleSignInAuthentication _validate = await _userAccount.authentication;
//
//  // final AuthCredential _authCredential = GoogleAuthProvider.getCredential(
//  //     accessToken: _validate.accessToken, idToken: _validate.accessToken);
//
//  final user = await _auth.signInAnonymously();
//  print("signed in " + user.uid);
//  if (state != null)
//    state.currentState.showSnackBar(new SnackBar(
//      content: Text('Signed in anonymously'),
//    ));
//  return user;
//}

 

/// Show
showSnackBar(GlobalKey<ScaffoldState> _scaffoldState, String content) {
  if (content == null) return;
  if (_scaffoldState.currentState == null) return;
  _scaffoldState.currentState.showSnackBar(SnackBar(
    content: Text(content),
  ));
}



/// Pop up a dialog box with a button that carry a callback function ,
/// Also you can set the dialog theme color (optional),button icon(optional),title and desc
/// Default Theme color is Red
void showDialogBox(
    {@required context,
    @required title,
    @required desc,
    color: Colors.blue,
    icon: Icons.info_outline,
    buttonText: "Close",
    Function callBack}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: new Card(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: new Column(
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          color: color,
                          fontSize: 20,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(child: new Text(desc)),
                      SizedBox(
                        height: 10,
                      ),
                      new Center(
                        child: RaisedButton.icon(
                            shape: StadiumBorder(),
                            textColor: Colors.white,
                            color: color,
                            onPressed: () {
                              try {
                                callBack();
                              } catch (err) {}
                              Navigator.of(context).pop();
                            },
                            icon: Icon(icon),
                            label: Text(buttonText)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      });
}

/// Takes a Widget, optional opacity and optional image String and
/// Returns a new widget with an image as its background set to the passed in opacity
/// Default Opacity: 0.5
dynamic customBackground(
    {@required child, opacity: 0.5, String image: 'assets/image/grocery.png'}) {
  return new Container(
    decoration: new BoxDecoration(
      image: new DecorationImage(
        image: AssetImage(image),
        fit: BoxFit.cover,
      ),
    ),
    child: new BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: new Container(
        child: child,
        decoration: new BoxDecoration(color: Colors.white.withOpacity(opacity)),
      ),
    ),
  );
}

Map<String, dynamic> jsonNotifications({title, desc, type, status, time}) => {
      'title': title,
      'desc': desc,
      'type': type,
      'status': status,
      'time': time
    };

Map<String, dynamic> jsonMessage(
        {id, msg, type, status, to, from, canRead, dynamic time}) =>
    {
      "id": id,
      "msg": msg,
      "type": type,
      "status": status,
      "time": time,
      "from": from,
      "to": to
    };

Map<String, dynamic> jsonPayment(
        paymentId,
        agentUid,
        clientUid,
        amount,
        status,
        requestPayment,
        makePayment,
        confirmPayment,
        hasPaid,
        time,
        startTime,
        endTime) =>
    {
      "paymentId": paymentId,
      "agentUid": agentUid,
      "clientUid": clientUid,
      "amount": amount,
      "status": status,
      "requestPayment": requestPayment,
      "makePayment": makePayment,
      "confirmPayment": confirmPayment,
      "hasPaid": hasPaid,
      "time": time,
      "startTime": startTime,
      "endTime": endTime,
    };
Map<String, dynamic> jsonUserProfile(
        {firstName,
        lastName,
        email,
        pwd,
        retypePwd,
        tel,
        state,
        isAdmin,
        isAgent,
        isDev,
        isMember,
        isOrg,
        address,
        city,
        country,
        zip,
        passport,
        identification,
        utilityBill,
        uid,
        latitude,
        longitude,
        time,
        isVerified}) =>
    {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "pwd": pwd,
      "retypePwd": retypePwd,
      "tel": tel,
      "address": address,
      "city": city,
      "state": state,
      "isAdmin": isAdmin != null ? isAdmin : false,
      "isAgent": isAgent != null ? isAgent : false,
      "isDev": isDev != null ? isDev : false,
      "isMember": isMember != null ? isMember : true,
      "isOrg": isOrg != null ? isOrg : false,
      "country": country,
      "zip": zip,
      "passport": passport,
      "identification": identification,
      "utilityBill": utilityBill,
      "uid": uid,
      "time": time,
      "isVerified": isVerified != null ? isVerified : false,
      "latitude": latitude,
      "longitude": longitude
    };

Map<String, dynamic> jsonUserContacts() => {
      "uid": null,
      "time": null,
    };

Map<String, dynamic> jsonPickUpRequest({
  String url: '',
  String uid: '',
  String agentUid: '',
  bool isProcessing: false,
  bool isComplete: false,
  dynamic requestTime,
  dynamic completeTime,
  dynamic acceptTime,
}) =>
    {
      "url": url,
      "uid": uid,
      "agentUid": agentUid,
      "isProcessing": false,
      "isComplete": false,
      "requestTime": requestTime == null ? DateTime.now().toUtc() : requestTime,
      "completeTime": null,
      "acceptTime": null,
    };
