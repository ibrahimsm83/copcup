import 'package:flutter/material.dart';

ColorScheme colorScheme(context) => Theme.of(context).colorScheme;

TextTheme textTheme(context) => Theme.of(context).textTheme;

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

const String isLoggedInText = 'isLoggedIn';
const String emailText = 'email';
const String id = 'id';
const String sellerEventId = 'sellerEventId';
const String appLanguage = 'Language';

const String passwordText = 'password';
const String roleText = 'roleText';
