import 'package:flutter/cupertino.dart';

import 'assets.dart';

List<Widget> techStack = [
  Row(
    children: [
      Image.asset(
        Assets.flutter,
        height: 100,
        width: 100,
      ),
      Text("Flutter"),
    ],
  ),
  Row(
    children: [
      Image.asset(
        Assets.firebase,
        height: 100,
        width: 100,
      ),
      Text("Firebase"),
    ],
  ),
  Row(
    children: [
      Image.asset(
        Assets.gcp,
        height: 100,
        width: 100,
      ),
      Text("Google Cloud Platform"),
    ],
  ),
  Row(
    children: [
      Image.asset(
        Assets.aws,
        height: 100,
        width: 100,
      ),
      Text("Amazom Web Services"),
    ],
  ),
  Row(
    children: [
      Image.asset(
        Assets.mongodb,
        height: 100,
        width: 100,
      ),
      Text("Mongo DB"),
    ],
  ),
  Row(
    children: [
      Image.asset(
        Assets.nodejs,
        height: 100,
        width: 100,
      ),
      Text("Node JS"),
    ],
  )
];
