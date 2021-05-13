import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/tabs_page.dart';

void main() => runApp(NewsApp());

class NewsApp extends StatelessWidget {
  const NewsApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabsPage(),
    );
  }
}
