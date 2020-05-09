import 'package:flutter/material.dart';

import 'package:flutter4/page.widgets/home/home.page.dart';
import 'package:flutter4/page.widgets/info/info.page.dart';

void main() {
	runApp(MyApp());
}

class MyApp extends StatefulWidget {
	MyApp({Key key}): super(key: key);
	
	@override
	_MyAppState createState() => _MyAppState();
}

class _MyAppState extends State {
	@override 
	Widget build(BuildContext context) {
		return MaterialApp(			
			title: "Diamond Camera",
			theme: ThemeData(
				textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white)
			),
			initialRoute: "/",
			routes: {
				"/": (context) => HomePage(),
				"/info": (context) => InfoPage(),
			},			
		);
	}	
}
