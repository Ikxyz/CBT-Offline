/// All Import Used By App
///

/// @External Packages
export 'package:flutter_web/material.dart';

/// @Splash Screen

export 'splash.dart';

/// @Route
///

export 'routes/home.dart';
export 'routes/login.dart';
export 'routes/question.dart';
export 'routes/white_paper.dart';


/// @External Plugins
export 'package:flutter/material.dart';
export 'package:path_provider/path_provider.dart';
export 'package:provider/provider.dart';
import  'package:sqflite/sqflite.dart';
export 'dart:async';
export 'dart:io';
export 'dart:math';
export 'package:crypto/crypto.dart';
export 'dart:convert';
export 'package:image_picker/image_picker.dart';
export 'package:firebase_storage/firebase_storage.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// @Utils
export 'utils/constant.dart';
export 'utils/custom_navigation.dart';
export 'utils/timeline_painter.dart';

/// @Helper Classes
export 'classes/auth.dart';
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
export 'classes/errand_class.dart';

/// @Widget
export 'widgets/fieldTemplate.dart';
export 'widgets/avatar_selector.dart';
export 'widgets/input_type_widget.dart';
export 'widgets/timeline_item.dart';
export 'widgets/timeline_widget.dart';
export 'widgets/dialog_base.dart';
export 'widgets/agent_item.dart';

 
 

// #Application
export 'routes/main/app.dart';
export 'routes/main/main_screen.dart';
export 'routes/login.dart';

// #Model
export 'models/template_model.dart';
export 'models/field_model.dart';
export 'models/agent_model.dart';

// @Bloc
export 'bloc/template_bloc.dart';


// @Style
export 'styles/styles.dart';

Firestore fsDb = Firestore.instance;
FirebaseAuth fAuth = FirebaseAuth.instance;