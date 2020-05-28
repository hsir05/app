import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../bottom_menu.dart';


Handler homeHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>>params) {
  return BottomPage();
});

