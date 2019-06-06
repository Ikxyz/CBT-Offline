/// All Import Used By App

/// @External Packages
export 'package:flutter_web/material.dart';
export 'dart:async';
export 'package:crypto/crypto.dart';
export 'package:sembast/sembast.dart';
export 'package:random_string/random_string.dart';
export 'dart:convert';
//import 'package:firebase/firebase.dart';


/// @Splash Screen

export 'splash.dart';

/// @Route

export 'routes/home.dart';
export 'routes/login.dart';

/// @Utils
export 'utils/constant.dart';
export 'utils/custom_navigation.dart';

/// @Helper Classes
export 'classes/classes.dart';
export 'classes/custom-clip.dart';
export 'classes/message_class.dart';
export 'classes/notification_class.dart';
export 'classes/payment_class.dart';
export 'classes/start_up.dart';
export 'classes/user_contact_class.dart';
export 'classes/user_profile_class.dart';
export 'classes/route_animations.dart';
export 'classes/start_up.dart';

// @Style
export 'styles/styles.dart';

// @Componnets
export 'components/newExamSheet.dart';
export 'components/white_paper.dart';
export 'components/setting.dart';
export 'components/prepare_result.dart';
export 'components/dashboard.dart';
export 'components/conductExam.dart';
export 'components/primary_exam_session.dart';

// @Bloc
export 'bloc/drawer_index.dart';
export 'bloc/examBloc.dart';


// @Model
export 'model/question.dart';
export 'model/exam_sheet_model.dart';
export 'model/primary_exam_session_model.dart';
export 'model/student_exam_session.dart';

// @Client
export 'client/client_home.dart';
export 'client/continue_student_exam_session.dart';
export 'client/student_exam_sheet.dart';
//
//final db = firestore(FirebaseOptions());


import 'dart:convert';
import 'dart:html';


Storage storage = window.localStorage;

Map<String,dynamic> getUser()=>jsonDecode(storage['user']);
