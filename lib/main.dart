import 'package:flutter/material.dart';

import 'package:flutter4/pages/home/home.page.dart';
import 'package:flutter4/pages/info/info.page.dart';
import 'package:flutter4/shared/head.dart';

void main() {
	runApp(MyApp());
}

class MyApp extends StatefulWidget {
	MyApp({Key key}): super(key: key);
	
	@override
	MyAppState createState() => MyAppState();
}

class MyAppState extends State {
	int _currentPage = 0;
	List<Widget> _pages = [
		HomePage(),
		InfoPage(),			
	];

	@override 
	Widget build(BuildContext context) {
		return MaterialApp(			
			title: "Diamond Camera",
			theme: ThemeData(
				textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white)
			),
			home: Scaffold(
				appBar: Head(),
				body: Container(
					child: Padding(
						child: _pages.elementAt(_currentPage),
						padding: EdgeInsets.all(10),
					)
				),
				bottomNavigationBar: BottomNavigationBar(
					items: [
						BottomNavigationBarItem(
							icon: Icon(Icons.home),
							title: Text("Home"),
						),						
						BottomNavigationBarItem(
							icon: Icon(Icons.help),
							title: Text("Info"),
						),
					],
					currentIndex: _currentPage,
					fixedColor: Colors.grey,
					backgroundColor: Color.fromRGBO(0, 0, 0, 1),
					unselectedItemColor: Color.fromRGBO(255, 255, 255, 1),					
					onTap: setCurrentPage,
				),
				backgroundColor: Color.fromRGBO(35, 35, 35, 1),				
			)
		);
	}

	void setCurrentPage(int index) {
		setState(() => {_currentPage = index});
	}
}
